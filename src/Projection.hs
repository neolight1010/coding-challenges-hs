module Projection
  ( Camera (..),
    px,
  )
where

import Graphics.Gloss.Geometry.Angle (degToRad)

data Camera = Camera
  { angle :: Float,
    w :: Float
  }

type PointXZ = (Float, Float)

px :: Camera -> PointXZ -> Float
px cam (x', z') = dividend / divisor
  where
    dividend = x' * camW * tan camAngleRad
    divisor = z' + camW * tan camAngleRad

    camAngleRad = degToRad $ angle cam
    camW = w cam
