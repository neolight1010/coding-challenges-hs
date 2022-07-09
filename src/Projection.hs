module Projection
  ( Camera2D (..),
    Point2D,
    p2D,
    px,
    py,
  )
where

import Data.Angle (Angle, tanAngle)

data Camera2D = Camera2D
  { angle :: Angle Float,
    w :: Float
  }

type Point2D = (Float, Float)

-- |Projects a 2D point to 1D.
p2D :: Camera2D -> Point2D -> Float
p2D cam (x', z') = dividend / divisor
  where
    dividend = x' * camW * tanAngle camAngle
    divisor = z' + camW * tanAngle camAngle

    camAngle = angle cam
    camW = w cam

-- X axis aliases

type CameraX = Camera2D

type PointXZ = Point2D

-- |Projects a 2D point to 1D on the X axis. Alias for p2D.
px :: CameraX -> PointXZ -> Float
px = p2D

-- Y axis aliases

type CameraY = Camera2D

type PointYZ = Point2D

-- |Projects a 2D point to 1D on the Y axis. Alias for p2D.
py :: CameraY -> PointYZ -> Float
py = p2D
