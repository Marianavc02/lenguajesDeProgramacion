import Test.QuickCheck
import Text.Show.Functions
-- Función primer orden y polimorfica
f2 :: (a -> b) -> a -> b
f2 f a = f a

prop_f2 :: (Int -> Bool) -> Int -> Bool
prop_f2 fn a = f2 fn a == fn a

main :: IO ()
main = quickCheck prop_f2


