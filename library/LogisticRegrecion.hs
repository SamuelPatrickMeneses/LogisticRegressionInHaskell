module LogisticRegrecion where

softmax:: RealFrac a => [a] -> [a]
softmax as =
    let
        maxV = foldl max 0 as
        softEach a = exp $ realToFrac $ realToFrac  a - maxV
        softenValues = realToFrac . softEach <$> as
        sumV = sum softenValues
    in
        [a / sumV | a <- softenValues]

sigmoid:: RealFrac a => [[a]] -> [a] -> [a] -> [a]
sigmoid [] [] _ = []
sigmoid (ws:wss) (b:bs) xs = -- pending: handle exceptions
    let
        dot = sum $ zipWith (*) ws xs
    in
        dot + b : sigmoid wss bs xs

predic:: RealFrac a => [[a]] -> [a] -> [a] -> [a]
predic ws bs xs = softmax $ sigmoid ws bs xs

train:: RealFrac a => a -> a -> [a] -> [[a]] -> [a] -> [a] -> ([a],[[a]])
train alpha trainN targetY ws bs xs =
    let
        ys = predic ws bs xs
        deltasYs = zipWith (-) targetY ys
        lc = alpha / trainN
        fixW dy ws  =
            let
                c = dy * lc
            in
                zipWith (+) ws $  (c*) <$> xs
        fixedBs = zipWith (+) bs $ (lc*) <$> deltasYs 
    in
        (fixedBs, zipWith ($) (fixW <$> deltasYs) ws)
