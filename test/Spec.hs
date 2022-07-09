import Data.Angle (angleFromDegrees)
import Projection.Project2D (Camera2D (..), Point2D, p2D)
import Test.Hspec
import Projection.Project3D (Camera3D(..), p3D)

main :: IO ()
main = hspec $ do
  describe "Projection on 2D" $ do
    it "returns 0 if x is 0" $ do
      let camera = Camera2D {angle = angleFromDegrees 30, s = 100}

      p2D camera (0, 30) `shouldApproximate` 0

    it "returns the value on the boundaries of the camera" $ do
      let cameraS = 1
      let farS = cameraS + 1
      let camera = Camera2D {angle = angleFromDegrees 45, s = cameraS}

      p2D camera (farS, 1) `shouldApproximate` cameraS

  describe "Projection on 3D" $ do
    it "returns (0, 0) if x and y are 0" $ do
      let camera = Camera3D {xAngle = angleFromDegrees 30, yAngle = angleFromDegrees 30, w = 100, h = 100}
      let (px, py) = p3D camera (0, 0, 30)

      px `shouldApproximate` 0
      py `shouldApproximate` 0

    it "returns the value on the boundaries of the camera" $ do
      let cameraW = 1
      let farW = cameraW + 1

      let cameraH = 1
      let farH = cameraH + 1

      let deg45 = angleFromDegrees 45

      let camera = Camera3D {xAngle = deg45, yAngle = deg45, w = cameraW, h = cameraH}

      let (px, py) = p3D camera (farW, farH, 1)

      px `shouldApproximate` cameraW
      py `shouldApproximate` cameraH


shouldApproximate :: (Fractional a, Ord a, Show a) => a -> a -> Expectation
shouldApproximate a b = do
  a `shouldSatisfy` (> b - allowedError)
  a `shouldSatisfy` (< b + allowedError)
  where
    allowedError = 0.00005
