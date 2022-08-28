{-# LANGUAGE DuplicateRecordFields #-}

module Snake
  ( snakeIO,
  )
where

import Graphics.Gloss (Display (InWindow), Picture, simulate)
import qualified Graphics.Gloss.Data.Color as Color
import Graphics.Gloss.Data.ViewPort (ViewPort)

width :: Int
width = 800

height :: Int
height = 600

type Coord = (Int, Int)

type BodyUnit = Coord

data SnakeGame = SnakeGame
  { snake :: Snake,
    food :: [Food]
  }

data Snake = Snake
  { body :: [BodyUnit],
    direction :: Direction
  }

data Direction = Up | Down | Left | Right

newtype Food = Food
  { pos :: Coord
  }

snakeIO :: IO ()
snakeIO = simulate (InWindow "Star Field" (width, height) (20, 20)) Color.black 60 newSnakeGame renderSnakeGame updateSnakeGame

renderSnakeGame :: SnakeGame -> Picture
renderSnakeGame = undefined

updateSnakeGame :: ViewPort -> Float -> SnakeGame -> SnakeGame
updateSnakeGame = undefined

newSnakeGame :: SnakeGame
newSnakeGame =
  SnakeGame
    { snake = Snake {body = [(0, 0)], direction = Snake.Right},
      food = []
    }
