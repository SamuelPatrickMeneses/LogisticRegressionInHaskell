module LogisticRegrecion.IO where
import System.IO 
import Data.Text (cons, snoc, pack, unpack)

readLines:: Int -> Handle -> IO [String]
readLines n h = do
    eof <- hIsEOF h
    if not eof && n > 0
        then do
            l  <- hGetLine h;
            ls <- readLines (n-1) h
            return (l : ls)  
        else return []

readTrainData:: FilePath -> Int -> IO [[Float]]
readTrainData p ln = do
    handle <- openFile p ReadMode
    ls <- readLines ln handle
    return $ read . unpack . cons '[' . (`snoc` ']') .  pack <$> ls
