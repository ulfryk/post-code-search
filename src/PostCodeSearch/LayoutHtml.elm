module PostCodeSearch.LayoutHtml exposing (..)

import Html exposing (Html, div, footer, h1, header, text)
import Html.Attributes exposing (class)
import PostCodeSearch.Msg exposing (Msg)


layoutHtml : Html Msg -> Html Msg
layoutHtml content =
    div [ class "container"]
        [ header [ class "header" ] [ h1 [ class "header__title"] [ text "Post Code Search" ] ]
        , content
        , footer [ class "footer"] [ text "© Ulfryk 2021" ]
        ]
