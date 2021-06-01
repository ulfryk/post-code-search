module PostCodeSearch.View exposing (..)

import Common.AutocompleteSuggestions exposing (autocompleteList)
import Common.ErrorInfoHtml exposing (errorInfo)
import Common.HtmlNone exposing (htmlNone)
import Html exposing (Html, div, main_, p, strong, text)
import Html.Attributes exposing (class, style)
import Maybe
import PostCode.DTO.PostCode exposing (PostCode)
import PostCodeSearch.CodeInputHtml exposing (codeInput)
import PostCodeSearch.Model exposing (Model)
import PostCodeSearch.Msg exposing (Msg(..))


postCodeInfo : PostCode -> String
postCodeInfo { region, country } =
    case region of
        Maybe.Just r ->
            r ++ ", " ++ country

        Maybe.Nothing ->
            country


postCodeInfoView : Maybe PostCode -> Bool -> Html msg
postCodeInfoView found loading =
    case found of
        Just data ->
            p
                [ class "postcode-search-form__found"
                , class "postcode-details"
                ]
                [ strong [] [ text <| postCodeInfo data ]
                ]

        Nothing ->
            if loading then
                text "loading…"

            else
                htmlNone


subInputView : Model -> Html Msg
subInputView { error, autocomplete, autocompleteLoading } =
    case error of
        Just err ->
            div [ class "sub-input-info__error" ] [ errorInfo err ]

        Nothing ->
            div [ class "sub-input-info__hints" ] [ autocompleteList autocompleteLoading autocomplete SubmitCode ]


postCodeSearchView : Model -> Html Msg
postCodeSearchView ({ code, error, found, loading, autocomplete, autocompleteLoading } as model) =
    main_
        [ if loading then
            class "postcode-search-form--loading"

          else
            class "postcode-search-form--loaded"
        , class "postcode-search-form"
        ]
        [ div [ class "row" ]
            [ div [ class "three columns" ] [ text " " ]
            , div [ class "five columns" ] [ codeInput loading code ]
            , div [ class "three columns" ] [ postCodeInfoView found loading ]
            , div [ class "one column" ] [ text " " ]
            ]
        , div [ class "row" ]
            [ div [ class "three columns" ] [ text " " ]
            , div [ class "five columns", class "postcode-search-form__sub-input", class "sub-input-info" ] [ subInputView model ]
            , div [ class "four columns" ] [ text " " ]
            ]
        ]
