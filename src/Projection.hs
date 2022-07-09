module Projection
  ( Camera (..),
    px,
    py,
  )
where

import Data.Angle (Angle, tanAngle)

data Camera = Camera
  { angle :: Angle Float,
    w :: Float
  }

type PointXZ = (Float, Float)

px :: Camera -> PointXZ -> Float
px cam (x', z') = dividend / divisor
  where
    dividend = x' * camW * tanAngle camAngle
    divisor = z' + camW * tanAngle camAngle

    camAngle = angle cam
    camW = w cam

type PointYZ = (Float, Float)

py :: Camera -> PointYZ -> Float
py = px
