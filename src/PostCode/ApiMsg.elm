module PostCode.ApiMsg exposing (..)

import Http
import PostCode.DTO.PostCode exposing (PostCode)


type ApiMsg
    = Noop
    | GotCode (Result Http.Error (Maybe PostCode))
    | GotSuggestions (Result Http.Error (List String))
