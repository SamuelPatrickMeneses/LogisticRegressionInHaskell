-- It is generally a good idea to keep all your business logic in your library
-- and only use it in the executable. Doing so allows others to use what you
-- wrote in their libraries.
module Main where
import  LogisticRegrecion.IO
import LogisticRegrecion

trainDataFile = "./data/train.csv"

inputN  = 784
outputN = 10

main :: IO ()
main = do
    net <- readNet trainDataFile 2
    print net 


