module PostCodeSearch.Model exposing (..)

import Browser.Navigation as Nav
import Maybe exposing (andThen, withDefault)
import PostCode.DTO.PostCode exposing (PostCode)
import Url exposing (percentDecode)
import Url.Parser exposing (Parser, parse, string)


type alias Model =
    { key : Nav.Key
    , url : Url.Url
    , code : String
    , autocomplete : Maybe (List PostCode)
    , found : Maybe PostCode
    , nearest : Maybe (List PostCode)
    , error : Maybe String
    }



--pathToCode : String -> Maybe String
--pathToCode =
--    head << withDefault [] << tail << split "/"


initialState : Url.Url -> Nav.Key -> Model
initialState url key =
    { key = key
    , url = url
    , code = withDefault "" <| andThen percentDecode <| parse string url
    , autocomplete = Nothing
    , found = Nothing
    , nearest = Nothing
    , error = Nothing
    }
