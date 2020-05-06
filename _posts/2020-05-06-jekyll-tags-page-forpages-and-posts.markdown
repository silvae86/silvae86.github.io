---
layout: post
title:  "Creating Tag page in Jekyll that considers both pages and posts (GitHub pages compatible!)"
date:   2020-05-06 18:44:000 +0100
tags: jekyll liquid programming template github pages tags pure-liquid no-plugins
---

After a lot of debugging I finally can render a Tags page for Jekyll that:

- Does not use any plugins, for complete compatibility with GitHub pages!
  - If you do not need to host on Github pages, take a look at this plugin, [jekyll-tagories](https://rubygems.org/gems/jekyll-tagories). Source code on [GitHub](https://github.com/ashmaroli/jekyll-tagories/).
- Considers `tags:` in both pages and posts. The Jekyll team has decided [not to support this](https://github.com/jekyll/jekyll/issues/6291) after discussing it on GitHub, BTW.
  - Within each tag of the list, combines the posts and pages that are tagged with that particular tag, **sorts them by title** and prints the list, so that for every tag you get a list of alphabetically ordered pages/posts.
- [Demo here]({%- link _pages/tags.md -%})

The page is hacky, but it is what I could manage using pure Liquid language. It is not that slow as it may seem at first, however. It added 0.5 seconds of build time to this blog, more or less, on my [Lenovo T420]({% link _posts/2019-02-10-my-hacked-lenovo-t420.markdown %})

## The code

Check it out on my GitHub [here](https://raw.githubusercontent.com/silvae86/silvae86.github.io/master/_pages/tags.md).
