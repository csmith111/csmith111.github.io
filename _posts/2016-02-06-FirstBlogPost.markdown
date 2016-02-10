---
layout: post
title:  "Functional Reactive Programing with Elm: Part I - HTML"
date:   2016-02-06 13:00:28 -0500
summary:  I am recording my experiences using Elm. I hope that you will be able to experiment with Elm and explore the possibilities of simplifying the code we use to create user interfaces using functional languages to provide composition and functional reactive programing to manage interactivity.
categories: jekyll update
---

After a long detour into the world of functional programming based on Haskell (yes that does mean some Category theory and Monads too, which I will blog about later), I came across a talk by [Evan Czaplicki][Czaplicki-talk] and decided to explore Elm.

In this series of blogs I will outline some insights that I have gleaned from listening to Evan (who is a very effective speaker) and working through the code examples in the documentation. I hope that it will be a useful introduction to Elm and Functional Reactive programming.

Elm is a functional, ML like language and I found the transition to Elm from Haskell fairly easy. The ease with which you could create performant, modular/composable user interfaces with Elm was what I found most interesting.

So let us start with the customary Hello World program.
{% highlight Haskell %}
import Html

main =
   Html.text "Hello, World!"
{% endhighlight %}

You can just enter this code in the [online editor/runner.][try-elm] This way you can run all the code samples without getting side tracked into an install.
You will find all the documentation of the core libraries at [the Elm core website][elm-core]. And finally if you need additional packages or info on packages you can find it [here][elm-packages].

What we are seeing here is that there is a package elm-html that defines a set of functions that behaves as a DSL for HTML.
so  
`Html.text : String -> Html`
is a function defined in the package elm-html that puts text onto the HTML DOM tree.

By including the Html.Attributes module you can set the attributes of the html elements.
{% highlight Haskell %}
import Html exposing (..)
import Html.Attributes exposing (..)

astyledMessage =
  div [Html.Attributes.style[("font-style", "bold")
      ,("font-size", "50px")
      ,("color", "blue")
      ]]
      [text "Hello World"]

main =astyledMessage
{% endhighlight %}


As an exercise try to create the hello world text using more html attributes and get comfortable with setting all the html text properties.

And finally since we have access to images a picture is worth a thousand words!

{% highlight Haskell %}
import Html exposing (..)
import Html.Attributes exposing (..)

astyledMessage =
  div [Html.Attributes.style[("font-style", "bold")
      ,("font-size", "50px")
      ,("color", "blue")
      ]]
      [text "Hello World"]

helloWorldPic =
  img [src "http://sourcefed.com/wp-content/uploads/2014/12/world.jpg"
   ,style
     [("width",  "400px")
        ,("height", "400px")
     ]
  ][]

main =div[][astyledMessage, helloWorldPic]

{% endhighlight %}

Okay so this post should have given you some flavor of the representation of Html with a DSL. For those who know HTML this is no big deal, but it lays the foundation for being able to generate and manipulate HTML and the DOM tree programmatically.

[try-elm]: http://elm-lang.org/try
[elm-core]:http://package.elm-lang.org/packages/elm-lang/core/3.0.0/
[elm-packages]: http://package.elm-lang.org/
[Czaplicki-talk]: https://www.youtube.com/watch?v=ZTliDiWDV0k
