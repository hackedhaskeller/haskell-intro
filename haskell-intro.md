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

Hmmm, well that is a bit different, but if I take it slow I can guess what everything does. `putStrLn` seems to take some string and put it out to the terminal. `someVariable <- getLine` seems to get a line from the terminal and assign it to `someVariable`. Easy enough.

What about Monads? I've heard that you can't do any Haskell without Monads?

Well you are correct. The above examples do use `IO`, which is Monadic.

Wait what does that mean?

Well to be perfectly honest as far as we are concerned it means it implements the Monad type `class`.

A type class?

Yeah, sorta like and interface it most other languages.

Oh, that doesn't sound so bad.

It really isn't. You just have to under how a type implements the Monad type class to understand what it means to use it Monadically. Plus, when you understand that you can then make your own analogy, post it online, and then put it on your CV.

So what is the interface then?

Well if you pop into `ghci` and do `:i Monad` you'll see information about the type class. It will have a fair amount of output, but you should see something like

``` haskell
class Applicative m => Monad m where
  (>>=) :: m a -> (a -> m b) -> m b
  (>>) :: m a -> m b -> m b
  return :: a -> m a
```

Wait, hold up, I don't see any of that in the examples up above! Why are you telling me about Monads if I don't see those above?

First of all, you asked, and second the Monad type class is used so often and so much it has special syntactic sugar. To write `helloName` without the sugar it would look like

``` haskell
helloNameNoSugar :: IO ()
helloNameNoSugar =
  putStrLn "What is your name?" >>= \_ ->
  getLine >>= \name ->
  putStrLn ("Hello " ++ name)
```
