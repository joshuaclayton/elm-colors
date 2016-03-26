module App (..) where

import StartApp
import Task
import Effects exposing (Effects, Never)
import Random
import Colors.App.Model exposing (..)
import Colors.App.Update as App exposing (..)
import Colors.RandomColor.Update exposing (Action(SetColorSeed))
import Colors.App.View exposing (..)
import Colors.Router exposing (Route(..), router)
import TinyColor


inputs : List (Signal App.Action)
inputs =
  [ taggedRouterSignal, setRandomColorSignal ]


app =
  StartApp.start { init = init, view = view, update = update, inputs = inputs }


main =
  app.html


taggedRouterSignal : Signal App.Action
taggedRouterSignal =
  Signal.map ApplyRoute router.signal


setRandomColorSignal : Signal App.Action
setRandomColorSignal =
  Signal.map (UpdateRandomColor << SetColorSeed << Random.initialSeed) setRandomColorSeed


port setRandomColorSeed : Signal Int
port tasks : Signal (Task.Task Never ())
port tasks =
  app.tasks


port routeRunTask : Task.Task () ()
port routeRunTask =
  router.run


port broadcastRouteChange : Signal Bool
port broadcastRouteChange =
  (Signal.map .navigating app.model) |> Signal.dropRepeats


port title : Signal String
port title =
  let
    titleForModel model =
      case model.route of
        HomeRoute ->
          "Colors"

        ViewColorRoute color ->
          "Colors - " ++ ((TinyColor.fromString >> TinyColor.toHexString) color)

        NotFoundRoute ->
          "Colors - Page Not Found"

        LoadingRoute ->
          "Colors - Loading..."
  in
    Signal.map titleForModel app.model
