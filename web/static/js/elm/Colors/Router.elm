module Colors.Router (..) where

import Effects exposing (Effects)
import Hop
import Hop.Matchers exposing (match1, match2, str)
import Hop.Types exposing (Config, Router, PathMatcher, Location)
import Html exposing (Html, Attribute, a)
import Html.Attributes exposing (href)
import Hop.Navigate
import Html.Events exposing (onWithOptions, defaultOptions)
import Json.Decode exposing (value)


type Route
  = HomeRoute
  | ViewColorRoute String
  | NotFoundRoute
  | LoadingRoute


navigateTo : String -> Effects.Effects ()
navigateTo =
  Hop.Navigate.navigateTo routerConfig


routerMailbox : Signal.Mailbox String
routerMailbox =
  Signal.mailbox ""


routerConfig : Config Route
routerConfig =
  { hash = False
  , basePath = "/"
  , matchers = matchers
  , notFound = NotFoundRoute
  }


matchers : List (PathMatcher Route)
matchers =
  [ match1 HomeRoute ""
  , match2 ViewColorRoute "/colors/" str
  ]


router : Router Route
router =
  Hop.new routerConfig


linkTo : String -> List Attribute -> List Html -> Html
linkTo path attrs inner =
  let
    customLinkAttrs =
      [ href path
      , onClick' routerMailbox.address path
      ]
  in
    a (attrs ++ customLinkAttrs) inner


colorPath : String -> String
colorPath hex =
  "/colors/" ++ hex


rootPath : String
rootPath =
  "/"


onClick' : Signal.Address a -> a -> Attribute
onClick' addr msg =
  onWithOptions
    "click"
    { defaultOptions | preventDefault = True }
    value
    (\_ -> Signal.message addr msg)
