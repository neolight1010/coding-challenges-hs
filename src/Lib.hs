module Lib
  ( starFieldIO,
  )
where

import Graphics.Gloss (Display (InWindow), Picture, simulate, white)
import Graphics.Gloss.Data.ViewPort (ViewPort)

starFieldIO :: IO ()
starFieldIO = simulate (InWindow "Hello World" (width, height) (20, 20)) white 60 newStarField renderStarField updateStarField

width :: Int
width = 600

height :: Int
height = 600

data StarField = StarField
  { stars :: [Star]
  }

data Star = Star
  { x :: Int,
    y :: Int
  }

newStarField :: StarField
newStarField =
  StarField
    { stars = []
    }

renderStarField :: StarField -> Picture
renderStarField = undefined

updateStarField :: ViewPort -> Float -> StarField -> StarField
updateStarField = undefined
