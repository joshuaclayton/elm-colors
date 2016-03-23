module Colors.Util.CustomEvent (onSubmit) where

import Html exposing (..)
import Html.Events exposing (onWithOptions, defaultOptions)
import Json.Decode exposing (value)


onSubmit : Signal.Address a -> a -> Attribute
onSubmit addr msg =
  onWithOptions
    "submit"
    { defaultOptions | preventDefault = True }
    value
    (\_ -> Signal.message addr msg)
