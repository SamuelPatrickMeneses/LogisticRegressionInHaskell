module Main where
import  LogisticRegrecion.IO
import LogisticRegrecion

historyFile = "./data/historic.txt"
netFile = "./data/net.csv"
testDataFile = "./data/test.csv"

main :: IO ()
main = do
    net <- readNet netFile 10
    (Net testData  targets) <- readNet testDataFile 80
    let test = predic net <$> testData
    let percent = sum [(test !! x) !! round (targets !! x) |x <-[0..79]] / 80
    putStrLn $ "Current accuracy percent: " ++ show percent ++ "%"
    appendFile historyFile $ show percent ++ "\n"
