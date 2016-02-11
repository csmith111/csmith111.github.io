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


animatedYogi w =
  img
    [src "http://elm-lang.org/imgs/yogi.jpg"
    ,style
       [("width", toString (10*w) ++ "px")
       ]
    ][]

main = Signal.map animatedYogi Mouse.x

{% endhighlight %}

Try this out by pasting this code in the [online editor/runner.][try-elm]


[Signals-elm-lang]:http://elm-lang.org/guide/reactivity#signals
[Elm Basics]: https://csmith111.github.io/jekyll/update/2016/02/07/ASecondBlogPost.html
[Time Docs]:http://package.elm-lang.org/packages/elm-lang/core/3.0.0/Time#fps
[try-elm]: http://elm-lang.org/try
[SignalModule]:http://package.elm-lang.org/packages/elm-lang/core/3.0.0/Signal


Okay…so here is the email… Let me know if you get it.
It was so nice to talk to you again after such a long time.. apologies if my timing was not good?!
So much to talk about..

Recall a line from the arjit singh song…(have you heard it)
"Kya uss gali mein kabhi tera jaana hua
Jahaan se zamaane ko guzre zamaana hua
Mera samay toh wahin pe hai thehra hua
Bataaun tumhe kya mere sath kya cya hua"

It was nice to hear your voice again...
