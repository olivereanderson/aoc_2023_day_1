module CalibrationValue

import Data.Vect
import Data.String
import Data.Maybe
import Data.List

parseFirstAndLastDigit : List Char -> Maybe (Vect 2 Nat)
parseFirstAndLastDigit line = foldr accumulator Nothing line
  where accumulator: Char -> Maybe (Vect 2 Nat)-> Maybe (Vect 2 Nat)
        accumulator character maybeVect = case parsePositive $ singleton character of
              Nothing => maybeVect
              -- If we have yet to produce a vector we generate a new one where both entries are the parsed number
              -- otherwise we replace the first entry of the accumulated vector with the parsed number
              -- the maybe function picks the first argument on Nothing and calls the given function otherwise
              -- We need to wrap these arguments in Lazy using `Delay` as Idris is not lazy by default in contrast to
              -- Haskell. Moreover Idris ensures at compile time that the index `0` passed to replaceAt is
              -- within bounds! 
              Just number => pure (maybe (Delay [number, number]) (Delay (replaceAt 0 number)) maybeVect)

              
export
parseCalibrationValue: String -> Nat
parseCalibrationValue input = case parseFirstAndLastDigit (unpack input) of
  Just (parsed) => ((index 0 parsed) * 10) + index 1 parsed  
  Nothing => Z

