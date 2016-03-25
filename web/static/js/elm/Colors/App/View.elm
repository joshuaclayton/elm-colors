module Colors.App.View (view) where

import Html exposing (..)
import Html.Attributes exposing (class, href)
import Colors.App.Model exposing (Model)
import Colors.App.Update exposing (Action, Action(..))
import Colors.Router exposing (Route(..), linkTo, rootPath)
import Colors.Home.View
import Colors.Color.View
import Colors.RandomColor.View
import Colors.Error.View
import TinyColor


view : Signal.Address Action -> Model -> Html
view address model =
  main'
    [ class "container" ]
    [ siteHeader
    , content address model
    , siteFooter
    ]


content : Signal.Address Action -> Model -> Html
content address model =
  case model.route of
    HomeRoute ->
      section
        []
        [ Colors.Home.View.view (Signal.forwardTo address UpdateHome) model.home
        , Colors.RandomColor.View.view (Signal.forwardTo address UpdateRandomColor) model.randomColor
        ]

    ViewColorRoute color ->
      Colors.Color.View.view address <| TinyColor.fromString color

    NotFoundRoute ->
      Colors.Error.View.view "Looks like you're lost" "Everything will be okay."


siteHeader : Html
siteHeader =
  header
    [ class "page-header" ]
    [ h1 [] [ linkTo rootPath [] [ text "Colors" ] ] ]


siteFooter : Html
siteFooter =
  footer
    []
    [ p
        []
        [ text "Created by "
        , a [ href "http://joshuaclayton.me" ] [ text "Josh Clayton" ]
        , text ". "
        , text "View the source on "
        , a [ href "https://github.com/joshuaclayton/elm-colors" ] [ text "GitHub" ]
        , text "."
        ]
    ]
