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
      [ section [ class "hero" ] [ renderColor [] color ]
      , section [ class "no-hex" ] [ renderColorSpectrum <| TinyColor.rgbSpectrum color ]
      , section [ class "no-hex" ] [ renderColorSpectrum <| TinyColor.hsvSpectrum color ]
      , section [ class "no-hex" ] [ renderColorSection "Wheel" (TinyColor.wheel 15) ]
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


renderColorSpectrum : TinyColor.ColorSpectrum -> Html
renderColorSpectrum spectrum =
  let
    header' =
      case spectrum of
        RGBSpectrum _ ->
          h3 [] [ text "RGB Color Spectrum" ]

        HSVSpectrum _ ->
          h3 [] [ text "HSV Color Spectrum" ]

    header'' text' =
      h4 [] [ text text' ]

    colorRows =
      case spectrum of
        RGBSpectrum spectrum' ->
          [ colorRowWithHeader "R" spectrum' .reds
          , colorRowWithHeader "G" spectrum' .greens
          , colorRowWithHeader "B" spectrum' .blues
          , colorRowWithHeader "D" spectrum' .brightness
          ]

        HSVSpectrum spectrum' ->
          [ colorRowWithHeader "H" spectrum' .hues
          , colorRowWithHeader "S" spectrum' .saturations
          , colorRowWithHeader "V" spectrum' .brightness
          ]
  in
    section
      [ class "color-container" ]
      ([ header' ] ++ colorRows)


colorRowWithHeader : String -> { a | base : TinyColor } -> ({ a | base : TinyColor } -> List TinyColor) -> Html
colorRowWithHeader header spectrum fn =
  let
    colors =
      fn spectrum

    renderedColors =
      (List.map (renderColor [ spectrum.base ]) colors)
  in
    section
      [ class "color-row" ]
      [ h4 [] [ text header ]
      , section
          [ class "color-list-wrapper" ]
          [ section [ class "color-list" ] renderedColors ]
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
      , section [ class "color-list" ] <| List.map (renderColor []) colors
      ]


renderColor : List TinyColor -> TinyColor -> Html
renderColor activeColors color =
  let
    hex =
      color |> TinyColor.toHex

    isActive =
      List.any (TinyColor.equals color) activeColors
  in
    linkTo
      (colorPath hex)
      [ style [ ( "background", TinyColor.toHexString color ) ]
      , classList [ ( "active", isActive ), ( "color-swatch", True ), ( "light-color", TinyColor.isLightW3C color ) ]
      ]
      [ span [] [ text hex ] ]


toList : a -> List a
toList a =
  [ a ]
