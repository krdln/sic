module Main where

import Text.Printf

import ParSic (pExp, myLexer)
import AbsSic
import ErrM
import PrintSic (printTree)

eval :: Double -> Exp -> Double
eval last e = case e of
	EAdd a b -> eval last a + eval last b
	ESub a b -> eval last a - eval last b
	EMul a b -> eval last a * eval last b
	EDiv a b -> eval last a / eval last b
	EPow a b -> eval last a ** eval last b
	EVal f -> vval f
	EValSuf f suf -> vval f * sval suf
	ENeg e -> - eval last e
	EPrev -> last
	
	EC -> 299792458
	EPi -> pi
	
	EMin -> 60
	EHour -> 60 * eval 0 EMin
	EDay -> 24 * eval 0 EHour
	EWeek -> 7 * eval 0 EDay
	EMonth -> 30 * eval 0 EDay
	EYear -> 365 * eval 0 EDay

vval :: Val -> Double
vval (VInt i) = fromInteger i
vval (VDub f) = f

sval :: Suf -> Double
sval S3P = 1e3
sval S6P = 1e6
sval S9P = 1e9
sval S12P = 1e12
sval S15P = 1e15
sval S18P = 1e18
sval S21P = 1e21
sval S24P = 1e24
sval S3N = 1e-3
sval S6N = 1e-6
sval S9N = 1e-9
sval S12N = 1e-12
sval S15N = 1e-15
sval S18N = 1e-18
sval S21N = 1e-21
sval S24N = 1e-24

sufs :: [Char]
sufs = "yzafpnum kMGTPERZY"

prec_printf_abs :: Double -> String
prec_printf_abs x
	| x >= 0.1 && x < 1 = printf "%.4f" x
	| x >= 1 && x < 10 = printf "%.3f" x
	| x >= 10 && x < 100 = printf "%.2f" x
	| x >= 100 && x < 1000 = printf "%.1f" x
	| x >= 1000 = printf "%.0f" x
	| otherwise = printf "%f" x

ogarnij :: [Char] -> Double -> Double -> String
ogarnij [suf] mul f = prec_printf_abs (f/mul) ++ [' ', suf]
ogarnij (suf:tail) mul f
	| f / mul < 999 = prec_printf_abs (f/mul) ++ [' ', suf]
	| otherwise = ogarnij tail (mul*1000) f

show_w_suf :: Double -> String
show_w_suf x 
	| x >= 0    = ogarnij sufs 1e-24 x
	| otherwise = '-' : ogarnij sufs 1e-24 (-x)

calc_line :: Double -> String -> (Double, String)
calc_line prev line = let tokens = myLexer line in
	case pExp tokens of
		Ok e  -> (res, " = " ++ show_w_suf res) where res = eval prev e
		Bad e -> (prev, e)

dirty_fold :: (a -> b -> (a,c)) -> a -> [b] -> [c]
dirty_fold f prev []    = []
dirty_fold f prev (h:t) = res : dirty_fold f next t where (next, res) = f prev h

info :: String
info = unlines [
	"SIC -- Calculator (+-*/^) with SI prefixes. _ = last value. Ctrl+D to quit.",
	"Constants: c, pi, min, hour, day, week, month, year."]

main :: IO ()
main = interact $
	unlines . (info:) . map (++"\n") . dirty_fold calc_line 0 . lines
