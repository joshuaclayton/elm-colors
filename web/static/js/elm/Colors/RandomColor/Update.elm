module Colors.RandomColor.Update (Action, Action(..), update) where

import Effects exposing (..)
import Random exposing (Seed)
import Colors.RandomColor.Model exposing (..)


type Action
  = NoOp ()
  | SetColorSeed Seed


update : Action -> Model -> ( Model, Effects Action )
update action model =
  case action of
    NoOp () ->
      ( model, Effects.none )

    SetColorSeed seed ->
      ( { model | seed = Just seed }
      , Effects.none
      )
