module Colors.Router (..) where

import Effects exposing (Effects)
import Hop
import Hop.Matchers exposing (match1, match2, str)
import Hop.Types exposing (Router, PathMatcher, Location)


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


colorPath : String -> String
colorPath hex =
  "/colors/" ++ hex


rootPath : String
rootPath =
  "/"
