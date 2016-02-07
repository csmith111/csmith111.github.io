---
layout: post
title:  "Functional Reactive Programing with Elm: Part II - Elm Basics"
date:   2016-02-07 13:00:28 -0500
summary:  In this post we will look at the basics of Elm. Most of this should be familiar to someone with a functional programming background like Haskell, but the syntax is slightly different.
categories: jekyll update
---

Okay let us get started

{% highlight Haskell %}
import Html
import List  exposing (..)

--defining functions
sqr : number -> number
sqr n =
  n*n

double : number -> number
double n =
  let c = 2 in 2 * n

centigradeToFahr : Float -> Float
centigradeToFahr c =
  c * 9/5 + 32

add : number -> number -> number
add a b =
  a + b

isEven : Int -> Bool
isEven n =
   n % 2 == 0

sumList : number -> List number -> number
sumList init =
   foldr (+) init

--Recursion
facR : Int -> Int
facR n =
  if n < 1 then 1 else n*facR(n-1)

--pattern matching and Recursion
fac : Int -> Int
fac n =
  case n of
    0 -> 0
    1 -> 1
    _     -> n * fac (n-1)

fib : Int -> Int
fib n =
  case n of
    0 -> 1
    1 -> 1
    _ -> fib (n-1) + fib (n-2)

print n =
  Html.div [][ Html.text <| toString n, Html.br [][]]

printM (m, n) =
  Html.div [][ Html.text <| m, Html.text <| toString n, Html.br [][]]

main : Html.Html
main =
    Html.p []
    [ printM <| ("The square of 5 is: ", sqr 5)
    , print <| map sqr [1..10]
    , print <| map ((^)2) [1..10]
    , print <| isEven 3
    , print <| filter isEven [1..10]
    , print <| sumList 0 [1..10]
    , printM <| ("factorial of 5 is : ", fac 5)
    , printM <| ("fibonacci of 5 is : ", fib 5)
    ]

{% endhighlight %}
