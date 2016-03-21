module App (..) where

import StartApp
import Task
import Effects exposing (Effects, Never)
import Colors.App.Model exposing (..)
import Colors.App.Update exposing (..)
import Colors.App.View exposing (..)


inputs : List (Signal Action)
inputs =
  []


app =
  StartApp.start { init = init, view = view, update = update, inputs = inputs }


main =
  app.html


port tasks : Signal (Task.Task Never ())
port tasks =
  app.tasks
