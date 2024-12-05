module LogisticRegrecion.IO where
import System.IO 
import Data.Text (pack, unpack, cons, snoc, uncons, unsnoc)
import LogisticRegrecion

readLines:: Int -> Handle -> IO [String]
readLines n h = do
    eof <- hIsEOF h
    if not eof && n > 0
        then do
            l  <- hGetLine h;
            ls <- readLines (n-1) h
            return (l : ls)  
        else return []

readCSV:: FilePath -> Int -> IO [[Float]]
readCSV p ln = do
    handle <- openFile p ReadMode
    ls <- readLines ln handle
    hClose handle
    return $ read . unpack . cons '[' . (`snoc` ']') .  pack <$> ls


readNet:: FilePath -> Int -> IO (Net Float)
readNet p ln = do
    matrix <- readCSV p ln 
    return $ Net (tail <$> matrix) (head <$> matrix)

saveNet:: (RealFrac a, Show a, Read a) => FilePath -> Net a -> IO ()
saveNet p (Net wss bs) = 
    let
        matrix    =  zipWith (:) bs   wss
    in do
        saveMatrix p matrix

saveMatrix:: (RealFrac a, Show a, Read a) => FilePath -> [[a]] -> IO ()
saveMatrix p matrix = 
    let
        popChar t = case unsnoc t of
                    Just (tx, _) -> tx
                    Nothing      -> pack ""
        shiftChar t = case uncons t of
                    Just (_, tx) -> tx
                    Nothing      -> pack ""
        csv       =  unpack . shiftChar . popChar . pack . show <$> matrix

        appendF (l:ls) = do
            appendFile p l
            appendFile p "\n"
            appendF ls
        appendF [] = return ()
    in do
        writeFile p ""
        appendF csv
