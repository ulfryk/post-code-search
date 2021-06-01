module PostCode.DTO.ErrorResponse exposing (..)

import Json.Decode as D exposing (Decoder)
import Json.Decode.Pipeline exposing (required)


type alias ErrorResponse =
    { status : Int
    , error : String
    }


errorResponseDecoder : Decoder ErrorResponse
errorResponseDecoder =
    D.succeed ErrorResponse
        |> required "status" D.int
        |> required "error" D.string
