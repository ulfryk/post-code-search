module PostCode.Client exposing (..)

import Http
import PostCode.ApiMsg exposing (ApiMsg(..))
import PostCode.DTO.PostCode exposing (postCodeDecoder)
import PostCode.DTO.ValidResponse exposing (getValidResult, validResponseDecoder)
import Result exposing (map)


getPostCode : String -> Cmd ApiMsg
getPostCode code =
    Http.get
        { url = "https://postcodes.io/postcodes/" ++ code
        , expect = Http.expectJson (GotCode << map getValidResult) <| validResponseDecoder postCodeDecoder
        }
