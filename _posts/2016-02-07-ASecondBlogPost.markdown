---
layout: post
title:  "Functional Reactive Programing with Elm: Part II - Elm Basics"
date:   2016-02-07 13:00:28 -0500
summary:  In this post we will look at the basics of Elm. Most of this should be familiar to someone with a functional programming background like Haskell, but the syntax is slightly different.
categories: jekyll update
---

In this post we will look at the basics of programming in Elm. We will also encounter some of the essential concepts of Functional programming.

{% highlight Haskell %}
import Graphics.Element exposing (..)

--defining the function double
double : number -> number
double number =
  2*number

main = print "The double of 5 is : " (double 5)

--a helper function to make display easier
print message value = show (message ++ (toString value))

{% endhighlight %}

You can just enter this code in the [online editor/runner.][try-elm]

Let us see if we can understand how this code works.
First we define the function `double` that  takes a number and doubles it. The elm compiler infers this "function signature" and this is how it is expressed in Elm syntax `double : number -> number`. You can read this as `double is a function that returns a number and takes a number as input`.

It is always good practice to figure out the signature of the functions that we are creating and declare it. This way the compiler will verify it for you and let you know if the function that you have created has a bug in it and does not match the signature.

{% highlight Haskell %}
import Graphics.Element exposing (..)

--defining functions
sqr : number -> number
sqr n =
  n*n

-- convert temperature in Centigrade to Fahrenheit
centigradeToFahrenheit : Float -> Float
centigradeToFahrenheit c =
  c * 9/5 + 32

add : number -> number -> number
add a b =
  a + b

isEven : Int -> Bool
isEven n =
   n % 2 == 0

main = show [print "The sqr of 5 is : " (sqr 5)
        ,print "40 degrees centigrade is : " (centigradeToFahrenheit 40)
        ,print "Is 5 an even number : " (isEven 5)
        ,print "3 + 2 is : " (add 3 2)
        ]

--a helper function to make display easier
print message value = (message ++ (toString value))

{% endhighlight %}

Okay time to make some functions of your own.

### Exercises

1. Create the functions `subtract`, `divide`, `multiply` just like we did the `add` function.

2. Create a function to convert from kilograms to pounds.

3. Slightly more challenging create a function to check if a string is a palindrome. (Hint: there is a function called `reverse` that you can use. In case you are stuck you can see the solution below.)

{% highlight Haskell %}
import Graphics.Element exposing (..)
import String exposing (..)

--defining the function is Palindrome
isPalindrome : String -> Bool
isPalindrome aString =
  aString == reverse aString

main = print "Testing for Palindrome : " (isPalindrome "madamimadam")

--a helper function to make display easier
print message value = show (message ++ (toString value))
{% endhighlight %}

## Function Composition

## Recursive Functions

{% highlight Haskell %}

sqr : number -> number
sqr n =
  n*n


isEven : Int -> Bool
isEven n =
  n % 2 == 0

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

len xs = case xs of
  x::xs -> 1 + len xs
  []    -> 0


sumList : number -> List number -> number
sumList init =
  foldr (+) init


print value =
  Html.div [][ Html.text <| toString value, Html.br [][]]

printM message value =
  Html.div [][ Html.text <| message, Html.text <| toString value, Html.br [][]]


main : Html.Html
main =
    Html.p []
    [ printM "The square of 5 is: " (sqr 5)
    , printM "The square of numbers from [1..10] is : " (map sqr [1..10])
    , printM "The square of numbers from [1..10] is : " (map ((^)2) [1..10])
    , printM "Is 3 even:" (isEven 3)
    , printM "The square of odd numbers from [1..10] is : " (filter isEven [1..10])
    , printM "The sum of all the numbers from [1..100] is : " (sumList 0 [1..10])
    , printM "factorial(5) is : " (fac 5)
    , printM "fibonacci(5) is : " (fib 5)
    , printM "The length of the list [1,2,3] is :" (len [1..3])
    ]

{% endhighlight %}

[try-elm]: http://elm-lang.org/try
