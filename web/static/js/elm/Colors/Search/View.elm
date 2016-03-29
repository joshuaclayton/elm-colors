module Colors.Search.View (view) where

import Html exposing (..)
import Html.Attributes exposing (type', href, value, pattern, placeholder, class)
import Html.Events exposing (onClick, on, targetValue)
import String exposing (trim)
import Regex exposing (regex, replace, HowMany(..))
import Colors.Util.CustomEvent exposing (onSubmit)
import Colors.Search.Model exposing (Model)
import Colors.Search.Update exposing (Action, Action(..))
import Colors.Color.View
import TinyColor


view : Signal.Address Action -> Model -> Html
view address model =
  section
    []
    [ colorSelectorForm address model ]


colorSelectorForm : Signal.Address Action -> Model -> Html
colorSelectorForm address model =
  form
    [ class "color-search", onSubmit address SubmitForm ]
    [ input
        [ type' "text"
        , placeholder "Hex code (e.g. FAA or FFAAAA)"
        , pattern hexCodeValidationRegex
        , on "input" targetValue (Signal.message address << setColorName)
        ]
        []
    , input [ type' "color", value <| selectedValue model, on "change" targetValue (Signal.message address << setColorName) ] []
    , input [ type' "submit", value "Show Color" ] []
    ]


selectedValue : Model -> String
selectedValue model =
  (Maybe.withDefault "" >> TinyColor.normalizeHexString) model.searchColor


setColorName : String -> Action
setColorName colorName =
  let
    stripHash =
      replace All (regex "#") (\_ -> "")
  in
    SetSearchColor <| (trim >> stripHash >> TinyColor.normalizeHex) colorName


hexCodeValidationRegex : String
hexCodeValidationRegex =
  "[0-9a-fA-F]{3}|[0-9a-fA-F]{6}"
