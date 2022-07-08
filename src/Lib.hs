module Lib
    ( main
    ) where
import Graphics.Gloss (display, Display (InWindow), white, circle)

main :: IO ()
main = display (InWindow "Hello World" (600, 600) (20, 20)) white $ circle 50
