module Colors.RandomColor.Model (..) where

import Random exposing (Seed)


type alias Model =
  { seed : Maybe Seed
  , listSize : Int
  }


initialModel : Model
initialModel =
  { seed = Nothing, listSize = 5 }
