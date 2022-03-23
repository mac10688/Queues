# Running the program

Prerequisites: ghc 8.10.7, cabal 3.6.2.0

I personally used ghc to configure my setup on Windows.

To build
`cabal build`

To run
`cabal run`


# Modifying driver code

To change the choice of queue implementation whenever the empty () function is called, it will need to be annotated with the proper implementation queue class.

e.g.
```
ringQueueInt <- empty () :: IO (RingQueue Int)
linkedListQueueInt <- empty () :: IO (LinkedListQueue Int)
```

To rerun the code with a new implementation user should stop the running program and `cabal build` and then `cabal run`


# Failure to meet outline goals 

- The choice of queue implementation does require recompilation. I don't know how it wouldn't... It will also require a change in the code to annotate a new concrete method to be implemented.

- To compile just the library code the user can run `cabal build CS558-Lab9`. In this demo the driver code and library code are in the same package, but yes we can compile just the library code and if we wanted to take the driver code out, we could make a package and publish it somewhere.