module PostCodeSearch.CodeInputHtml exposing (..)

import Common.EventHandlers exposing (onKeyDown)
import Html exposing (Attribute, Html, input)
import Html.Attributes exposing (class, disabled, placeholder, type_, value)
import Html.Events exposing (keyCode, on, onInput)
import PostCodeSearch.Msg exposing (Msg(..))


submitOnEnter : String -> Int -> Msg
submitOnEnter postCode keyCode =
    case keyCode of
        13 ->
            SubmitCode postCode

        _ ->
            DoNothing


codeInput : Bool ->String -> Html Msg
codeInput loading code =
    input
        [ class "u-pull-right"
        , class "the-one-and-only-input"
        , type_ "text"
        , placeholder "POST CODE"
        , value code
        , onInput UpdateCode
        , disabled loading
        , onKeyDown <| submitOnEnter code
        ]
        []
