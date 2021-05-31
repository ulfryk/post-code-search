module PostCodeSearch.CodeInputHtml exposing (..)

import Common.EventHandlers exposing (onKeyDown)
import Html exposing (Attribute, Html, input)
import Html.Attributes exposing (placeholder, type_, value)
import Html.Events exposing (keyCode, on, onInput)
import PostCodeSearch.Msg exposing (Msg(..))


submitOnEnter : String -> Int -> Msg
submitOnEnter postCode keyCode =
    case keyCode of
        13 ->
            SubmitCode postCode

        _ ->
            DoNothing


codeInput : String -> Html Msg
codeInput code =
    input
        [ type_ "text"
        , placeholder "POST CODE"
        , value code
        , onInput UpdateCode
        , onKeyDown <| submitOnEnter code
        ]
        []
