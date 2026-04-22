module Visualiser.Image where

import Graphics.Gloss
import Visualiser.Vec3

squer:: Vec3 -> Float -> Float -> Float -> Picture
squer (Vec3 x y _) w h c = 
    let 
        hw = w/2
        hh = h/2
    in 
        Translate  x y $ Color (greyN $ 1-c) $ Polygon [
                (-hw, hh),
                (-hw, -hh),
                (hw, -hh),
                (hw, hh)
            ]

invert:: [Float] -> [Float]
invert [] = []
invert ls =
    invert  (drop 28 ls) ++ take 28 ls

image:: Vec3 -> Float -> Float -> [Float] -> Picture
image (Vec3 x y _) w h cs =
    let
        pxw    = w/28
        pxh    = h/28
        firstX = w/(-2) + pxw/2
        firstY = h/(-2) + pxh/2
        range  = [
                squer (Vec3 (sx * pxw + firstX) (sy * pxh + firstY) 0) pxw pxh
                | sy <- [0..27], sx <- [0..27]
            ]
    in
        Translate x y $ Pictures $ zipWith ($) range $ invert  cs


neuron:: Vec3 -> Float -> Float -> [Float] -> Picture
neuron (Vec3 x y _) w h cs =
    let
        squer (Vec3 sx sy _) sw sh c = 
            let 
                hw = sw/2
                hh = sh/2
            in 
                Translate  sx sy $ Color (greyN $ c / 2 + 1) $ Polygon [
                        (-hw, hh),
                        (-hw, -hh),
                        (hw, -hh),
                        (hw, hh)
                    ]

        pxw    = w/28
        pxh    = h/28
        firstX = w/(-2) + pxw/2
        firstY = h/(-2) + pxh/2
        range  = [
                squer (Vec3 (sx * pxw + firstX) (sy * pxh + firstY) 0) pxw pxh
                | sy <- [0..27], sx <- [0..27]
            ]
    in
        Translate x y $ Pictures $ zipWith ($) range $ invert  cs
