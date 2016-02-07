---
layout: post
title:  "Functional Reactive Programing and Elm"
date:   2016-02-06 13:00:28 -0500
categories: jekyll update
---

After a long detour into the world of functional programming based on Haskell (yes that does mean some Category theory and Monads too, which I will blog about later), I came across a talk by [Evan Czaplicki][Czaplicki-talk] and decided to explore Elm.

In this series of blogs I will outline some insights that document my learning process and hope that it will be a useful introduction to Elm and Functional Reactive programming for all.

Elm is a functional, ML like language and at least for me I found the transition to Elm from Haskell fairly easy.

So let us start with the customary Hello World program.
{% highlight Haskell %}
import Html
import Html.Attributes exposing (class)

main =
    Html.span [class "welcome-message"] [Html.text "Hello, World!"]


{% endhighlight %}

Check out the [online editor/runner.][try-elm] to run all the code samples without an install.
You will find all the documentation of the core libraries at [Elm core website][elm-core]. And finally if you need packages or info on packages you can find it [here][elm-packages].

[try-elm]: http://elm-lang.org/try
[elm-core]:http://package.elm-lang.org/packages/elm-lang/core/3.0.0/
[elm-packages]: http://package.elm-lang.org/
[Czaplicki-talk]: https://www.youtube.com/watch?v=ZTliDiWDV0k
