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

increment : number -> number
increment n = n+1

main = flow down [print "The sqr of 5 is : " (sqr 5)
        ,print "40 degrees centigrade in Fahrenheit is : " (centigradeToFahrenheit 40)
        ,print "Is 5 an even number : " (isEven 5)
        ,print "3 + 2 is : " (add 3 2)
        ,print "incrementing 5 we get : " (increment 5)
        ]

--a helper function to make display easier
print message value = show (message ++ (toString value))

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



## Recursive Functions

Recursive Functions are simply functions that call themselves in their definition. Recursion is a powerful technique to solve problems in an intuitive and compact manner. The common example used to illustrate this is the factorial function:
$$ n! = n*(n-1)!$$. As you can see the definition of the function refers to itself. This is natural to do in mathematics, can we do the same in an Elm program? The answer is  yes.. Let us see how this looks.


{% highlight Haskell %}
import Graphics.Element exposing (..)
import List exposing (..)

--Recursion
facR : Int -> Int
facR n =
  if n < 1 then
    1
  else
    n*facR(n-1)

hemachandra : Int -> Int
hemachandra n =
  case n of
    0 -> 1
    1 -> 1
    _ -> hemachandra (n-1) + hemachandra (n-2)

main = flow down [print "factorial(5) is : " (facR 5)
        ,print "The 5'th Hemachandra number is : " (hemachandra 5)
        ]

--a helper function to make display easier
print message value = show (message ++ (toString value))
{% endhighlight %}

### Pattern Matching

{% highlight Haskell %}
import Graphics.Element exposing (..)
import List exposing (..)
--pattern matching and Recursion
facP : Int -> Int
facP n =
  case n of
    0 -> 0
    1 -> 1
    _ -> n * facP (n-1)

length : List number -> number
length xs = case xs of
  x::xs -> 1 + length xs
  []    -> 0

main = flow down [
    print "factorial(5) using recursion is : " (facP 5)
  , print "The length of the list [1,2,3] is : " (length [1..3])]

--a helper function to make display easier
print message value = show (message ++ (toString value))
{% endhighlight %}

## Pattern Matching on Lists

{% highlight Haskell %}
import Graphics.Element exposing (..)
import List exposing (..)
--pattern matching on lists
--length :: List a -> a
length xs = case xs of
    x::xs -> 1 + length xs
    []    -> 0

--reverse :: List a-> List a
reverse xs = case xs of
  x::xs -> (reverse xs)++[x]
  [] -> []

head xs = case xs of
  x::xs -> x
  [] -> 0

main =
  flow down [print "The head element of the list [2..5] is : " (head [1..5])
  ,print "The reversed elements of the list [2..5] is : " (reverse [1..5])
  ]

print message value = show (message ++ (toString value))
{% endhighlight %}

## Higher Order Functions - Maps and Folds

{% highlight Haskell %}
import Graphics.Element exposing (..)
import List exposing (..)
sumList : number -> List number -> number
sumList init =
  List.foldr (+) init

print message value = show (message ++ (toString value))
{% endhighlight %}

## Function Composition



[try-elm]: http://elm-lang.org/try
