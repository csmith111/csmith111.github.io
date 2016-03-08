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



### Recursive Functions

Recursive functions are simply functions that refer to/call themselves in their definition. Recursion is a powerful technique to solve problems in an intuitive and compact manner. The common example used to illustrate this is the factorial function:
$$ n! = n*(n-1)!$$. (Okay for those of you interested in mathematics and typesetting to see the previous expression, we have to get $ \LaTeX $ working! Latex, Javascript, Jekyll and markdown can all work with each other is something incredible. The fact that I was about to get it up an running in a few minutes is amazing!) As you can see the definition of the function refers to itself. This is natural to do in mathematics, can we do the same in an Elm program? The answer is  yes. Let us see how this looks:

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
  if n==0 then
     1
  else if  n==1 then
     1
  else
   hemachandra (n-1) + hemachandra (n-2)

main = flow down [print "factorial(5) is : " (facR 5)
        ,print "The 5'th Hemachandra number is : " (hemachandra 5)
        ]

--a helper function to make display easier
print message value = show (message ++ (toString value))
{% endhighlight %}

The recursion pattern has two ingredients:

* **The termination condition:** Need to handle all conditions that the recursion has to terminate for. For the factorial function it is when n gets to 0 we terminate the recursion. For those using recursion this is often the source of bugs, which leads to infinite recursion and program crashes!  
* **The recursive step:** For all values of n other than the terminal one we describe how to compute  the next value.

The second example that I have included generates the [Fibonacci numbers][fib-ref]. These numbers we noticed much earlier by [Hemachandra][Hemachandra-ref].
Fields medallist [Manjul Bhargava][Manjul] has been referring to the Hemanchandra numbers and how he was [inspired by ancient indian mathematicians][Manjul-Hema]. So we called the function `hemachandra` in this example.

While recursion is a good technique to use to solve problems,
often in programs we just end up combining library functions to write our code. So we could write the factorial function as
`factorial n = product [1..n]`.

### Exercises

* Define a recursive function `power` such that `power x y` raises `x` to the `y` power.

### Pattern Matching

The technique of using pattern matching to
to implement logic in your code is a very standard technique in functional programming. In some sense it is a very natural way to have different code to handle different *patterns*.
There are quite a few different things that you can use as patterns:

* Values
* Types
* Guards/Expression
* special patterns related to data structures (like [],(x::xs) for lists)

Right now let us use pattern matching on values.

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

main = flow down [
    print "factorial(5) using recursion is : " (facP 5)]

--a helper function to make display easier
print message value = show (message ++ (toString value))
{% endhighlight %}

As you can see from the code above there are three patterns that are tested against the current value of `n` either `n` is 0, 1 or *any other value*.

### Pattern Matching on Lists

Combining recursion with pattern matching on lists gives us the technique to write many interesting functions. Here we have shown three functions (`length`, `reverse`, `head`) for you to review.

{% highlight Haskell %}
import Graphics.Element exposing (..)
import List exposing (..)

length : List a -> number
length xs = case xs of    
    []    -> 0
    x::xs -> 1 + length xs

reverse : List a -> List a
reverse xs = case xs of
  [] -> []
  x::xs -> (reverse xs)++[x]

head : List number -> number
head xs = case xs of
  [] -> 0
  x::xs -> x

main =
  flow down [print "The length the list [2..10] is : " (length [1..10])
  ,print "The reversed elements of the list [2..5] is : " (reverse [1..5])
  ,print "The head element of the list [2..5] is : " (head [1..5])
  ,print "The first 2 elements of the list [1..5] is : " (take 2 [1..5])
  ]

print message value = show (message ++ (toString value))
{% endhighlight %}


### Exercises

1. Implement the function `take n ys` that returns the first $n$ elements of the list of $ys$.

In case you want to just look at the solution here it is.

{% highlight Haskell %}
take:number -> List a -> List a
take m ys =
  case (m,ys) of
   (0,_) ->  []
   (_, [])->  []
   (n,x::xs) ->  [x] ++ take (n-1) xs
{% endhighlight %}


### Higher Order Functions - Maps, Filters and Folds

