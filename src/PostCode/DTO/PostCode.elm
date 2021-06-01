module PostCode.DTO.PostCode exposing (..)

import Json.Decode as D exposing (Decoder)
import Json.Decode.Pipeline exposing (optional, required)


type alias PostCode =
    { postcode : String
    , country : String
    , region : Maybe String
    }


postCodeDecoder : Decoder PostCode
postCodeDecoder =
    D.succeed PostCode
        |> required "postcode" D.string
        |> required "country" D.string
        |> optional "region" (D.map Just D.string) Nothing
