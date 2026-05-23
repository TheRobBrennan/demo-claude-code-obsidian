---
tags: [acme-corp, architecture, technical]
project: Acme Corp
status: draft
---

# Architecture Overview — Acme Corp

Working notes for the architecture proposal. Not the final document — that goes to the client as a separate deliverable.

## Current state

```text
Internet → ALB → EC2 (Rails monolith, 3 instances) → RDS PostgreSQL
                 ↑
                 S3 (file uploads, handled in-app)
```

Notable: they have a background job processor (Sidekiq) running on the same EC2 instances. This needs to move separately.

## Target state (proposed)

```text
Internet → ALB → ECS Fargate (web service)
                 ECS Fargate (worker service / Sidekiq)
                 ECS Fargate (reporting service) ← first migration
                 ↓
                 RDS PostgreSQL (no change)
                 S3 (no change)
                 ElastiCache Redis (for Sidekiq, replacing current in-process)
```

All services pull config from AWS Secrets Manager. ECR for container images. GitHub Actions for CI/CD.

## Open questions / blockers

- **Redis:** Currently Sidekiq connects to Redis running on the same EC2. Do they have Redis in their environment at all? Need to confirm with Sam. If not, ElastiCache or a small self-hosted Redis on EC2.
- **Secrets management:** How are secrets currently handled? If they're baked into environment files on EC2, we need a migration plan before any containerization.
- **Session storage:** Rails session — where does it live? If it's in-memory (bad) or on the instance, this is a problem in a multi-container world. Need cookie-based or Redis-backed sessions.
- **File uploads:** S3 already — good. But need to confirm they're not writing anything to local disk (tmp files, generated PDFs, etc.).

## Decisions / rationale

| Decision | Rationale |
| --- | --- |
| ECS Fargate, not EKS | No K8s experience on their team; managed service reduces ops burden |
| ECR for images | Simplest integration with ECS; no additional cost for small teams |
| Secrets Manager over Param Store | Better secret rotation support; worth the marginal cost |
| RDS stays as-is | Already managed, no migration risk needed |

## Migration sequence

1. Reporting service (weeks 3–7) — lowest risk, good test case
2. Worker service (weeks 6–9) — depends on Redis being resolved
3. Main web service (weeks 9–11) — highest risk, most traffic, most dependencies

## Risks

- **Session handling** — if they're using server-side sessions, this could block the main service migration
- **Local disk writes** — any code that writes to `/tmp` or local paths will break in containers
- **Month-end reporting window** — Taylor needs to confirm this before we schedule the reporting service migration
