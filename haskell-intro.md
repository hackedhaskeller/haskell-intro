# An opinionated, no good, very bad, introduction to Haskell

Lets start with what everyone does when they are learning a new language: Hello world.

``` haskell
helloWorld = putStrLn "Hello World"
```

Well that doesn't look to bad! Not a Monad or Monoid in sight. (or is there???) Lets take it up a notch and try and ask who we are saying hello to.

``` haskell
helloName = do
  putStrLn "What is your name?"
  name <- getLine
  putStrLn ("Hello " ++ name)
```

Hmmm, well that is a bit different, but if I take it slow I can guess what everything does. As you might of surmised `putStrLn` takes a string and puts it out to the terminal and `someVariable <- getLine` gets a line from the terminal and assign it to `someVariable`. Easy enough.

Young Dev: What about Monads? I've heard that you can't do any Haskell without Monads?

Well you are correct. The above examples do use `IO`, which is Monadic.

Young Dev: Wait what does that mean?

Well to be perfectly honest as far as we are concerned it means it implements the Monad type `class`.

Young Dev: A type class?

Yeah, like an interface in most other languages. Where you basically take a group of functions and give it a name. There may also be some implicit rules you must follow if you implement the type class, but for now we wont worry about that as we'll only be using them.

Young Dev: Oh, that doesn't sound so bad.

It really isn't. You just have to under how a type implements the Monad type class to understand what it means to use it Monadically. Plus, when you understand that you can then make your own analogy, post it online, and then put it on your CV.

Young Dev: So what is the interface then?

Well if you pop into GHCi (the REPL of the GHC compiler) and do `:i Monad` you'll see information about the `Monad` type class. It will have a fair amount of output, but you should see something like

Note: `:i` is short for `:info` in GHCi

``` haskell
class Applicative m => Monad m where
  (>>=) :: m a -> (a -> m b) -> m b
  (>>) :: m a -> m b -> m b
  return :: a -> m a
```

Young Dev: Wait, hold up, I don't see any of that in the examples up above! Why are you telling me about Monads if I don't see those above?

First of all, you asked, and second the Monad type class is used so often and so much it has special syntactic sugar. To write `helloName` without the sugar it would look like

``` haskell
helloNameNoSugar :: IO ()
helloNameNoSugar =
  putStrLn "What is your name?" >>
  getLine >>= \name ->
  putStrLn ("Hello " ++ name)
```

So you can see that without the sugar you can see uses of `>>` and `>>=`. If we had a more complex program you'd probably see uses of `return` as well. Note: `return` is just a function, not a language keyword like other languages. If you see a `return someValue` in a function it doesn't mean to exit the function with the someValue value. That's why I prefer to instead use the `pure` function as it feels like a better name for the same functionality as `return`.

``` haskell
GHCi> :t pure
pure :: Applicative f => a -> f a
GHCi> :t return
return :: Monad m => a -> m a
```
Note: `:t` is short for `:type` in GHCi

You can see that when we ask for the type of `pure` and the type of `return` they are same except for one says `Applicative` and the other says `Monad`

Young Dev: Hey I saw `Applicative` in the `Monad` definition! What is that thing?

You're correct, to be a `Monad` you must first be an `Applicative`. `Applicative` is just another type class and you can ask GHCi about it as well (`:i Applicative`):

``` haskell
class Functor f => Applicative f where
  pure :: a -> f a
  (<*>) :: f (a -> b) -> f a -> f b
  liftA2 :: (a -> b -> c) -> f a -> f b -> f c
  (*>) :: f a -> f b -> f b
  (<*) :: f a -> f b -> f a
```
And in order to be an `Applicative` you must be a `Functor` which when we ask GHCi (`:i Functor`) it tells us:

``` haskell
class Functor f where
  fmap :: (a -> b) -> f a -> f b
  (<$) :: a -> f b -> f a
```

If a type implements `Monad` you can use any of the above functions with that type. More specifically, you can then use `fmap`, `<*>`, and the do syntactic sugar.

Young Dev: Why would I want to use those functions? I don't use them in other languages.

[ transition to talking about fmap is map, and how Haskell is lazy like how promises work in other languages also Haskell is a language of expressions not statements so we need those functions to structure and control the flow of our program ... or something similar]
