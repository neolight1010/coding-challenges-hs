module Projection
  ( Camera2D (..),
    Point2D,
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

type CameraX = Camera2D

type PointXZ = Point2D

px :: CameraX -> PointXZ -> Float
px cam (x', z') = dividend / divisor
  where
    dividend = x' * camW * tanAngle camAngle
    divisor = z' + camW * tanAngle camAngle

    camAngle = angle cam
    camW = w cam

type CameraY = Camera2D

type PointYZ = Point2D

py :: CameraY -> PointYZ -> Float
py = px
