module Common.EventHandlers exposing (..)

import Html exposing (Attribute, Html, input)
import Html.Events exposing (keyCode, on, onInput)
import Json.Decode as Json


onKeyDown : (Int -> msg) -> Attribute msg
onKeyDown tagger =
    on "keydown" (Json.map tagger keyCode)
