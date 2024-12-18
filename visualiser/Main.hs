-- It is generally a good idea to keep all your business logic in your library
-- and only use it in the executable. Doing so allows others to use what you
-- wrote in their libraries.
module Main where
import LogisticRegrecion.IO
import LogisticRegrecion
import Visualiser.Image
import Visualiser.Vec3
import Graphics.Gloss as G
import Graphics.Gloss.Interface.IO.Interact
import Data.Foldable (Foldable(fold))
testDataFile = "./data/test.csv"
netFile = "./data/net.csv"

displayMode:: Display
displayMode = InWindow "" (800, 300) (100,100)



step:: Float -> [[Float]] -> [[Float]]
step dt w = tail w

evet:: Event -> [[Float]] -> [[Float]]
evet e w = w

maxV a = 
    let
        aux [] _ _ mi = mi
        aux (v:vs) c mv mi
            | v > mv    = aux vs (c+1) v  c 
            | otherwise = aux vs (c+1) mv mi

    in
        aux a 0 0 0
main :: IO ()
main = do
    --  trainData <- readNet trainDataFile 800
    net@(Net wss bs) <- readNet netFile  10
    (Net testData  _) <- readNet testDataFile 80
    --  let trained = epohc config initialNet trainData 10
    let test v =  maxV $ predic net v
    --saveNet netFile  trained
    -- printResult test targest
    let draw w = Pictures [
            image (Vec3 (-250) 0 0) 150 200  $ head w,
            Translate (-100) (-90) $ Scale 2 2 $ Text "=",
            --Pictures [neuron (Vec3 0 (i*65-280) 0) 40 55 $ wss !! round i |i <- [0..9]],
            Translate 100 (-90) $ Scale 2 2 $ Text $ show . test . head $ w]
    G.play displayMode (greyN 0.5) 1 testData draw evet step
