module Snake
  ( snakeIO,
  )
where

import Graphics.Gloss.Data.ViewPort (ViewPort)
import Graphics.Gloss (Picture, simulate, Display (InWindow),)
import qualified Graphics.Gloss.Data.Color as Color

width :: Int
width = 800

height :: Int
height = 600

data SnakeGame = SnakeGame {
}

snakeIO :: IO ()
snakeIO = simulate (InWindow "Star Field" (width, height) (20, 20)) Color.black 60 SnakeGame renderSnakeGame updateSnakeGame

renderSnakeGame :: SnakeGame -> Picture
renderSnakeGame = undefined

updateSnakeGame :: ViewPort -> Float -> SnakeGame -> SnakeGame
updateSnakeGame = undefined
