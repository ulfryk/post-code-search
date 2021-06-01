module Common.ErrorInfoHtml exposing (..)

import Html exposing (Html, text)
import Http
import String exposing (fromInt)


errorInfo : Http.Error -> Html msg
errorInfo error =
    case error of
        Http.BadUrl string ->
            text ("Bad Url: " ++ string)

        Http.Timeout ->
            text "Timeout"

        Http.NetworkError ->
            text "Network Error"

        Http.BadStatus int ->
            text ("Bad Status:" ++ fromInt int)

        Http.BadBody string ->
            text ("Bad Body: " ++ string)
