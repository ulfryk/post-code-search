module PostCodeSearch.View exposing (..)

import Common.AutocompleteSuggestions exposing (autocompleteList)
import Html exposing (Html, main_)
import PostCodeSearch.CodeInputHtml exposing (codeInput)
import PostCodeSearch.Model exposing (Model)
import PostCodeSearch.Msg exposing (Msg(..))


postCodeSearchView : Model -> Html Msg
postCodeSearchView ({ code } as model) =
    main_ []
        [ codeInput code
        , autocompleteList model.autocomplete SubmitCode
        ]
