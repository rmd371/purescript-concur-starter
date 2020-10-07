{-
Welcome to a Spago project!
You can edit this file as you like.
-}
{ sources = [ "src/**/*.purs", "test/**/*.purs" ]
, name = "purescript-concur-starter"
, dependencies =
  [ "aff-promise"
  , "concur-core"
  , "concur-react"
  , "console"
  , "effect"
  , "psci-support"
  , "spec"
  ]
, packages = ./packages.dhall
}
