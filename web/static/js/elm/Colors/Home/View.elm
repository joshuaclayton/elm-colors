module Colors.Home.View (view) where

import Html exposing (..)
import Html.Attributes exposing (type', value)
import Html.Events exposing (on, targetValue)
import String exposing (trim)
import Colors.Util.CustomEvent exposing (onSubmit)
import Colors.Home.Model exposing (Model)
import Colors.Home.Update exposing (Action, Action(..))


view : Signal.Address Action -> Model -> Html
view address model =
  form
    [ onSubmit address SubmitForm ]
    [ input [ type' "text", on "input" targetValue (Signal.message address << setColorName) ] []
    , input [ type' "submit", value "Show Color" ] []
    ]


setColorName : String -> Action
setColorName value =
  SetSearchColor (trim value)
