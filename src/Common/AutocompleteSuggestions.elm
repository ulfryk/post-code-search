module Common.AutocompleteSuggestions exposing (..)

import Common.HtmlNone exposing (htmlNone)
import Html exposing (Html, button, li, text, ul)
import Html.Attributes exposing (class, disabled)
import Html.Events exposing (onClick)
import List exposing (isEmpty, map)


autocompleteSuggestion : (String -> msg) -> String -> Html msg
autocompleteSuggestion action suggestion =
    li [ class "autocomplete__suggestion" ]
        [ button [ onClick (action suggestion), class "autocomplete__choose-suggestion" ] [ text suggestion ]
        ]


loadingMsg : Bool -> Maybe (Html msg) -> Html msg
loadingMsg loading content =
    if loading then
        li [ class "autocomplete__suggestion", class "autocomplete__suggestion--info" ]
            [ button [ disabled True, class "autocomplete__choose-suggestion" ] [ text "Loading…" ]
            ]

    else
        li [ class "autocomplete__suggestion", class "autocomplete__suggestion--info" ]
            [ case content of
                Just c ->
                    button [ disabled True, class "autocomplete__choose-suggestion" ] [ c ]

                Nothing ->
                    htmlNone
            ]


autocompleteList : Bool -> Maybe (List String) -> (String -> msg) -> Html msg
autocompleteList loading autocomplete action =
    case autocomplete of
        Just suggestions ->
            if isEmpty suggestions then
                ul [ class "autocomplete", class "autocomplete--empty" ]
                    [ loadingMsg loading << Just <| text "Nothing found." ]

            else
                ul [ class "autocomplete" ]
                    ([ loadingMsg loading Nothing ]
                        ++ map (autocompleteSuggestion action) suggestions
                    )

        Nothing ->
            htmlNone
