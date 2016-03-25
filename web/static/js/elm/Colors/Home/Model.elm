module Colors.Home.Model (..) where

import Random exposing (Seed)


type alias Model =
  { searchColor : Maybe String }


initialModel : Model
initialModel =
  { searchColor = Nothing }
