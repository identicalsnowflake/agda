
module InternalTests.TypeChecking.Coverage.SplitTree () where

import Agda.TypeChecking.Coverage.SplitTree

import Test.QuickCheck

------------------------------------------------------------------------------
-- * Generating random split trees for testing

instance Arbitrary a => Arbitrary (SplitTree' a) where
  arbitrary = frequency
    [ (5, return $ SplittingDone 0)
    , (3, (SplitAt . defaultArg) <$> choose (1,5) <*> (take 3 <$> listOf1 arbitrary))
    ]

-- * Testing the printer

newtype CName = CName String
instance Show CName where
  show (CName s) = s

instance Arbitrary CName where
  arbitrary = CName <$> elements
    [ "zero", "suc", "nil", "cons", "left", "right", "just", "nothing" ]

testSplitTreePrinting :: IO ()
testSplitTreePrinting = sample (arbitrary :: Gen (SplitTree' CName))
