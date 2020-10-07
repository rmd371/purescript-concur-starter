module Test.Main where

import Prelude

import Concur.React (renderComponent)
import Effect (Effect)
import Effect.Aff (Aff, launchAff_)
import Effect.Class (liftEffect)
import Enzyme (ShallowWrapper, clickElm, clickElm2, shallow, text, text_)
import Main (hello)
import Test.Spec (before, describe, it)
import Test.Spec.Assertions (shouldEqual)
import Test.Spec.Reporter (consoleReporter)
import Test.Spec.Runner (runSpec)

helloWrapper :: Aff ShallowWrapper
helloWrapper = liftEffect $ shallow $ renderComponent hello

main :: Effect Unit
main = launchAff_ $ runSpec [consoleReporter] do
  describe "hello world tests" do
    before helloWrapper do
      it "should display 'say hello' initially" \w -> do
        text "button" w `shouldEqual` "Say Hello"
      it "should display 'Hello World!' when the 'say hello' button is clicked" \w -> do
        clickElm "button" {} w
        clickElm "button" {} w
        text_ w `shouldEqual` "Hello World!"
      it "should display 'Hello World!' when the 'say hello' button is clicked" \w -> do
        clickElm2 "button" {mousex: 5} w
        clickElm2 "button" {} w
        text_ w `shouldEqual` "Hello World!"
