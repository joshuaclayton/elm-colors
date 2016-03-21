module App.HomepageView (homepage) where

import Html exposing (..)
import Html.Attributes exposing (..)
import TinyColor
import Colors.App.Model exposing (Model)
import Colors.App.Update exposing (Action)


homepage : Signal.Address Action -> Model -> Html
homepage address model =
  let
    base =
      TinyColor.fromString "4D69A6"
  in
    div
      [ class "container" ]
      [ section
          [ class "welcome" ]
          [ h1 [] [ text "Colors" ]
          , p [] [ renderColor base ]
          , p [] [ text "complement ", renderColor <| TinyColor.complement base ]
          , p [] [ text "spin ", renderColor <| TinyColor.spin 240 base ]
          , p [] [ text "greyscale ", renderColor <| TinyColor.greyscale base ]
          , p [] [ text "desaturate ", renderColor <| TinyColor.desaturate 10 base ]
          , p [] ((text "triad ") :: (List.map renderColor (base |> TinyColor.triad)))
          , p [] ((text "tetrad ") :: (List.map renderColor (base |> TinyColor.tetrad)))
          , p [] ((text "analogous ") :: (List.map renderColor (base |> TinyColor.analogous)))
          , p [] ((text "split complement ") :: (List.map renderColor (base |> TinyColor.splitComplement)))
          ]
      ]


renderColor : TinyColor.TinyColor -> Html
renderColor color =
  let
    hex =
      color |> TinyColor.toHexString
  in
    span [ style [ ( "background", hex ), ( "color", "#fff" ), ( "padding", "1em" ), ( "line-height", "2.5em" ) ] ] [ text hex ]
