module Colors.App.Update (Action, Action(ApplyRoute, NavigateTo, UpdateHome, UpdateRandomColor), update, init) where

import Effects exposing (Effects)
import Task
import Hop
import Hop.Types exposing (Location)
import Hop.Navigate exposing (navigateTo)
import Colors.Router exposing (Route)
import Colors.App.Model exposing (Model, initialModel)
import Colors.Home.Update
import Colors.RandomColor.Update


type Action
  = NoOp ()
  | StopNavigating
  | ApplyRoute ( Route, Location )
  | NavigateTo String
  | UpdateHome Colors.Home.Update.Action
  | UpdateRandomColor Colors.RandomColor.Update.Action


update : Action -> Model -> ( Model, Effects Action )
update action model =
  case action of
    ApplyRoute ( route, location ) ->
      let
        doneNavigating =
          Task.succeed StopNavigating |> Effects.task
      in
        ( { model | route = route, location = location, navigating = True }, doneNavigating )

    NavigateTo path ->
      ( model, Effects.map NoOp (navigateTo path) )

    UpdateHome action' ->
      let
        ( model', effects ) =
          Colors.Home.Update.update action' model.home
      in
        ( { model | home = model' }
        , Effects.map UpdateHome effects
        )

    UpdateRandomColor action' ->
      let
        ( model', effects ) =
          Colors.RandomColor.Update.update action' model.randomColor
      in
        ( { model | randomColor = model' }
        , Effects.map UpdateRandomColor effects
        )

    NoOp () ->
      ( model, Effects.none )

    StopNavigating ->
      ( { model | navigating = False }, Effects.none )


init : ( Model, Effects Action )
init =
  ( initialModel, Effects.none )