Higher order functions is a fancy term for functions that take other functions as parameter. Having said that there is an interesting way to look at this as a paradigm shift in the way we think about functions. The normal way we use functions is to say to the function here is some **data** (parameters) can you please run yourself on my data. On the other hand with higher order functions you are saying here is some **code** can you please run this **code** for me in **your context**.

{% highlight Haskell %}
import Graphics.Element exposing (..)
import List exposing (..)

firstTenPowersOfTwo = map ((^)2) [1..10]

sumList : number -> List number -> number
sumList initialValue =
  List.foldr (+) initialValue

main =
  flow down [print "The first ten powers of 2 are : "    firstTenPowersOfTwo
   ,print "The sum of the elements of the list [1..10] : " (sumList 0 [1..10])
  ]

print message value = show (message ++ (toString value))

{% endhighlight %}

### Exercises

* Implement the cartesian product of two lists. Given two lists
`l1= [1,2,3] l2=[1,2,3,4]` output the list `l3= [(1,1),(1,2),(1,3),(1,4),(2,1),(2,2),(2,3),(2,4),(3,1),(3,2),(3,3),(3,4)]`
(This exercise was suggested to me by [my friend][Vinay], and it really illustrates how difficult it is to code until you have mastered the functional programming idioms.)

{% highlight Haskell %}
import Graphics.Element exposing (..)
import List exposing (..)

main = show l3

l1 =[1..3]
l2=[1..4]

cartesianProduct listOfFuncs alist = concatMap (\f -> map f alist) listOfFuncs

l3 = cartesianProduct (map (,) l1) l2
{% endhighlight %}

You should look up the definition of concatMap and other functions defined in the [List module][list docs].

### Anonymous Functions

The term Lambda function or Lambda expression comes from [Lambda Calculus][LambdaCalculus]. Introduced by [Alonzo Church][Alonzo Church] in the 1930's as a part of a study of the foundations of mathematics. Just like the [[Turing machine][Turing Machine] is a fundamental model for computation, Lambda Calculus provides a equivalent model for computation. This little comment is a glimpse into a very interesting world of formal analysis of mathematics and computation that I encourage you to follow in your leisure.

Most of the functions that we have encountered so far have names. But are the names really important? Actually, names are important only if we want to reuse the functions in many places. Then, referring to them by their name is quite handy.

We use Lambda functions most often when:
* We would like to just create a function "right where we need it"
* We only plan to use the function once.
* The function is fairly simple
* We want to return a function from a function.

Usually we do this to pass/receive these functions to other functions that need them.

Here are a couple of examples of Lambda Functions:

{% highlight Haskell %}
import Graphics.Element exposing (..)
import List exposing (..)

--binnding an anonymous function to a variable
addExclaim = \s -> s ++ "!"

main =
  flow down [print " add an ! to Hello : "  (addExclaim "hello")
   ,print "the square of the first 10 numbers : " (map (\n -> n*n) [1..10])
  ]

print message value = show (message ++ (toString value))
{% endhighlight %}

### Exercises

* Define an anonymous function and use it to double all the elements of a list.

* By combining some of the techniques described about implement the quicksort algorithm to sort a list.

{% highlight Haskell %}
import Graphics.Element exposing (show)
import List exposing (filter)

main =
  show (qsort [5,3,8,1,9,4,7])

qsort : List comparable -> List comparable
qsort list =
  case list of
    [] ->
        []
    x :: xs ->
        let
          greater  = filter ((<=) x) xs
          lesser = filter ((>)  x) xs
        in
          qsort lesser ++ [x] ++ qsort greater
{% endhighlight %}


### Function Composition and Pipes

In Elm the operator for function composition is `>>` and `<<` :
{% highlight Haskell %}
f >> g = f (g ) = g << f
{% endhighlight %}

In addition there is also the `|>` operator that allows us to pass the output of one expression as the last argument of the next function. (Exercise: check this.)

{% highlight Haskell %}
import Graphics.Element exposing (..)

isEven : Int -> Bool
isEven n =
   n % 2 == 0

isOdd : Int -> Bool
isOdd x = not(isEven x)

isOdd1 : Int -> Bool
isOdd1 = not << isEven

isOdd2 : Int -> Bool
isOdd2 x = x |> isEven |>not

main = flow down [
              print "IsEven (3) : " (isEven 3)
             ,print "IsOdd (3) : " (isOdd 3)
             ,print "IsOdd1 (3) : " (isOdd1 3)
             ,print "IsOdd2 (3) : " (isOdd2 3)
            ]

