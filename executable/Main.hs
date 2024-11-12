-- It is generally a good idea to keep all your business logic in your library
-- and only use it in the executable. Doing so allows others to use what you
-- wrote in their libraries.
module Main where
import  LogisticRegrecion.IO

main :: IO ()
main = do
    mat <- readTrainData "./data/train.csv" 80
    print $ head <$> mat 


