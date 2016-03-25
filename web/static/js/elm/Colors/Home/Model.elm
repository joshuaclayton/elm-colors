module Colors.Home.Model (..) where

import Random exposing (Seed)


type alias Model =
  { searchColor : Maybe String
  , randomColorSeed : Maybe Seed
  , randomListSize : Int
  }


initialModel : Model
initialModel =
  { searchColor = Nothing, randomColorSeed = Nothing, randomListSize = 5 }
