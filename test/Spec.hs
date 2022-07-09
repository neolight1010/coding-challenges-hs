import Data.Angle (angleFromDegrees)
import Projection.Project2D (Camera2D (..), Point2D, px, py, p2D)
import Test.Hspec

main :: IO ()
main = hspec $ do
  describe "Projection on 2D" $ do
    axisProjectionTest p2D 

  describe "Projection on x" $ do
    axisProjectionTest px

  describe "Projection on y" $ do
    axisProjectionTest py

axisProjectionTest :: (Camera2D -> Point2D -> Float) -> SpecWith ()
axisProjectionTest proj = do
  it "returns 0 if x is 0" $ do
    let camera = Camera2D {angle = angleFromDegrees 30, w = 100}

    proj camera (0, 30) `shouldBe` 0

  it "returns the value on the boundaries of the camera" $ do
    let cameraW = 1
    let farW = cameraW + 1
    let camera = Camera2D {angle = angleFromDegrees 45, w = cameraW}

    px camera (farW, 1) `shouldBe` cameraW
