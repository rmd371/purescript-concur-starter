module Hello where

import Prelude

import Concur.Core (Widget, liftWidget)
import Concur.React (HTML)
import Concur.React.DOM as D
import Concur.React.Props as P
import Control.Monad.Rec.Class (forever)
import Control.Monad.State.Class (get, put)
import Control.Monad.State.Trans (StateT, runStateT)
import React.SyntheticEvent (SyntheticMouseEvent)

helloWidget :: forall a. Widget HTML a
helloWidget = do
  void $ runStateT helloWidgetS 0
  D.text "Actually this will never be reached, but the compiler is not smart enough to deduce that"

helloWidgetS :: forall a. StateT Int (Widget HTML) a
helloWidgetS = forever do
  count <- get
  --void $ D.div' [ D.button [P.onClick] [D.text ("For the " <> show count <> " time, hello sailor!")] ]
  --void $ helloDiv count
  void $ liftWidget $ helloDiv count
  put (count + 1)

helloDiv :: Int -> Widget HTML SyntheticMouseEvent
helloDiv count = D.div' [ D.button [P.onClick] [D.text ("For the " <> show count <> " time, hello sailor!")] ]