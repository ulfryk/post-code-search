module PostCodeSearch.View exposing (..)

import Common.AutocompleteSuggestions exposing (autocompleteList)
import Common.ErrorInfoHtml exposing (errorInfo)
import Common.HtmlNone exposing (htmlNone)
import Html exposing (Html, br, main_, strong, text)
import Html.Attributes exposing (class, style)
import Maybe
import PostCode.DTO.PostCode exposing (PostCode)
import PostCodeSearch.CodeInputHtml exposing (codeInput)
import PostCodeSearch.Model exposing (Model)
import PostCodeSearch.Msg exposing (Msg(..))


postCodeSearchView : Model -> Html Msg
postCodeSearchView { code, error, found, loading, autocomplete, autocompleteLoading } =
    main_
        [ if loading then
            class "postcode-search-form__loading"

          else
            class ""
        , class "postcode-search-form"
        ]
        [ codeInput loading code
        , case found of
            Just data ->
                strong [ style "margin-left" "10px" ] [ text (data.region ++ ", " ++ data.country) ]

            Nothing ->
                if loading then
                    text "loading…"

                else
                    htmlNone
        , br [] []
        , case error of
            Just err ->
                errorInfo err

            Nothing ->
                autocompleteList autocompleteLoading autocomplete SubmitCode
        ]
