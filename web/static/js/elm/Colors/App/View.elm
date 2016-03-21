module Colors.App.View (view) where

import Html exposing (..)
import Colors.App.Model exposing (Model)
import Colors.App.Update exposing (Action)
import App.HomepageView exposing (homepage)


view : Signal.Address Action -> Model -> Html
view address model =
  homepage address model
