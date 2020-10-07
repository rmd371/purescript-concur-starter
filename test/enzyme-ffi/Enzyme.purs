module Enzyme (shallow, text, text_, clickElm, clickElm2, consoleLog, ShallowWrapper) where

import Prelude

import Control.Promise (Promise, toAffE)
import Effect (Effect)
import Effect.Aff (Aff)
import Prim.Row (class Union)
import React (ReactElement)

data ShallowWrapper = Type

foreign import shallow :: ReactElement -> Effect ShallowWrapper
foreign import text :: String -> ShallowWrapper -> String
foreign import text_ :: ShallowWrapper -> String

foreign import _clickElm :: forall r. String -> {|r} -> ShallowWrapper -> Effect (Promise Unit)
clickElm :: forall r. String -> {|r} -> ShallowWrapper -> Aff Unit
clickElm selector event wrapper = toAffE $ _clickElm selector event wrapper

-- mousex, mousey
type Myevent = (mousex :: Int, mousey :: Int)
foreign import _clickElm2 :: forall attrs attrs'. Union attrs attrs' Myevent => String -> Record attrs -> ShallowWrapper -> Effect (Promise Unit)
clickElm2 :: forall attrs attrs'. Union attrs attrs' Myevent => String -> Record attrs -> ShallowWrapper -> Aff Unit
clickElm2 selector event wrapper = toAffE $ _clickElm2 selector event wrapper

foreign import consoleLog :: forall a. a -> Effect Unit
