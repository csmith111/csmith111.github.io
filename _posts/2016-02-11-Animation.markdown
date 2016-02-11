---
layout: post
title:  "Functional Reactive Programing with Elm: Part V - Animation"
date:   2016-02-11 13:00:28 -0500
summary:  In this post we will look how Elm enables us to write functional reactive programs that include animation.
categories: jekyll update
---

Now that we have understood Signals and Graphics in Elm, it is rather easy to create Animations.

### Mouse Signals

{% highlight Haskell %}
import Html exposing (..)
import Html.Attributes exposing (..)
import Mouse


animatedImage w =
  img
    [src "http://elm-lang.org/imgs/yogi.jpg"
    ,style
       [("width", toString (10*w) ++ "px")
       ]
    ][]

main = Signal.map animatedImage Mouse.x

{% endhighlight %}

Try this out by pasting this code in the [online editor/runner.][try-elm] You should see that the image size is animated based on the x coordinate of the Mouse withing the window.

Let us see if we can understand this code. The first thing is to create a function that displays an image (Feel free to replace this image with any image you like to animate and continue the exercises). This function `animatedImage` takes one parameter as input which set the width of the the image. 

Now in order to animate it we need to map this function over a Signal that contains your mouse x coordinates. But we know how to do that from our examples using Signals; just use Signal.map.  



[Signals-elm-lang]:http://elm-lang.org/guide/reactivity#signals
[Elm Basics]: https://csmith111.github.io/jekyll/update/2016/02/07/ASecondBlogPost.html
[Time Docs]:http://package.elm-lang.org/packages/elm-lang/core/3.0.0/Time#fps
[try-elm]: http://elm-lang.org/try
[SignalModule]:http://package.elm-lang.org/packages/elm-lang/core/3.0.0/Signal
