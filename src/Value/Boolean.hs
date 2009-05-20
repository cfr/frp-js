{-# LANGUAGE TypeOperators #-}
module Value.Boolean where

import Core.Val

instance ToText Boolean where
  text = prim "/*cast*/"

_if :: Boolean :->: a :->: a :~>: a
_if = prim3 "$(function(c,i,e)c?i:e)"

while :: a :->: Boolean :~>: a
while = prim2 "$(function(i,c)c?i:this.v)"

infix  4  ==:, !=:
infixr 3  &&
infixr 2  ||

not :: Boolean :~>: Boolean
not = prim "$(function(a)!a)"

(==:) :: a :->: a :~>: Boolean
(==:) = prim2 "$(function(a,b)a==b)"

(!=:) :: a :->: a :~>: Boolean
(!=:) = prim2 "$(function(a,b)a!=b)"

(&&) :: Boolean :->: Boolean :~>: Boolean
(&&) = prim2 "$(function(a,b)a&&b)"

(||) :: Boolean :->: Boolean :~>: Boolean
(||) = prim2 "$(function(a,b)a||b)"

