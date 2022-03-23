module Queue.RingQueue(Queue(..),RingQueue) where

import Data.Array.IO
import Data.IORef
import Queue

data RingQueue a = RingQueueRecord {
      values :: IOArray Int (Maybe a)
    , front :: IORef(Int)
    , rear :: IORef(Int)
}

n :: Int
n = 100

instance Queue RingQueue where
    
    empty _ = do
        initialFront <- newIORef 0
        initialRear <- newIORef 0
        initialArray <- newArray (0,n) Nothing
        return $ RingQueueRecord {
            values = initialArray
            , front = initialFront
            , rear = initialRear
        }
    
    isEmpty ringQueue = do
        fr <- readIORef (front ringQueue)
        r <- readIORef (rear ringQueue)
        return $ fr == r

    dequeue ringQueue = do
        fr <- readIORef (front ringQueue)
        r <- readIORef (rear ringQueue)
        if (fr == r) then
            return Nothing
        else
            do
                v <- readArray (values ringQueue) fr
                writeIORef (front ringQueue) $ (fr + 1) `mod` (n+1)
                return v
            
    enqueue (ringQueue,v) = do
        fr <- readIORef (front ringQueue)
        r <- readIORef (rear ringQueue)
        if ((r + 1) `mod` (n+1) == fr) then
            error "Queue is full"
        else
            do
                writeArray (values ringQueue) r (Just v)
                writeIORef (rear ringQueue) $ (r + 1) `mod` (n+1)