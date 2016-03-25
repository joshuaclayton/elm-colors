module Colors.App.Model (..) where

import Effects exposing (Effects)
import Hop.Types exposing (Location, newLocation)
import Colors.Router exposing (Route, Route(..))
import Colors.Home.Model
import Colors.RandomColor.Model


type alias Model =
  { location : Location
  , route : Route
  , navigating : Bool
  , home : Colors.Home.Model.Model
  , randomColor : Colors.RandomColor.Model.Model
  }


initialModel : Model
initialModel =
  { location = newLocation
  , route = HomeRoute
  , navigating = False
  , home = Colors.Home.Model.initialModel
  , randomColor = Colors.RandomColor.Model.initialModel
  }
