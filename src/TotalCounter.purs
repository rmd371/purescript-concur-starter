module TotalCounter (totalCounter) where

import Prelude

import Concur.Core (Widget, liftWidget)
import Concur.React (HTML)
import Concur.React.DOM as D
import Concur.React.Props as P
import Control.Monad.Rec.Class (forever)
import Control.Monad.State (StateT, get, put, runStateT)
import Effect.Class (liftEffect)
import Effect.Class.Console (log)

data CounterType = Hello | Goodbye
type CounterState = {helloCount :: Int, goodbyeCount :: Int, text :: String}

helloCounter :: forall r. StateT {helloCount :: Int, text :: String | r} (Widget HTML) CounterType
helloCounter = do
  liftEffect $ log "helloCounter"
  {helloCount} <- get
  D.div' 
    [ Hello <$ D.button [P.onClick] [D.text $ "Say Hello Again (" <> show (helloCount + 1) <> " times)"]
    , otherText
    ]

otherText :: forall a r. StateT {text :: String | r} (Widget HTML) a
otherText = do
  {text} <- get
  D.text text

goodbyeCounter :: forall r. StateT {goodbyeCount :: Int | r} (Widget HTML) CounterType
goodbyeCounter = do
  {goodbyeCount} <- get
  Goodbye <$ D.div' [D.button [P.onClick] [D.text $ "Say Goodbye Again (" <> show (goodbyeCount + 1) <> " times)"]]

totalCounter :: forall a. Widget HTML a
totalCounter = do
  void $ runStateT totalCounterS {helloCount: 0, goodbyeCount: 0, text: "this is my text"}
  D.text "Actually this will never be reached, but the compiler is not smart enough to deduce that"

totalCounterS :: forall a. StateT CounterState (Widget HTML) a
totalCounterS = forever do
  state <- get
  counterType <- 
    D.div' [
      helloCounter, 
      D.br', 
      goodbyeCounter,
      D.br', 
      D.text $ "Total Counts: " <> (show state.helloCount) <> " " <> (show state.goodbyeCount)
    ]
  put $ case counterType of
    Hello -> state {helloCount = state.helloCount + 1}
    Goodbye -> state {goodbyeCount = state.goodbyeCount + 1}
