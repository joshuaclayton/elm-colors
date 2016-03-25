module Colors.Router (..) where

import Effects exposing (Effects)
import Hop
import Hop.Matchers exposing (match1, match2, str)
import Hop.Types exposing (Router, PathMatcher, Location)
import Html exposing (Html, Attribute, a)
import Html.Attributes exposing (href)


type Route
  = HomeRoute
  | ViewColorRoute String
  | NotFoundRoute


matchers : List (PathMatcher Route)
matchers =
  [ match1 HomeRoute "/"
  , match2 ViewColorRoute "/colors/" str
  ]


router : Router Route
router =
  Hop.new
    { matchers = matchers
    , notFound = NotFoundRoute
    }


linkTo : String -> List Attribute -> List Html -> Html
linkTo path attrs inner =
  a ((href <| "#" ++ path) :: attrs) inner


colorPath : String -> String
colorPath hex =
  "/colors/" ++ hex


rootPath : String
rootPath =
  "/"
