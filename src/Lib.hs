module Lib
  ( starFieldIO,
  )
where

import Data.Angle (angleFromDegrees)
import Graphics.Gloss (Display (InWindow), Picture, black, circleSolid, color, pictures, simulate, translate, white)
import Graphics.Gloss.Data.ViewPort (ViewPort)
import Projection.Project3D (Camera3D (..), p3D)

starFieldIO :: IO ()
starFieldIO = simulate (InWindow "Hello World" (width, height) (20, 20)) black 60 newStarField renderStarField updateStarField

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

newStarField :: StarField
newStarField =
  StarField
    { stars =
        [ Star
            { x = 150,
              y = -50,
              z = 20
            },
          Star
            { x = -150,
              y = 200,
              z = 40
            }
        ]
    }

renderStarField :: StarField -> Picture
renderStarField starField = pictures $ map renderStar (stars starField)
  where
    renderStar star = translate px py $ color white $ circleSolid 5
      where
        (px, py) = p3D camera (x star, y star, z star)

updateStarField :: ViewPort -> Float -> StarField -> StarField
updateStarField _ _ starField =
  StarField
    { stars = map updateStar oldStars
    }
  where
    oldStars = stars starField
    updateStar star =
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
