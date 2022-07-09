module Projection.Project2D
  ( Camera2D (..),
    Point2D,
    p2D,
  )
where

import Data.Angle (Angle, tanAngle)
import Numeric ()

data Camera2D a = Camera2D
  { angle :: Angle a,
    w :: a
  }

type Point2D a = (a, a)

-- | Projects a 2D point to 1D. The second value is expected to be the depth
-- or Z value.
p2D :: Floating a => Camera2D a -> Point2D a -> a
p2D cam (x', z') = dividend / divisor
  where
    dividend = x' * camW * tanAngle camAngle
    divisor = z' + camW * tanAngle camAngle

    camAngle = angle cam
    camW = w cam
