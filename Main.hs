{-# LANGUAGE OverloadedStrings #-}
import qualified Data.Text.IO as TIO
import Data.Text (Text)
import qualified Data.Text as Text
import Data.Foldable (foldl')
import Data.Map (Map, (!))
import Data.List (sortBy)
import Data.Ord (comparing, Down(..))
import qualified Data.Map as Map

main :: IO ()
main = do
  str <- TIO.getContents
  let result = frequencyMap (Text.lines str)
  mapM_ print (topEntries result)

topEntries :: Map Text Int -> [(Text, Int)]
topEntries m = entries where
  entries :: [(Text, Int)]
  entries = take 20 $ sortBy (comparing (Down . score)) $ filter valid $ Map.toList m
  valid :: (Text, Int) -> Bool
  valid (t, i)
    | i <= 1 = False
    | Text.isPrefixOf ">" t = False
    | otherwise = True
  score :: (Text, Int) -> Int
  score (t, i) = Text.length t * i

frequencyMap :: [Text] -> Map Text Int
frequencyMap (x:xs) = foldl' go (Map.singleton x 1) xs where
  go oldMap newEntry = Map.insertWith (+) newEntry 1 oldMap
