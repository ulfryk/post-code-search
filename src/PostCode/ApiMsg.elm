module PostCode.ApiMsg exposing (..)

import Http
import PostCode.DTO.PostCode exposing (PostCode)


type ApiMsg
    = Noop
    | GotCode (Result Http.Error PostCode)
    | GotSuggestions (Result Http.Error (List PostCode))
