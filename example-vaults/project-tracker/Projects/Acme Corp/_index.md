---
type: project-moc
project: Acme Corp
status: active
started: 2026-05-01
---

# Acme Corp

## Overview

Infrastructure modernization engagement. Acme is migrating a legacy monolithic application to a containerized architecture on AWS. Initial scope is 12 weeks; we're responsible for architecture design, migration planning, and engineering oversight.

## Key contacts

- Jordan Rowe — CTO, primary sponsor
- Sam Delacroix — lead engineer, day-to-day
- Taylor Kim — project manager on their side

## Objectives

- Define target architecture (containers + managed services)
- Produce migration runbook with rollback plans
- Upskill their engineering team on the new stack
- Complete initial migration of 2 non-critical services by end of week 8

## Open threads

- [ ] Share architecture diagram with Jordan for sign-off (due 2026-05-28)
- [ ] Get access to their staging environment
- [ ] Confirm which services migrate first (waiting on Sam)
- [ ] Schedule week 3 check-in

## Notes

- [[Architecture Overview]] — proposed target state, current blockers

## Meetings

- [[2026-05-01 Kickoff]] — aligned on scope, key contacts, first deliverables

## Decisions made

- 2026-05-01 — Use ECS Fargate over self-managed Kubernetes — rationale: team has no K8s experience, managed service reduces ops burden
- 2026-05-01 — Start with the reporting service as first migration candidate — rationale: lowest traffic, fewest dependencies, good test case

## Related projects
