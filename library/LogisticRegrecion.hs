module LogisticRegrecion where

data (RealFrac v) => TrainConfig v =  TrainConfig{trainAlpha::v, trainN::v}

data Net a = Net [[a]] [a]

treatTarget:: RealFrac a  => a -> [a]
treatTarget a = 
    let
        aux _ (-1) = []
        aux n b
            | n == b    = 1:aux n (b-1)
            | otherwise = 0:aux n (b-1)
    in
        aux a 9

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
sigmoid (ws:wss) (b:bs) xs =
    let
        dot = sum $ zipWith (*) ws xs
    in
        dot + b : sigmoid wss bs xs
sigmoid _ _ _ = error "for all weights[n][m] shoud be bias[n]!" -- pending: handle exceptions

predic:: RealFrac a => [[a]] -> [a] -> [a] -> [a]
predic ws bs xs = softmax $ sigmoid ws bs xs

train:: RealFrac a => TrainConfig a -> Net a -> [a] -> a -> Net a
train tc (Net wss bs) xs y =
    let
        targetY = treatTarget y
        ys = predic wss bs xs
        deltasYs = zipWith (-) targetY ys
        lc = trainAlpha tc / trainN tc
        fixW dy ws  =
            let
                c = dy * lc
            in
                zipWith (+) ws $  (c*) <$> xs
        fixedBs = zipWith (+) bs $ (lc*) <$> deltasYs 
    in
        Net ( zipWith ($) (fixW <$> deltasYs) wss) fixedBs
