module PostCode.DTO.ValidResponse exposing (..)

import Json.Decode as D exposing (Decoder)
import Json.Decode.Pipeline exposing (optional, required)


type alias ValidResponse t =
    { status : Int
    , result : t
    }


validResponseDecoder : Decoder t -> t -> Decoder (ValidResponse t)
validResponseDecoder decoder res =
    D.succeed ValidResponse
        |> required "status" D.int
        |> optional "result" decoder res


getValidResult : ValidResponse t -> t
getValidResult response =
    response.result
