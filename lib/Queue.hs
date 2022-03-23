module Queue (
    Queue(..)
) where

class Queue q where
    empty :: () -> IO (q a)
    isEmpty :: (q a) -> IO Bool
    dequeue :: (q a) -> IO (Maybe a)
    enqueue :: ((q a), a) -> IO ()