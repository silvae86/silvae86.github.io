---
layout: page
title: HTML 5 Exercises
permalink: /teaching/exercises/html/html5/
crumbtitle: HTML5
tags: exercises html html5 feup programming teaching web development exercises
---

## Online Newspaper

Using HTML 5 only, create a prototype of an online newspaper.

Validate and verify the result on the browser as you proceed. Don’t mind about the visual aspect of the result (that will be taken care by using CSS).

- Use the site [http://www.lipsum.com/](http://www.lipsum.com/) if you need to generate example paragraphs.
- Create separate **sections** for the header, menu and body of the newspaper. Use semantic tags (**section**, **header**, **nav**, ...) for those sections...
- The header should have a title (**h1**), a subtitle (**h2**) and a logo (**img**).
- The menu should have links to each of the newspaper sections (sports, politics,...) organized using an unordered list (**ul**). These links can simply point to example URLs.
- The newspaper body should have a section for each news item. Use the semantic tag article.
- A news item should have a title (**h3**), an introduction (**p**) and an image (**img**). It should also have a footer containing the author name and date.
- Don’t forget to [validate](https://validator.w3.org/) the page when you’re done.

## Table

Using HTML 5 only, create a document representing the following table. Use the attribute `border="1"` to better visualize the result.

```html
<!DOCTYPE html>
<html lang="en-US">
  <head>
    <title>Table</title>
    <meta charset="UTF-8">
  </head>
  <body>
    <table border="1">
    ...
    </table>
  </body>
</html>
````

![exercise-table-html5](table.png){:class="img-center"}

- Validate the HTML code using the online W3C validator.
- Include a [valid HTML 5](https://www.google.com/search?q=valid+html5&tbm=isch) icon on the webpage.
- Revalidate the document.

## Form

Create a web page containing a form where users should input the following data:

- Name (text)
- Age (radio buttons with option <18, 19-35, 36-48 and >49))
- Profession (text)
- Country (dropdown)
- Interests (list where user can select several - make up some choices)
- How did the user found out about the site (larger text field)

Don’t forget that:

- The form should have a submit button.
- Each field should have a label.
- You should validate the page in the end.
- Try to submit the form and verify what happens in the URL bar using post and get as the form methods.

## Use HTML to create your profile in a social network

The profile should contain:

- Site header (Site name, ...)
- Menu (Links to the various site sections: friends, messages, ...)
- Personal Data (name, photo, ...)
- Posts (including: text, date, image, comment number, ...)
- Try to use semantic tags as much as possible and don’t forget to validate the resulting file.

## Solutions for these exercises

[Solutions](/teaching/solutions/html/html5/)

## Acknowledgement

Exercises by [André Restivo](https://web.fe.up.pt/~arestivo/).
