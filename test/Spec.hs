import Data.Angle (angleFromDegrees)
import Projection.Project2D (Camera2D (..), Point2D, p2D)
import Test.Hspec

main :: IO ()
main = hspec $ do
  describe "Projection on 2D" $ do
    it "returns 0 if x is 0" $ do
      let camera = Camera2D {angle = angleFromDegrees 30, w = 100}

      p2D camera (0, 30) `shouldApproximate` 0

    it "returns the value on the boundaries of the camera" $ do
      let cameraW = 1
      let farW = cameraW + 1
      let camera = Camera2D {angle = angleFromDegrees 45, w = cameraW}

      p2D camera (farW, 1) `shouldApproximate` cameraW

shouldApproximate :: (Fractional a, Ord a, Show a) => a -> a -> Expectation
shouldApproximate a b = do
  a `shouldSatisfy` (> b - allowedError)
  a `shouldSatisfy` (< b + allowedError)
  where
    allowedError = 0.00005
