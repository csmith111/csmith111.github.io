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

This is a very cool animation that requires you to figure out how to simulate an object falling in a gravitational field.
It is key to examine how the updates to position and velocity are done.

{% highlight Haskell %}
import Graphics.Collage exposing (..)
import Signal exposing (..)
import Color exposing (..)
import Time exposing (..)

import Debug
main = map draw ballSignal



draw aball =
  collage 150 400
   [ rect 150 400 |> filled (rgb 135 206 250)
   , circle 15    |> filled red
                  |> move (0, aball.height - 160)
   , rect 150 50  |> filled green
                  |> move (0,-200)
   ]

-- Physics
gravity = 640
bounceVelocity = 400

type alias Ball = { height : Float, velocity : Float}

stepUpdate : Float -> Ball -> Ball
stepUpdate time aball =
 { aball | height   = aball.height + aball.velocity * time,
          velocity = if (aball.height < 0) then bounceVelocity else aball.velocity - gravity * time }

--To explain the ordering of paramters in ballSignal
--Note:foldp : (a -> b -> b) -> b -> Signal.Signal a -> Signal.Signal b

ballSignal : Signal Ball
ballSignal = foldp stepUpdate {height=0, velocity=bounceVelocity}
                  (map inSeconds (fps 30))

{% endhighlight %}

Try changing the `bounceVelocity` and the `gravity parameters`.

### Exercises
 * Add a factor called elasticity and the update rule that
 `bounceVelocity = elasticity * bounceVelocity` and modify the `type alias Ball = { height : Float, velocity : Float, bounceVelocity}`. This will simulate the effect of elasticity. The ball bounces should progressively decrease in height and finally come to a stop.

 {% highlight Haskell %}
import Graphics.Collage exposing (..)
import Signal exposing (..)
import Color exposing (..)
import Time exposing (..)

import Debug
main = map draw ballSignal

draw aball =
  collage 150 400
   [ rect 150 400 |> filled (rgb 135 206 250)
   , circle 15    |> filled red
                  |> move (0, aball.height - 160)
   , rect 150 50  |> filled green
                  |> move (0,-200)
   ]

-- Physics
gravity = 640
elasticity = 0.95

type alias Ball =
  { height : Float, velocity : Float, bounceVelocity : Float}

stepUpdate : Float -> Ball -> Ball
stepUpdate time aball =
 { aball | height   = aball.height + aball.velocity * time
           ,velocity = if (aball.height < 0) then aball.bounceVelocity else aball.velocity - gravity * time
           ,bounceVelocity = if (aball.height < 0) then elasticity * aball.bounceVelocity else aball.bounceVelocity
          }

--To explain the ordering of paramters in ballSignal
--Note:foldp : (a -> b -> b) -> b -> Signal.Signal a -> Signal.Signal b

ballSignal : Signal Ball
ballSignal = foldp stepUpdate {height=0, velocity=400, bounceVelocity=400}
   (map inSeconds (fps 30))
{% endhighlight %}

### Many Bouncing Balls

Can we extend the Bouncing ball example to many bouncing Balls?
I ended up using the extremely useful library Signal.Extra.
But this means that you will have to run this program locally since try-elm does not support Signal.extra currently.

I have covered the Elm installation in the post Elm Setup.
You can add [Signal.Extra from Github][SignalExtra]

{% highlight Haskell %}
$ elm package install Apanatshka/elm-signal-extra

{% endhighlight %}

If you don't what to get side tracked into installs at this time, you could just browse the code to understand the key ideas.

{% highlight Haskell %}
import Graphics.Collage exposing (..)
import Signal exposing (..)
import Color exposing (..)
import Time exposing (..)
import Signal.Extra exposing (mapMany)
import Graphics.Element exposing (..)
import Debug
import Array exposing (..)

type alias Ball = { id: Int, x : Float, y : Float, vx : Float, vy : Float, initialVy : Float}

drawMany balls =
   collage 150 400
   (  (rect 150 400 |> filled (rgb 135 206 250))
   :: (rect 150 50  |> filled green |> move (0,-200))
   :: List.map drawBall balls)

drawBall : Ball -> Form
drawBall aBall =
    circle 15 |> filled red
              |> move (aBall.x, aBall.y - 160)

-- Physics
gravity = 640

