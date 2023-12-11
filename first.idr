module Main

import CalibrationValue
import Data.String
import Data.List
import System.File

sumCalibrationValues: String -> Nat
sumCalibrationValues input = sum $ map parseCalibrationValue (lines input)
 
main : IO ()
main = do
  file <- readFile "first_input.txt"
  case file of
    Right file => printLn $ show $ sumCalibrationValues file
    Left err => printLn $ show err
