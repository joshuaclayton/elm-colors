module Colors.RandomColor.View (view) where

import Html exposing (..)
import Html.Events exposing (onClick)
import Colors.RandomColor.Model exposing (Model)
import Colors.RandomColor.Update exposing (Action, Action(..))
import Colors.Color.View
import TinyColor


view : Signal.Address Action -> Model -> Html
view address model =
  case model.seed of
    Nothing ->
      div [] []

    Just seed ->
      let
        ( colors, seed' ) =
          TinyColor.randomList model.listSize seed
      in
        div
          []
          [ Colors.Color.View.renderColors "Random Colors" colors
          , button [ onClick address (SetColorSeed seed') ] [ text "Generate another batch" ]
          ]
