module Colors.App.View (view) where

import Html exposing (..)
import Html.Attributes exposing (class, href)
import Colors.App.Model exposing (Model)
import Colors.App.Update exposing (Action, Action(..))
import Colors.Router exposing (Route(..), linkTo, rootPath)
import Colors.Search.View
import Colors.Color.View
import Colors.RandomColor.View
import Colors.Error.View
import TinyColor


view : Signal.Address Action -> Model -> Html
view address model =
  main'
    [ class "container" ]
    [ siteHeader address model
    , content address model
    , siteFooter
    ]


content : Signal.Address Action -> Model -> Html
content address model =
  case model.route of
    HomeRoute ->
      section
        [ class "homepage-hero" ]
        [ Colors.Search.View.view (Signal.forwardTo address UpdateSearch) model.search
        , Colors.RandomColor.View.view (Signal.forwardTo address UpdateRandomColor) model.randomColor
        ]

    ViewColorRoute color ->
      Colors.Color.View.view address <| TinyColor.fromString color

    NotFoundRoute ->
      Colors.Error.View.view "Looks like you're lost" "Everything will be okay."

    LoadingRoute ->
      div [] []


siteHeader : Signal.Address Action -> Model -> Html
siteHeader address model =
  let
    additionalHeaderContent =
      case model.route of
        HomeRoute ->
          []

        _ ->
          [ Colors.Search.View.view (Signal.forwardTo address UpdateSearch) model.search ]
  in
    header
      [ class "page-header" ]
      ([ h1 [] [ linkTo rootPath [] [ text "Colors" ] ] ] ++ additionalHeaderContent)


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
