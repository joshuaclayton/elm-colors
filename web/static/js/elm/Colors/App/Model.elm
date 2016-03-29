module Colors.App.Model (..) where

import Effects exposing (Effects)
import Hop.Types exposing (Location, newLocation)
import Colors.Router exposing (Route, Route(..))
import Colors.Search.Model
import Colors.RandomColor.Model


type alias Model =
  { location : Location
  , route : Route
  , navigating : Bool
  , search : Colors.Search.Model.Model
  , randomColor : Colors.RandomColor.Model.Model
  }


initialModel : Model
initialModel =
  { location = newLocation
  , route = LoadingRoute
  , navigating = False
  , search = Colors.Search.Model.initialModel
  , randomColor = Colors.RandomColor.Model.initialModel
  }
