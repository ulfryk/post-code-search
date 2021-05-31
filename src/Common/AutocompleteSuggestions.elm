module Common.AutocompleteSuggestions exposing (..)

import Common.HtmlNone exposing (htmlNone)
import Html exposing (Html, button, li, text, ul)
import Html.Events exposing (onClick)
import List exposing (isEmpty, map)


autocompleteSuggestion : (String -> msg) -> String -> Html msg
autocompleteSuggestion action suggestion =
    li []
        [ button [ onClick (action suggestion) ]
            [ text suggestion
            ]
        ]


autocompleteList : Maybe (List String) -> (String -> msg) -> Html msg
autocompleteList autocomplete action =
    case autocomplete of
        Just suggestions ->
            if isEmpty suggestions then
                ul [] [ li [] [ text "Nothing found." ] ]

            else
                ul [] (map (autocompleteSuggestion action) suggestions)

        Nothing ->
            htmlNone
