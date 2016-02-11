---
layout: post
title:  "Functional Reactive Programing with Elm: Part V - Animation"
date:   2016-02-11 13:00:28 -0500
summary:  In this post we will look how Elm enables us to write functional reactive programs that include animation.
categories: jekyll update
---

Now that we have understood Signals and Graphics in Elm, it is rather easy to create Animations.

### Animation using Mouse Signals

{% highlight Haskell %}
import Html exposing (..)
import Html.Attributes exposing (..)
import Mouse


animatedImage w h =
  img
    [src "http://elm-lang.org/imgs/yogi.jpg"
    ,style
       [("width", toString w ++ "px")
        ,("height", toString h ++ "px")
       ]
    ][]

main = Signal.map2 animatedImage Mouse.x Mouse.y

{% endhighlight %}

Try this out by pasting this code in the [online editor/runner.][try-elm] You should see that the image size is animated based on the x coordinate of the Mouse withing the window.

Let us see if we can understand this code. The first thing is to create a function that displays an image (Feel free to replace this image with any image you like to animate and continue the exercises). This function `animatedImage` takes two parameters set the width and height of the the image.

Now in order to animate it we need to map this function over a Signal that contains your mouse x and y coordinates. But we know how to do that from our examples using Signals; just use Signal.map.  And we are done!

### Exercise
 * Animate an image where width and the height of the image depend on the number of mouse clicks.

{% highlight Haskell %}
import Html exposing (..)
import Html.Attributes exposing (..)
import Mouse

animatedImage w h =
  img
    [src "http://elm-lang.org/imgs/yogi.jpg"
    ,style
       [("width", toString w ++ "px")
        ,("height", toString h ++ "px")
       ]
    ][]

mouseClickCount = Signal.foldp (\click count ->2*count +1) 80 Mouse.clicks

main = Signal.map2 animatedImage mouseClickCount mouseClickCount
{% endhighlight %}

Now we can look at a couple of more elaborate examples:

* A Bouncing ball
* A clock

These examples are triggered by special events `fps : number -> Signal Time` and `every : Time -> Signal Time` that are defined in the [Time module][Time Docs]. We discussed them briefly in the exercises in the section on [Signals][CSmith Signals].

### A bouncing ball

{% highlight Haskell %}
import Graphics.Collage exposing (..)
import Signal exposing (..)
import Color exposing (..)
import Time exposing (..)
import Debug
main = map draw ball

-- Draw the sky, ball, and ground
draw ball =
  collage 150 400
   [ rect 150 400 |> filled (rgb 135 206 250)
   , circle 15    |> filled red
                  |> move (0, ball.height - 160)
   , rect 150 50  |> filled green
                  |> move (0,-200)
   ]

-- Physics
gravity = 640
bounceVelocity = 400

type alias Ball = { height : Float, velocity : Float}

stepUpdate : Float -> Ball -> Ball
stepUpdate time ball =
 { ball | height   = ball.height + ball.velocity * time,
          velocity = if (ball.height < 0) then bounceVelocity else ball.velocity - gravity * time }

--foldp : (a -> b -> b) -> b -> Signal.Signal a -> Signal.Signal b
ball = foldp stepUpdate {height=0, velocity=bounceVelocity}
                  (map inSeconds (fps 30))

{% endhighlight %}

Try changing the `bounceVelocity` and the `gravity parameters`.

### A clock

This is one of the examples from the [elm site][Elm Clock].
You can find other interesting examples there as well.

{% highlight Haskell %}
import Color exposing (..)
import Graphics.Collage exposing (..)
import Graphics.Element exposing (..)
import Time exposing (..)

main =
  Signal.map clock (every second)

clock t =
  collage 400 400
    [ filled lightGrey (ngon 12 110)
    , outlined (solid grey) (ngon 12 110)
    , hand orange 100 t
    , hand blue 80 (t/60)
    , hand blue 60 (t/720)
    ]

--generate a lines segment given color lenght and time
hand clr len time =
  let
    angle = degrees (90 - 6 * inSeconds time)
  in
    segment (0,0) (fromPolar (len,angle))
      |> traced (solid clr)
{% endhighlight %}

[Signals-elm-lang]:http://elm-lang.org/guide/reactivity#signals
[Elm Basics]: https://csmith111.github.io/jekyll/update/2016/02/07/ASecondBlogPost.html
[Time Docs]:http://package.elm-lang.org/packages/elm-lang/core/3.0.0/Time#fps
[try-elm]: http://elm-lang.org/try
[SignalModule]:http://package.elm-lang.org/packages/elm-lang/core/3.0.0/Signal
[Elm Clock]:http://elm-lang.org/examples/clock
[CSmith Signals]:https://csmith111.github.io/jekyll/update/2016/02/10/Signals.html
