module Colors.Home.View (view) where

import Html exposing (..)
import Html.Attributes exposing (type', value, pattern, placeholder)
import Html.Events exposing (on, targetValue)
import String exposing (trim)
import Colors.Util.CustomEvent exposing (onSubmit)
import Colors.Home.Model exposing (Model)
import Colors.Home.Update exposing (Action, Action(..))
import Regex exposing (regex, replace, HowMany(..))


view : Signal.Address Action -> Model -> Html
view address model =
  form
    [ onSubmit address SubmitForm ]
    [ input
        [ type' "text"
        , placeholder "Hex code (e.g. FAA or FFAAAA)"
        , pattern hexCodeValidationRegex
        , on "input" targetValue (Signal.message address << setColorName)
        ]
        []
    , em [] [ text " or " ]
    , input [ type' "color", on "change" targetValue (Signal.message address << setColorName) ] []
    , input [ type' "submit", value "Show Color" ] []
    ]


setColorName : String -> Action
setColorName value =
  let
    stripHash =
      replace All (regex "#") (\_ -> "")
  in
    SetSearchColor <| (trim >> stripHash) value


hexCodeValidationRegex : String
hexCodeValidationRegex =
  "[0-9a-fA-F]{3}|[0-9a-fA-F]{6}"
