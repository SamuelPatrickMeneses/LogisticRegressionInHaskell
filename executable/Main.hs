-- It is generally a good idea to keep all your business logic in your library
-- and only use it in the executable. Doing so allows others to use what you
-- wrote in their libraries.
module Main where
import  LogisticRegrecion.IO
import LogisticRegrecion

trainDataFile = "./data/train.csv"
initilaNetFile = "./data/initilaNet.csv"
netFile = "./data/net.csv"
testDataFile = "./data/test.csv"

inputN  = 784
outputN = 10

--initialNet = newRandomNet 784 10

config = TrainConfig {
    trainAlpha = 0.1,
    trainN = 800
}

printResult (ys:yss) (t:ts) = do
    putStrLn $ show ys ++ ' ':show t
    printResult yss ts
printResult _ _ = return ()

main :: IO ()
main = do
    trainData <- readNet trainDataFile 800
    initialNet <- readNet initilaNetFile   10
    (Net testData  targest) <- readNet testDataFile 80
    let trained = train config initialNet trainData
    let test = predic trained <$> testData
    saveNet netFile  trained
    printResult test targest