-- helper function to extract a value from an Array
mayBeToValue : Maybe a -> a -> a
mayBeToValue aJust defaultV =  case aJust of
  Just a -> a
  Nothing -> defaultV

--bounceVelocity = 400
-- Store different initaial velocities for each ball.
bounceVelocities = fromList [300, 600]

stepUpdate : Float -> Ball -> Ball
stepUpdate time aball =
 { aball | y   = aball.y + aball.vy * time,
           vy  = if (aball.y < 0) then aball.initialVy  else aball.vy - gravity * time }

ballSignal : Ball -> Signal Ball
ballSignal aBall =
  foldp stepUpdate aBall
    (Signal.map inSeconds (fps 30))

ballSignals : List (Signal Ball)
ballSignals =  [
                   ballSignal {id = 0, x = 50, y = 0, vx =0, vy = 600, initialVy = 600}
                 , ballSignal {id = 1, x = -50, y = 0, vx =0, vy = 300, initialVy = 300}
                ]

main = mapMany (drawMany) ballSignals

--main = drawMany [{x = 50, y = -160, vx =0, vy =0}, {x = -50, y = -160, vx=0, vy =0}]
{% endhighlight %}


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

### Animated batman

An here is a cool batman animation. Yan either hypnotize yourself or get dizzy watching this animation!
In this case creating the image that you wanted to animate was the most work. Unlike the bouncing ball where figuring out how to simulate gravity took more effort.

{% highlight Haskell %}
import Color exposing (..)
import Graphics.Collage exposing (..)
import Graphics.Element exposing (..)
import Time exposing (..)

main = Signal.map animate (every millisecond)

animate t = collage 300 300
  [ batman
  |> move ((50*(sin (t/1000))),(50*(cos (t/1000))))
  |> rotate (10*(t/5000))
  |> scale ((abs(sin (t/500))) + 0.7)
  ]

batman = group
    [ move (0,0) (filled black (circle 400))
    , move (0,0) (filled darkGrey (circle 190))
    , move (0,0) (filled white (circle 180))
    , move (0,0) (filled darkGreen (circle 170))
    , move (0,0) (filled green (circle 160))
    , move (0,0) (filled blue (circle 150))
    , move (0,0) (filled darkBlue (circle 140))
    , move (0,0) (filled yellow (circle 130))
    , move (0,0) (filled darkYellow (circle 120))
    , move (0,0) (filled red (circle 110))
    , move (0,0) (filled lightRed (circle 100))
    , move (0,0) (filled black (circle 50))
    , move (0,0) (filled skinColor (circle 50)) |> scale 0.9
    , move (0,-4) (filled black (polygon [(-10,0),(0,-5),(10,0),(3,10),(-3,10)])) |> scale 5
    , move (29,35) (filled black (ngon 3 30)) |> rotate (degrees 70)
    , move (-29,35) (filled black (ngon 3 30)) |> rotate (degrees 110)
    , move (25,0) (filled white (oval 40 20)) |> rotate (degrees 30)
    , move (25,8) (filled black (rect 45 15)) |> rotate (degrees 20)
    , move (-25,0) (filled white (oval 40 20)) |> rotate (degrees 150)
    , move (-25,8) (filled black (rect 45 15)) |> rotate (degrees 160)
    , move (0,-35) (filled black (rect 20 2))
    , move (-12,-36) (filled black (rect 5 2)) |> rotate (degrees 20)
    , move (12,-36) (filled black (rect 5 2)) |> rotate (degrees 160)
    ]

skinColor = hsl 0.17 1 0.74
{% endhighlight %}


[Signals-elm-lang]:http://elm-lang.org/guide/reactivity#signals
[Elm Basics]: https://csmith111.github.io/jekyll/update/2016/02/07/ASecondBlogPost.html
[Time Docs]:http://package.elm-lang.org/packages/elm-lang/core/3.0.0/Time#fps
[try-elm]: http://elm-lang.org/try
[SignalModule]:http://package.elm-lang.org/packages/elm-lang/core/3.0.0/Signal
[Elm Clock]:http://elm-lang.org/examples/clock
[CSmith Signals]:https://csmith111.github.io/jekyll/update/2016/02/10/Signals.html
[SignalExtra]:https://github.com/Apanatshka/elm-signal-extra
