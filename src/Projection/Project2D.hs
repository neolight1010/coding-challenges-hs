module Projection.Project2D
  ( Camera2D (..),
    Point2D,
    p2D,
    px,
    py,
  )
where

import Data.Angle (Angle, tanAngle)
import Numeric ()

data Camera2D a = Camera2D
  { angle :: Angle a,
    w :: a
  }

type Point2D a = (a, a)

-- |Projects a 2D point to 1D.
p2D :: Floating a => Camera2D a -> Point2D a -> a
p2D cam (x', z') = dividend / divisor
  where
    dividend = x' * camW * tanAngle camAngle
    divisor = z' + camW * tanAngle camAngle

    camAngle = angle cam
    camW = w cam

-- X axis aliases

type CameraX = Camera2D

type PointXZ a = Point2D a

-- |Projects a 2D point to 1D on the X axis. Alias for p2D.
px :: Floating a => CameraX a -> PointXZ a -> a
px = p2D

-- Y axis aliases

type CameraY = Camera2D

type PointYZ a = Point2D a

-- |Projects a 2D point to 1D on the Y axis. Alias for p2D.
py :: Floating a => CameraY a -> PointYZ a -> a
py = p2D
