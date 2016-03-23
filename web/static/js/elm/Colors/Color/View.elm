module Colors.Color.View (view) where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import TinyColor exposing (..)
import Colors.App.Update exposing (Action, Action(NavigateTo))
import Colors.Router exposing (colorPath)


view : Signal.Address Action -> String -> Html
view address color =
  let
    base =
      TinyColor.fromString color

    renderColorSection =
      renderColorSectionList address base
  in
    section
      [ class "welcome" ]
      [ section [ class "hero" ] [ renderColor address base ]
      , renderColorSection "Triad" TinyColor.triad
      , renderColorSection "Tetrad" TinyColor.tetrad
      , renderColorSection "Analogous" TinyColor.analogous
      , renderColorSection "Split Complement" TinyColor.splitComplement
      , renderColorSection "Complement" (TinyColor.complement >> toList)
      , renderColorSection "Spin" (TinyColor.spin 240 >> toList)
      , renderColorSection "Greyscale" (TinyColor.greyscale >> toList)
      , renderColorSection "Desaturate" (TinyColor.desaturate 10 >> toList)
      , renderColorSection "Saturate" (TinyColor.saturate 10 >> toList)
      , renderColorSection "Darken" (TinyColor.darken 10 >> toList)
      , renderColorSection "Lighten" (TinyColor.lighten 10 >> toList)
      , renderColorSection "Brighten" (TinyColor.brighten 10 >> toList)
      ]


renderColorSectionList : Signal.Address Action -> TinyColor -> String -> (TinyColor -> List TinyColor) -> Html
renderColorSectionList address color header fn =
  let
    header' =
      h3 [] [ text header ]

    colors =
      List.map (renderColor address) (fn color)
  in
    section
      [ class "color-container" ]
      [ header'
      , section [ class "color-list" ] colors
      ]


renderColor : Signal.Address Action -> TinyColor -> Html
renderColor address color =
  let
    hex =
      color |> TinyColor.toHex
  in
    a
      [ style [ ( "background", TinyColor.toHexString color ), ( "color", "#fff" ) ]
      , href <| "#" ++ colorPath hex
      , class "color-swatch"
      ]
      [ span [] [ text hex ] ]


toList : a -> List a
toList a =
  [ a ]
