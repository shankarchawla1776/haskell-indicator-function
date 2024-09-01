import Data.Char (digitToInt, toLower)
import Data.List (findIndex)
import Text.Read (readMaybe)
import Data.Maybe (mapMaybe)
import System.IO (hFlush, stdout)

toBinary :: [Int] -> String
-- f: Z -> {0, 1}
toBinary = map (\x -> if x /= 0 then '1' else '0')

-- sum to |C_i| - 1 and multiply by s_j * the according power of 2 
toDec :: String -> Int
toDec = foldl (\acc x -> acc * 2 + digitToInt x) 0

-- replace the first zero with the decimal
-- omit all other zeros 
replaceFZero :: [Int] -> Int -> [Int]
replaceFZero lst decimal =
    case findIndex (== 0) lst of
        Just i -> let newList = take i lst ++ [decimal] ++ drop (i + 1) lst
                  in filter (/= 0) newList
        Nothing -> lst


parseBlock :: [Int] -> [Int]
parseBlock block = 
    let binStr = toBinary block 
        decVal = toDec binStr
    in replaceFZero block decVal

parseDigits :: FilePath -> Int -> FilePath -> IO ()
parseDigits inputFile blockLength outputFile = do 
    contents <- readFile inputFile
    let ints = mapMaybe (readMaybe :: String -> Maybe Int) (wordsWhen (== ',') contents)
        blocks = chunk blockLength ints
        isProcessed = map parseBlock blocks
        output = concat isProcessed

    writeFile outputFile (unwords (map show output))
    
wordsWhen :: (Char -> Bool) -> String -> [String]
wordsWhen p s = case dropWhile p s of 
    "" -> []
    s' -> w : wordsWhen p s''
        where (w, s'') = break p s'

chunk :: Int -> [a] -> [[a]] -- divide divide into m chunks
chunk _ [] = []
chunk n xs = take n xs : chunk n (drop n xs)

main :: IO ()
main = do 

    putStr "Block Size (Int or n for 1 block): "
    hFlush stdout

    blockSizeInput <- getLine 

    let blockLength = case map toLower blockSizeInput of 
                        "n" -> 1
                        _ -> read blockSizeInput :: Int

    putStr "Input filepath (.txt): "
    hFlush stdout 
    inputFile <- getLine 

    putStr "Output filepath (.txt): "
    hFlush stdout 

    outputFile <- getLine 

    parseDigits inputFile blockLength outputFile
