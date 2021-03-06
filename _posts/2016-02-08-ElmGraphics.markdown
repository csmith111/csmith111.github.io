---
layout: post
title:  "Functional Reactive Programing with Elm: Part III - Elm Graphics"
date:   2016-02-08 13:00:28 -0500
summary:  In this post we will look at the one of the key features of Elm, Graphics. Doing graphics in a functional programming languages allows us to use the composability of functional languages to make our graphics programs more compositional. We will see how this reflects the  compositonal nature of the way transformations act on Shapes.
categories: jekyll update
---

Let us get started by drawing some simple shapes.

{% highlight Haskell %}
import Color exposing (..)
import Graphics.Element exposing (..)
import Graphics.Collage exposing (..)

main : Element
main =
  collage 300 300
    [makeSquare blue 50]

--Simple Shapes
makeSquare color size =
  filled color (square size)

{% endhighlight %}

You can just enter this code in the [online editor/runner.][try-elm]

Now let us see if we can understand how this code works.
At the top of the code you are seeing a set of import statements, that allows the elm compiler to include all the packages containing the functions we want to use. In this case the packages are Color, Graphics.Element  and Graphics.Collage.

Now let us look at the function `main` what it does is to construct a graphics Element which then gets displayed. The graphics Element is constructed by calling the function `collage` which takes as input two integers (which define the dimensions of the collage) and a list of Form objects that it then converts to graphics Elements. The signature of the collage function which makes all this explicit is as follows:

`collage : Int -> Int -> List Form -> Element`

We need to understand two more functions to get the full picture:

* First we create a Shape using the function `square` which creates a square with the given edge length (side).
`square : Float -> Shape`

* Then we pass this Shape to the function `filled` which takes the Shape and a color and returns a Form which can be passed to collage.
`filled : Color -> Shape -> Form`

That is all there is to it!

### Exercises

1. Try changing colors and sizes on the square to see how this all works.

2. Using the documentation see if you can create a red circle. (Hint: Create a new function makeCircle similar to makeSquare.)

3. Try and make a blue square of side 40 and a circle of radius 60. (Hint: collage will accept a list of Shape Forms.)

You will find the complete documentation for the Graphics.Collage package at this [link][elm-graphics-collage]

### More Shapes

Let us create a few more shapes using functions that are defined in Graphics-Collage. The shapes we will consider are:

* Triangle
* Rectangle
* NGon with n sides
* NGon with n vertices

{% highlight Haskell %}
--Simple Shapes
makeSquare color size =
  filled color (square size)

makeTriangle color size =
  filled color (ngon 3 size)

makeRectangle color length width =
  filled color (rect length width)

makeCircle color size =
  filled color (circle size)

makeNgon n color size =
  filled color (ngon n size)

makePolygon color vertices  =
  filled color (polygon vertices)

vertices = [  (0,0)
            , (50,10)
            , (20,50)
            , (80,50)
            ]
{% endhighlight %}

### Exercises

1. Write code that makes a blue pentagon.

2. Write code to make a red hexagon.

### Shapes with Fills and Outlines

So far we looked at shapes which were filled with a chosen color. But we can also make figure with outlines as shown below:

{% highlight Haskell %}
import Color exposing (..)
import Graphics.Element exposing (..)
import Graphics.Collage exposing (..)

makeSquareOutlined : Color.Color -> Float -> Graphics.Collage.Form
makeSquareOutlined color size =
 square size
 |>outlined (solid color)

main =
  collage 300 300
    [makeSquareOutlined blue 50]

{% endhighlight %}

### Exercises

1. Write code the makes a square with a `dashed` outline.
(Hint you can use the function `dashed` instead of )

### Transforming Shapes

Now that we have a set of shapes to work with we can look at functions that transform them.


### Making a Star - using triangles and transformations

Once we understand transformations we can use them to create more complex shapes and figures.

{% highlight Haskell %}
import Color exposing (..)
import Graphics.Collage exposing (..)
import Graphics.Element exposing (..)
import List exposing (..)

main : Element
main =
  collage 300 300 (star blue)

triangle color size angle =
  ngon 3 size
  |>filled color
  |> rotate (degrees angle)

star color = map2 (triangle color) [100,100] [30, 90]
{% endhighlight %}

[try-elm]: http://elm-lang.org/try
[elm-core]:http://package.elm-lang.org/packages/elm-lang/core/3.0.0/
[elm-packages]: http://package.elm-lang.org/
[Czaplicki-talk]: https://www.youtube.com/watch?v=ZTliDiWDV0k
[elm-graphics-collage]:http://package.elm-lang.org/packages/elm-lang/core/2.0.1/Graphics-Collage
