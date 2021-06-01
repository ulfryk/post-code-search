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
        , expect = Http.expectJson (GotCode << map getValidResult) <| validResponseDecoder (D.map Just postCodeDecoder) Nothing
        }


getAutocomplete : String -> Cmd ApiMsg
getAutocomplete part =
    Http.get
        { url = apiUrlBase ++ part ++ "/autocomplete"
        , expect = Http.expectJson (GotSuggestions << map getValidResult) <| validResponseDecoder (D.list D.string) []
        }


getNearest : String -> Cmd ApiMsg
getNearest part =
    Http.get
        { url = apiUrlBase ++ part ++ "/nearest"
        , expect = Http.expectJson (GotNearest << map getValidResult) <| validResponseDecoder (D.list postCodeDecoder) []
        }
