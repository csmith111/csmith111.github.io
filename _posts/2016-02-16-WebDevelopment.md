---
layout: post
title:  "Functional Reactive Programing with Elm: Part VII -  Web Development"
date:   2016-02-12 13:00:28 -0500
summary:  In this post we will look at how to build Web Applications using Elm. You will get to see how the functional style of programming allows us to build web applications that are more "modular and composable". We will use Signals, Tasks and Mailboxes to deal with interaction and asynchronous programming.  

categories: jekyll update
---

The first thing that we need to look at in developing web application is the support for HTML. Elm has a built in DSL that incorporates the basic html elements.
The elm code that governs behavior is transpiled into Javascript and embedded into the html page, which then is run by the browser.
We can incorporate CSS to style the pages as required.
