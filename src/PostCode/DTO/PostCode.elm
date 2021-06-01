module PostCode.DTO.PostCode exposing (..)

import Json.Decode as D exposing (Decoder)
import Json.Decode.Pipeline exposing (required)


type alias PostCode =
    { postcode : String
    , country : String
    , region : String
    }


postCodeDecoder : Decoder PostCode
postCodeDecoder =
    D.succeed PostCode
        |> required "postcode" D.string
        |> required "country" D.string
        |> required "region" D.string
