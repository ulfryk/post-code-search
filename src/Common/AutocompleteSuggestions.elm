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


loadingMsg : Bool -> Html msg
loadingMsg loading =
    if loading then
        li [] [ text "Loading…" ]

    else
        htmlNone


autocompleteList : Bool -> Maybe (List String) -> (String -> msg) -> Html msg
autocompleteList loading autocomplete action =
    case autocomplete of
        Just suggestions ->
            if isEmpty suggestions then
                ul [] [ li [] [ loadingMsg loading, text "Nothing found." ] ]

            else
                ul [] ([ loadingMsg loading ] ++ map (autocompleteSuggestion action) suggestions)

        Nothing ->
            htmlNone
