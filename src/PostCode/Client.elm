module PostCode.Client exposing (..)

import Http
import Json.Decode as D
import PostCode.ApiMsg exposing (ApiMsg(..))
import PostCode.DTO.PostCode exposing (postCodeDecoder)
import PostCode.DTO.ValidResponse exposing (getValidResult, validResponseDecoder)
import Result exposing (map)


apiUrlBase : String
apiUrlBase =
    "https://postcodes.io/postcodes/"


getPostCode : String -> Cmd ApiMsg
getPostCode code =
    Http.get
        { url = apiUrlBase ++ code
        , expect = Http.expectJson (GotCode << map getValidResult) <| validResponseDecoder postCodeDecoder
        }


getAutocomplete : String -> Cmd ApiMsg
getAutocomplete part =
    Http.get
        { url = apiUrlBase ++ part ++ "/autocomplete"
        , expect = Http.expectJson (GotSuggestions << map getValidResult) <| validResponseDecoder (D.list D.string)
        }
