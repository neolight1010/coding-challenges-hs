module Projection.Project3D where

import Data.Angle (Angle)
import qualified Projection.Project2D as P2

data Camera3D a = Camera3D
  { xAngle :: Angle a,
    yAngle :: Angle a,
    w :: a,
    h :: a
  }

-- | Point in 3D space. The third value is expected to be the depth or Z value.
type Point3D a = (a, a, a)

-- | Projects a 3D point in 2D.
p3D :: Floating a => Camera3D a -> Point3D a -> P2.Point2D a
p3D cam (x, y, z) = (px, py)
  where
    px = P2.p2D camera2DX (x, z)
    py = P2.p2D camera2DY (y, z)

    camera2DX = P2.Camera2D {P2.angle = xAngle cam, P2.w = w cam}
    camera2DY = P2.Camera2D {P2.angle = yAngle cam, P2.w = h cam}
