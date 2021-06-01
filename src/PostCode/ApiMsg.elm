module PostCode.ApiMsg exposing (..)

import Http
import PostCode.DTO.PostCode exposing (PostCode)


type ApiMsg
    = GotCode (Result Http.Error (Maybe PostCode))
    | GotSuggestions (Result Http.Error (List String))
    | GotNearest (Result Http.Error (List PostCode))
