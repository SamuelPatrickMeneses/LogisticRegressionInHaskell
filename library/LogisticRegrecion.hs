module LogisticRegrecion where

import System.Random (randoms, mkStdGen)

data (RealFrac v) => TrainConfig v =  TrainConfig{trainAlpha::v, trainN::v}

data (RealFrac a, Show a, Read a) => Net a =  Net [[a]] [a] deriving (Show, Read, Eq)

newRandomNet:: Int -> Int -> Net Float
newRandomNet inputN outputN = 
    let
        rlist:: Int -> [Float]
        rlist l = fmap ((1/) . fromInteger) $ take l $ randoms $ mkStdGen 10 -- shold fix thet
        bs  = rlist outputN
        wss = [rlist inputN | _ <- [1 .. outputN]] 
    in
        Net wss bs

treatTarget:: RealFrac a  => a -> [a]
treatTarget a = 
    let
        aux _ (10) = []
        aux n b
            | n == b    = 1:aux n (b+1)
            | otherwise = 0:aux n (b+1)
    in
        aux a 0

softmax:: RealFrac a => [a] -> [a]
softmax as =
    let
        maxV = foldl max 0 as
        softEach v = exp $ realToFrac $ realToFrac  v - maxV
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

predic:: (RealFrac a, Show a, Read a) => Net a -> [a] -> [a]
predic (Net wss bs) xs = softmax $ sigmoid wss bs xs

trainStep:: (RealFrac a, Show a, Read a) => TrainConfig a -> Net a -> [a] -> a -> Net a
trainStep tc net@(Net wss bs) xs y =
    let
        targetY = treatTarget y
        ys = predic net xs
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

train:: (RealFrac a, Show a, Read a) => TrainConfig a -> Net a -> Net a -> Net a
train tconf net (Net (xs:xss) (y:ys)) = 
    let 
        netStep = trainStep tconf net xs y
    in
        train tconf netStep (Net xss ys)
train _ n _ = n

epohc:: (RealFrac a, Show a, Read a) => TrainConfig a -> Net a -> Net a -> Int -> Net a
epohc config net td c =
    let
        trained = train config net td
    in
        if c > 0 then
            epohc config trained td (c - 1)
        else
            net
