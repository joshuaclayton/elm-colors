module App (..) where

import StartApp
import Task
import Effects exposing (Effects, Never)
import Colors.App.Model exposing (..)
import Colors.App.Update exposing (..)
import Colors.App.View exposing (..)
import Colors.Router exposing (router)


inputs : List (Signal Action)
inputs =
  [ taggedRouterSignal ]


app =
  StartApp.start { init = init, view = view, update = update, inputs = inputs }


main =
  app.html


taggedRouterSignal : Signal Action
taggedRouterSignal =
  Signal.map ApplyRoute router.signal


port tasks : Signal (Task.Task Never ())
port tasks =
  app.tasks


port routeRunTask : Task.Task () ()
port routeRunTask =
  router.run
