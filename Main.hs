module Main where

import Queue
import Queue.RingQueue
import Queue.LinkedListQueue
import Control.Monad (forM_)

main :: IO ()
main = do
  putStrLn ""
  ringQueueInt <- empty () :: IO (RingQueue Int)
  demoQueue "ringQueueInt" ringQueueInt [3,2,1]
  ringQueueString <- empty () :: IO (RingQueue String)
  demoQueue "ringQueueString" ringQueueString  ["Test1", "Test2", "Test3"]
  linkedListQueueInt <- empty () :: IO (LinkedListQueue Int)
  demoQueue "linkedListQueueInt" linkedListQueueInt [3,2,1]
  linkedListQueueString <- empty () :: IO (LinkedListQueue String)
  demoQueue "linkedListQueueString" linkedListQueueString ["Test1", "Test2", "Test3"]

demoQueue :: (Show a, Queue q) => String -> q a -> [a] -> IO ()
demoQueue qname q demoValues = do
  putStrLn $ "Demoing " ++ qname
  putStr "1. Is queue empty? "
  e1 <- isEmpty q
  putStr $ show e1
  putStrLn "\n2. Let's fill the queue up with the following values "
  putStr "\t"
  forM_ demoValues $ \v -> do putStr $ show v; putStr " "; enqueue (q,v)
  putStr "\n3. Is the queue empty now? "
  e2 <- isEmpty q
  putStr $ show e2
  putStrLn "\n4. We'll deque each value added and print it out. The queue will be empty when it prints Nothing."
  putStr "\t"
  printDequeu q
  putStrLn ""
    where
      printDequeu :: (Show a, Queue q) => q a -> IO ()
      printDequeu q = do
        poppedValue <- dequeue q
        case poppedValue of
          Just v -> do
            putStr $ show v ++ " "
            printDequeu q
          Nothing -> putStrLn "Nothing"