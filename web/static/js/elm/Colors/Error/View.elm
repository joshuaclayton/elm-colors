module Colors.Error.View (view) where

import Html exposing (..)
import Html.Attributes exposing (class)


view : String -> String -> Html
view header message =
  div
    [ class "error" ]
    [ h2 [] [ text header ]
    , p [] [ text message ]
    ]
