module Core.NewCompiler where

import Control.Monad.Identity
import Control.Monad.State
import Core.Raw
import Data.List (intercalate)
import Data.Reify
import qualified Core.Val as Ix

frpValues :: Ix.FRP () -> IO (Graph Val)
frpValues = fromIxValues . runIdentity . flip execStateT []

compiler1 :: Ix.FRP () -> IO String
compiler1 = fmap (intercalate "\n" . worker) . frpValues

worker :: Graph Val -> [String]
worker = foldVal
  (\_ i f a   -> mkAssign i ++ mkId f ++ "(" ++ intercalate "," (map mkId a) ++ ")")
  (\_ i a b   -> mkAssign i ++ mkId a ++ "(" ++ mkId b ++ ")")
  (\_ i fs    -> mkAssign i ++ "$(listify)(" ++ intercalate "," (map mkId fs) ++ ")")
  (\_ i a b   -> mkAssign i ++ "C(" ++ mkId a ++ "," ++ mkId b ++ ")")
  (\_ i _ _ s -> mkAssign i ++ s)

mkId :: Int -> String
mkId i = '_':show i

mkAssign :: Int -> String
mkAssign i = ('_':show i) ++ " = "

