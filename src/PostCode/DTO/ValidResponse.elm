module PostCode.DTO.ValidResponse exposing (..)

import Json.Decode as D exposing (Decoder)
import Json.Decode.Pipeline exposing (required)


type alias ValidResponse t =
    { status : Int
    , result : t
    }


validResponseDecoder : Decoder t -> Decoder (ValidResponse t)
validResponseDecoder decoder =
    D.succeed ValidResponse
        |> required "status" D.int
        |> required "result" decoder


getValidResult : ValidResponse t -> t
getValidResult response =
    response.result
