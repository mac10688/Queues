module Queue.LinkedListQueue(Queue(..),LinkedListQueue,printQueue) where

import Data.IORef
import Queue
import Data.Maybe
import Control.Monad (join)

data Node a = MkNode {
    value :: a
    ,next :: IORef(Maybe (Node a))
}

data LinkedListQueue a = MkLinkedListQueueRecord {
    front :: IORef (Maybe (Node a))
    ,rear :: IORef (Maybe (Node a))
}

instance Queue LinkedListQueue where

    -- empty :: () -> IO (LinkedListQueue a)
    empty _ = do
        frInitiliazer <- newIORef Nothing
        rInitiliazer <- newIORef Nothing
        return MkLinkedListQueueRecord {
            front = frInitiliazer
            ,rear = rInitiliazer
        }

    -- isEmpty :: LinkedListQueue a -> IO Bool
    isEmpty queueRecord = do
        f <- readIORef (front queueRecord)
        return $ isNothing f

    -- dequeue :: LinkedListQueue a -> IO (Maybe a)
    dequeue q = do
        fqM <- readIORef $ front q
        n <- fmap join $ sequenceA $ readIORef <$> next <$> fqM
        let v = value <$> fqM
        writeIORef (front q) n
        case fqM of
            Nothing ->
                do
                    writeIORef (rear q) Nothing
                    return v
            Just _ -> return v

    -- enqueue :: (LinkedListQueue a, a) -> IO ()
    enqueue (q,v) = do
        initiliazer <- newIORef Nothing
        let n = Just $ MkNode v initiliazer
        rearM <- readIORef $ rear q
        case rearM of
            Nothing ->
                do
                    writeIORef (front q) n
                    writeIORef (rear q) n
            Just rear' ->
                do
                    writeIORef (next rear') n
                    writeIORef (rear q) n


printQueue :: Show a => LinkedListQueue a -> IO ()
printQueue (MkLinkedListQueueRecord f _) = do
    n <- readIORef f
    printNode n

printNode :: Show a => Maybe (Node a ) -> IO ()
printNode (Just (MkNode v nRef)) =
    do
        n <- readIORef nRef
        putStr (show v ++ " ")
        printNode n
printNode Nothing = putStr "end\n"