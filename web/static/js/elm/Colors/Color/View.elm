module Colors.Color.View (view, renderColors) where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import TinyColor exposing (..)
import Colors.App.Update exposing (Action, Action(NavigateTo))
import Colors.Router exposing (linkTo, colorPath)


view : Signal.Address Action -> TinyColor.TinyColor -> Html
view address color =
  let
    renderColorSection =
      renderColorSectionList color
  in
    section
      [ class "welcome" ]
      [ section [ class "hero" ] [ renderColor color ]
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


renderColorSectionList : TinyColor -> String -> (TinyColor -> List TinyColor) -> Html
renderColorSectionList color header fn =
  renderColors header <| fn color


renderColors : String -> List TinyColor -> Html
renderColors header colors =
  let
    header' =
      h3 [] [ text header ]
  in
    section
      [ class "color-container" ]
      [ header'
      , section [ class "color-list" ] <| List.map renderColor colors
      ]


renderColor : TinyColor -> Html
renderColor color =
  let
    hex =
      color |> TinyColor.toHex
  in
    linkTo
      (colorPath hex)
      [ style [ ( "background", TinyColor.toHexString color ) ]
      , classList [ ( "color-swatch", True ), ( "light-color", TinyColor.isLightW3C color ) ]
      ]
      [ span [] [ text hex ] ]


toList : a -> List a
toList a =
  [ a ]
