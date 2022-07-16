module Lib
  ( starFieldIO,
  )
where

import Data.Angle (angleFromDegrees)
import Graphics.Gloss (Display (InWindow), Picture, black, circleSolid, color, pictures, simulate, translate, white)
import Graphics.Gloss.Data.ViewPort (ViewPort)
import Projection.Project3D (Camera3D (..), p3D)
import System.Random (RandomGen, mkStdGen, uniformR)

starFieldIO :: IO ()
starFieldIO = simulate (InWindow "Hello World" (width, height) (20, 20)) black 60 (newStarField gen) renderStarField updateStarField
  where
    gen = mkStdGen 500

width :: Int
width = 600

height :: Int
height = 600

newtype StarField = StarField
  { stars :: [Star]
  }

data Star = Star
  { x :: Float,
    y :: Float,
    z :: Float
  }

newStarField :: RandomGen g => g -> StarField
newStarField _ =
  StarField
    { stars =
        map
          ( \i ->
              let gen = mkStdGen $ i + 30
                  (randX, gen') = genRandX gen
                  (randY, gen'') = genRandY gen'
                  (randZ, _) = genRandZ gen''
               in Star
                    { x = randX,
                      y = randY,
                      z = randZ
                    }
          )
          [(0 :: Int) .. 500]
    }
  where
    genRandX = uniformR (fromIntegral $ -width, fromIntegral width)
    genRandY = uniformR (fromIntegral $ -height, fromIntegral height)
    genRandZ = uniformR (1 :: Float, 800)

renderStarField :: StarField -> Picture
renderStarField starField = pictures $ map renderStar (stars starField)
  where
    renderStar star = translate px py $ color white $ circleSolid 5
      where
        (px, py) = p3D camera (x star, y star, z star)

updateStarField :: ViewPort -> Float -> StarField -> StarField
updateStarField _ _ starField =
  StarField
    { stars = oldStars >>= updateStar
    }
  where
    oldStars = stars starField
    updateStar star =
      if z star <= 0
        then []
        else
          return
            Star
              { x = x star,
                y = y star,
                z = z star - 1
              }

camera :: Camera3D Float
camera =
  Camera3D
    { xAngle = angleFromDegrees (30 :: Integer),
      yAngle = angleFromDegrees (30 :: Integer),
      w = fromIntegral width,
      h = fromIntegral height
    }
