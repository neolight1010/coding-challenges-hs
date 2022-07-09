module Lib
  ( starFieldIO,
  )
where

import Graphics.Gloss (Display (InWindow), Picture, black, circle, circleSolid, color, pictures, simulate, thickCircle, translate, white)
import Graphics.Gloss.Data.ViewPort (ViewPort)

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
    y :: Float
  }

newStarField :: StarField
newStarField =
  StarField
    { stars =
        [ Star
            { x = 0,
              y = 0
            },
          Star
            { x = -150,
              y = 200
            }
        ]
    }

renderStarField :: StarField -> Picture
renderStarField starField = pictures $ map renderStar (stars starField)
  where
    renderStar star = translate (x star) (y star) $ color white $ circleSolid 5

updateStarField :: ViewPort -> Float -> StarField -> StarField
updateStarField _ _ starField = starField
