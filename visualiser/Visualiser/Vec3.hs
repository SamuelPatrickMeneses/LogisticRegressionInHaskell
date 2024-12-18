module Visualiser.Vec3  where

-- | An example function.
data Vec3 = Vec3{
                    xProp:: Float,
                    yProp:: Float,
                    zProp:: Float
                }     
infixr 6 ^+^
(^+^)::Vec3 -> Vec3 -> Vec3
(Vec3 x1 y1 z1) ^+^ (Vec3 x2 y2 z2) = Vec3{
                    xProp =  x1 + x2,
                    yProp =  y1 + y2,
                    zProp =  z1 + z2
                }       
infixr 6 ^-^
(^-^)::Vec3 -> Vec3 -> Vec3
(Vec3 x1 y1 z1) ^-^ (Vec3 x2 y2 z2) = Vec3{
                    xProp =  x1 - x2,
                    yProp =  y1 - y2,
                    zProp =  z1 - z2
                }
infixr 6 <.>
(<.>)::Vec3 -> Vec3 -> Float
(Vec3 x1 y1 z1) <.> (Vec3 x2 y2 z2) =  x1*x2 + y1*y2 + z1*z2   

infixr 6 ><
(><)::Vec3 -> Vec3 -> Vec3 
(Vec3 x1 y1 z1) >< (Vec3 x2 y2 z2) = Vec3{
                    xProp =  y1*z2 - z1*y2,
                    yProp =  z1*x2 - x1*z2,
                    zProp =  x1*y2 - y1*x2
                }

infixr 7 *^
(*^)::Float -> Vec3 -> Vec3 
m *^ (Vec3 x y z) = Vec3{
                    xProp =  x * m,
                    yProp =  y * m,
                    zProp =  z * m
                }       

infixr 7 ^/
(^/)::Vec3 -> Float -> Vec3 
(Vec3 x y z) ^/ m = Vec3{
                    xProp =  x / m,
                    yProp =  y / m,
                    zProp =  z / m
                }       

vecMagnitude:: Vec3 -> Float
vecMagnitude (Vec3 x y z) = sqrt ( x ** 2 + y ** 2 + z ** 2 )

normalize v = 
    let m = vecMagnitude v 
    in v ^/ m

showFloat v = if v < 0 
                then "(" ++ show v ++ ")"
                else show v

instance Show Vec3 where
    show (Vec3 x y z)= "Vec3 " 
        ++ showFloat x ++ " " 
        ++ showFloat y ++ " " 
        ++ showFloat z 

paralelAceleration a v =
    let vHat = normalize v
    in (vHat <.> a) *^ vHat

orthogonalAceleration a v = a ^-^ paralelAceleration a v
