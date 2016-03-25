module Colors.Home.View (view) where

import Html exposing (..)
import Html.Attributes exposing (type', href, value, pattern, placeholder, class)
import Html.Events exposing (onClick, on, targetValue)
import String exposing (trim)
import Regex exposing (regex, replace, HowMany(..))
import Colors.Util.CustomEvent exposing (onSubmit)
import Colors.Home.Model exposing (Model)
import Colors.Home.Update exposing (Action, Action(..))
import Colors.Color.View
import TinyColor


view : Signal.Address Action -> Model -> Html
view address model =
  section
    []
    [ colorSelectorForm address model
    , randomColors address model
    ]


randomColors : Signal.Address Action -> Model -> Html
randomColors address model =
  case model.randomColorSeed of
    Nothing ->
      div [] []

    Just seed ->
      let
        ( colors, seed' ) =
          TinyColor.randomList model.randomListSize seed
      in
        div
          []
          [ Colors.Color.View.renderColors "Random Colors" colors
          , button [ onClick address (SetColorSeed seed') ] [ text "Generate another batch" ]
          ]


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
