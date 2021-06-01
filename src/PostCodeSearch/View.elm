module PostCodeSearch.View exposing (..)

import Common.AutocompleteSuggestions exposing (autocompleteList)
import Html exposing (Html, main_)
import List as List
import Maybe as Maybe
import PostCode.DTO.PostCode exposing (PostCode)
import PostCodeSearch.CodeInputHtml exposing (codeInput)
import PostCodeSearch.Model exposing (Model)
import PostCodeSearch.Msg exposing (Msg(..))


extract : Maybe (List PostCode) -> Maybe (List String)
extract autocomplete =
    Maybe.map (
      \l -> List.map (\pc -> pc.postCode ) l
    ) autocomplete


postCodeSearchView : Model -> Html Msg
postCodeSearchView ({ code } as model) =
    main_ []
        [ codeInput code
        , autocompleteList (extract model.autocomplete) SubmitCode
        ]
