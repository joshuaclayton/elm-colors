module Colors.Search.Update (Action, Action(..), update) where

import Effects exposing (..)
import Hop.Navigate exposing (navigateTo)
import Colors.Router exposing (colorPath)
import Colors.Search.Model exposing (..)


type Action
  = NoOp ()
  | SetSearchColor String
  | SubmitForm


update : Action -> Model -> ( Model, Effects Action )
update action model =
  case action of
    NoOp () ->
      ( model, Effects.none )

    SetSearchColor "" ->
      ( { model | searchColor = Nothing }
      , Effects.none
      )

    SetSearchColor color ->
      ( { model | searchColor = Just color }
      , Effects.none
      )

    SubmitForm ->
      let
        color =
          Maybe.withDefault "000000" model.searchColor
      in
        ( model, Effects.map NoOp <| navigateTo <| colorPath color )
