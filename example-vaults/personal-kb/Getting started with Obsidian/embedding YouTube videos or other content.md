Let's try embedding the latest video from my band - Wyatt Olney & The Wreckage.
https://www.youtube.com/watch?v=GDs6Ng3Yfuw

I just pasted in the URL and all I get is a link - not a preview/embed.

I oversimplified in my last response — sorry about that. Obsidian does **not** natively embed YouTube as a player. To actually embed a video you need the iframe syntax:

```
<iframe width="560" height="315" src="https://www.youtube.com/embed/VIDEO_ID" frameborder="0" allowfullscreen></iframe>
```

Note the URL format change — it's `/embed/VIDEO_ID`, not the standard watch URL.

---

## The easier path: Media Extended plugin

The community plugin **[[Media Extended]]** handles this properly — paste a YouTube URL and it renders as an actual embedded player without manually writing iframes. It also handles timestamps, playback speed, and other media types.

Install it the same way as Image Toolkit: **Settings → Community plugins → Browse → search "Media Extended" → Install → Enable**.

Let's try pasting in a YouTube URL now. Doesn't work. We need to paste in a YouTube link as a Markdown image:

```
![](https://www.youtube.com/watch?v=GDs6Ng3Yfuw)
```

![](https://www.youtube.com/watch?v=GDs6Ng3Yfuw)


---

## For URL bookmark previews (like Notion)

The plugin **[[Link Embed]]** or **Auto Link Title** are the closest equivalents — they fetch page metadata and render a visual card. Neither is as seamless as Notion's bookmark block, but they're the best Obsidian has.

Let's try the Link Embed plugin for my website:

```embed
title: "Sploosh.AI"
image: "https://sploosh.ai/assets/img/logo/w_SplooshAI_logo.png"
description: "Sploosh.AI | AI for All: Uncover Possibilities. Not Prohibitive Costs."
url: "https://www.sploosh.ai"
favicon: ""
aspectRatio: "27.76735459662289"
```
