---
layout: post
title:  "What is the difference between REST and AJAX?"
date:   2018-12-14 19:00:00 +0000
tags: ltw feup mieic student questions rest api ajax
---

A question from one of my students at the Languages and Web Technologies class at FEUP.

## Question

> Good afternoon professor,
>
> As for the rest of the rest api, I can not fully understand how it stands apart from the ajax implemented in our work. Could you clarify to me the major differences between the two? At the moment I only see similarities in our work.
>
> Thank you,
> A student

## Reply

Hello A Student,

[AJAX](https://en.wikipedia.org/wiki/Ajax_(programming)) and [REST (Representational State Transfer) API](https://stackoverflow.com/questions/671118/what-exactly-is-restful-programming) are two different things. There is much more that can be said about REST, but in 2 minutes here are some main differences between the two.

- One is the use of a set of technologies (Asynchrononous Javascript And XML) that is used to make _asynchronous_ requests (the browser / client does not know when the response arrives nor is it blocked waiting, but rather registers a handler that will be called when the response _eventually_ arrives) to the server and to process the answer of the client side to, for example, modify the HTML of a shopping list after adding something to the cart.

- REST is an architecture standard for structuring your applications, and is applied mainly on the server. It defines what endpoints are available on the server and how a client can interact with them.

REST proposes, among other things, the use of URLs that identify each resource and the use of different HTTP verbs to act on this resource. Here is a practical example:

### Not RESTful

A not-RESTful architecture will not follow a specific convention of identifying a resource and the HTTP verbs to perform CRUD operations over that resource. Example:

| HTTP verb | CRUD Operation | Body (if POST or PUT)                            | URL                     |
| --------- | -------------- | ------------------------------------------------ | ----------------------- |
| POST      | Create         | title=example title; text=LTW parte-nos a cabeça | /add_new_post.php       |
| GET       | Read           | (no body, arguments in the URLs)                 | /view_post.php?**id=1** |
| POST      | Update         | post_id = 1 ; text=LTW parte-nos a cabeça        | /edit_post.php          |
| POST      | Delete         | post_id = 1                                      | /delete_post            |

### RESTful

REST specifies, among other things, patterns for how your URLs should be created (using them to uniquely identify a resource in the system) and then links CRUD operations over that resource to HTTP verbs. Quoting from [this website on HTTP verbs in PHP](https://www.giorgiosironi.com/2010/04/http-verbs-in-php.html):

> Of these methods, the more interesting ones due to their usage in RESTful applications are GET, POST, PUT and DELETE:
> - GET is a safe, idempotent method and it is used to retrieve a resource.
>
> - POST is considered a catch-all method nowadays, but its intent is defining a subordinate resource to the current one. For instance, posting to a blog resource may create a new post.
>
> - PUT is the analogue of GET used to send a resource to the HTTP server.
>
> - DELETE is the analogue of GET used to, of course, delete a particular resource.

Here is the same example, but RESTful:


| HTTP verb | CRUD Operation | URL                                                               |
| --------- | -------------- | ----------------------------------------------------------------- |
| PUT       | Create         | /post.php (in body goes all data needed to create a **new post**) |
| GET       | Read           | /post.php?id=1                                                    |
| POST      | Update         | /post.php                                                         |
| DELETE    | Delete         | /post.php?id=1                                                    |

### The difference

You are perhaps confused from the fact that for your AJAX you have built a page to return JSON (which can be seen as an API endpoint), but REST specifies (among other things) a set a set of constraints that your server's page structure should follow to be RESTful.

AJAX can use a server which provides a REST API, but is more concerned with the flow of the information between the server and the client (in this case browser) and how to process the data after it receives server responses to build a dynamic interface that does many things at once at the page (hence the need for asynchronous requests), without having to refresh the entire page.

## Taking things further: Content Negotiation

To build an API that shares the same URLs as the website, you may return JSON if the `Accept` header sent by the client is `application/json` or HTML if the header is not specified or is `text/html`. This is very useful if you want to avoid having a `/api` sub-uri for all machine-oriented actions on your website. This mechanism, called [Content Negotiation](https://developer.mozilla.org/en-US/docs/Web/HTTP/Content_negotiation), is really cool to serve the same resource to different clients, depending on what they need, using the same URL.

In practice:
- A human would access the page (say `/post.php?id=1`) normally via the browser, which always requests HTML by default, so the `Accept:` header is always `text/html`. The server would check for that header and serve him HTML.
- An Android app would send a request to the same url (`/post.php?id=1`) but would specify `application/json` as the `Accept:` header. The server checks for this and responds with JSON instead.

How cool is that?

## Reading links

- [HTTP (LTW slides By André Restivo)](https://web.fe.up.pt/~arestivo/presentation/http)
- [AJAX](https://en.wikipedia.org/wiki/Ajax_(programming))
- [REST](https://en.wikipedia.org/wiki/Representational_state_transfer)
- [What exactly is RESTful programming?](https://stackoverflow.com/questions/671118/what-exactly-is-restful-programming)
- [HTTP Verbs in PHP (for detecting the verb of the HTTP request)](https://www.giorgiosironi.com/2010/04/http-verbs-in-php.html)
- [MIME Types (for the Accept: header in Content Negotiation)](https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/MIME_types)