--a helper function to make display easier
print message value = show (message ++ (toString value))
{% endhighlight %}


## Closures

The main idea behind currying is that functions that have `n` parameters can be reduced to a functions that have a single parameter.

In other words we are saying that
`f : a -> b -> c` is the curried form of `g : (a,b) -> c`.

Of course this means that we are saying that the two function f and g are the same or ` f x y = g (x,y)`.

Let us see what happens when we  perform __partial application__ of functions. In other words if a function expects 2 arguments (for example) then we can create a new function with 1 argument by partial application.

```haskell
import Graphics.Element exposing (..)

add : Int -> Int -> Int
add x y  =
   x + y

-- create increment by partiial application (add 1)
increment : Int -> Int
increment = add 1

main = flow down [
              print "add 2 3 : " (add 2 3)
             ,print "increment 3 gives : " (increment 3)
            ]

--a helper function to make display easier
print message value = show (message ++ (toString value))
```
In the example above we were able to create the function
`increment : Int -> Int` by partial application from the function
`add : Int -> Int -> Int`. As you can see the number of parameters in the function increment is less than that of the function add. __note:__ Elm does not give us an error saying that it expected two parameters, it returns a new function with one less argument. This behavior needs getting used to as sometimes you will find that in your code if you miss a paramter the error message will be about problems caused by this new function that you have unintentionally created.

This example give us the heuristics for currying. We can read the signature `add : Int -> Int -> Int` either as saying that add is a function that takes two Integers and returns an Integer or add is a function that given an Int it returns a function  from (Int -> Int). And these two representations are equivalent. We just used partial application to see what this looks like.

For the most part Currying is formal and does not impact the new developer. I would say understanding partial application is quite useful in many situations.

## Sections

Another related idea is that we can also use partial applications on infix operators.
Here are some examples of sections:

```haskell
import Graphics.Element exposing (..)

increment : Int -> Int
increment = ((+) 1)

twoToPower : Int -> Int
twoToPower = ((^)2)

square : Int -> Int
square = (flip (^)2)

main = flow down [
              print "2 to the power 3 : " (twoToPower 3)
             ,print "increment 3 gives : " (increment 3)
             ,print "square of 3 is : " (square 3)
            ]

--a helper function to make display easier
print message value = show (message ++ (toString value))
```

## Closures

Now we come to a very interesting concept that we must understand if we are going to pass functions to other functions.

Consider this example:

```haskell
import Graphics.Element exposing (..)

createIncrementer : Int -> Int -> Int
createIncrementer n =
 let incrementValue = n
 in ((+) incrementValue)

incrementByOne : Int -> Int
incrementByOne = createIncrementer 1

incrementByTwo : Int -> Int
incrementByTwo = createIncrementer 2


main = flow down [
              print "incrementByOne 3 : " (incrementByOne 3)
             ,print "incrementByTwo gives : " (incrementByTwo 3)
            ]

--a helper function to make display easier
print message value = show (message ++ (toString value))
```

In this example the function `createIncrementer` returns a function. But that function depends on the local variable `incrementValue` that is defined within `createIncrementer`.
What is intesting is that the returned functions, `incrementByOne` and `incrementByTwo` remember/capture the __value of this local variable at the time they were created__. So they have captured some of the state of the function that they were created in. This is called "closing over the local variable" and more generally this behavior is called a closure.


[Turing machine]:https://en.wikipedia.org/wiki/Turing_machine
[Alonzo Church]:https://en.wikipedia.org/wiki/Alonzo_Church
[LambdaCalculus]:[https://en.wikipedia.org/wiki/Lambda_calculus]
[try-elm]: http://elm-lang.org/try
[fib-ref]:https://en.wikipedia.org/wiki/Fibonacci_number
[Hemachandra-ref]:https://en.wikipedia.org/wiki/Hemachandra
[Manjul-Hema]:https://www.youtube.com/watch?v=siFBqH-LaQQ
[Manjul]:https://en.wikipedia.org/wiki/Manjul_Bhargava
[Vinay]:https://twitter.com/ainvvy
[list docs]:http://package.elm-lang.org/packages/elm-lang/core/3.0.0/List
