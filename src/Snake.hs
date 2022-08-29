{-# LANGUAGE DuplicateRecordFields #-}

module Snake
  ( snakeIO,
  )
where

import Graphics.Gloss (Display (InWindow), Picture (Pictures), color, rectangleSolid, simulate, translate)
import qualified Graphics.Gloss.Data.Color as Color
import Graphics.Gloss.Data.ViewPort (ViewPort)

width :: Int
width = 800

height :: Int
height = 600

gridCols :: Int
gridCols = 10

gridRows :: Int
gridRows = 10

gridCellLength :: Float
gridCellLength = min lengthFromHeight lengthFromWidth
  where
    lengthFromHeight = fromIntegral height / fromIntegral gridRows
    lengthFromWidth = fromIntegral width / fromIntegral gridCols

data SnakeGame = SnakeGame
  { snake :: Snake,
    food :: [Food]
  }

data Snake = Snake
  { head :: Coord,
    body :: [Coord],
    direction :: Direction
  }

data Coord = Coord
  { x :: Int,
    y :: Int
  }

data Direction = Up | Down | Left | Right

newtype Food = Food
  { pos :: Coord
  }

snakeIO :: IO ()
snakeIO = simulate (InWindow "Star Field" (width, height) (20, 20)) Color.black 60 newSnakeGame renderSnakeGame updateSnakeGame

renderSnakeGame :: SnakeGame -> Picture
renderSnakeGame game = translate (-fromIntegral width / 2) (fromIntegral height / 2) $ Pictures pictures
  where
    pictures :: [Picture]
    pictures = [snakePicture]

    snakePicture :: Picture
    snakePicture = color Color.white $ Pictures [bodyPicture, headPicture]
      where
        headPicture = snakeRectangleSegment (x $ Snake.head $ snake game) (y $ Snake.head $ snake game)
        bodyPicture = Pictures $ map (\coord -> snakeRectangleSegment (x coord) (y coord)) $ body $ snake game

        snakeRectangleSegment gridX gridY = translate (gridXToDisplayX gridX) (gridYToDisplayY gridY) bodyRectangle

        bodyRectangle =
          rectangleSolid gridCellLength gridCellLength

updateSnakeGame :: ViewPort -> Float -> SnakeGame -> SnakeGame
updateSnakeGame _ _ game = game

newSnakeGame :: SnakeGame
newSnakeGame =
  SnakeGame
    { snake = Snake {head = Coord 0 0, body = [Coord 0 1], direction = Snake.Right},
      food = []
    }

gridXToDisplayX :: Int -> Float
gridXToDisplayX gridX = fromIntegral gridX * gridCellLength + (gridCellLength / 2)

gridYToDisplayY :: Int -> Float
gridYToDisplayY gridY = -fromIntegral gridY * gridCellLength - (gridCellLength / 2)
