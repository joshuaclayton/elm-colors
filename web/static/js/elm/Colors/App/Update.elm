module Colors.App.Update (Action, Action(ApplyRoute, NavigateTo, UpdateSearch, UpdateRandomColor), update, init) where

import Effects exposing (Effects)
import Task
import Hop.Types exposing (Location)
import Colors.Router exposing (Route, navigateTo)
import Colors.App.Model exposing (Model, initialModel)
import Colors.Search.Update
import Colors.RandomColor.Update


type Action
  = NoOp ()
  | StopNavigating
  | ApplyRoute ( Route, Location )
  | NavigateTo String
  | UpdateSearch Colors.Search.Update.Action
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

    UpdateSearch action' ->
      let
        ( model', effects ) =
          Colors.Search.Update.update action' model.search
      in
        ( { model | search = model' }
        , Effects.map UpdateSearch effects
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
