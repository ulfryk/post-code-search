module PostCodeSearch.Model exposing (..)

import Browser.Navigation as Nav
import Http
import Maybe exposing (andThen, withDefault)
import PostCode.DTO.PostCode exposing (PostCode)
import Url exposing (percentDecode)
import Url.Parser exposing (Parser, parse, string)


type alias Model =
    { key : Nav.Key
    , url : Url.Url
    , code : String
    , autocomplete : Maybe (List String)
    , autocompleteLoading : Bool
    , found : Maybe PostCode
    , nearest : Maybe (List PostCode)
    , loading : Bool
    , error : Maybe Http.Error
    }



--pathToCode : String -> Maybe String
--pathToCode =
--    head << withDefault [] << tail << split "/"


initialCode : Url.Url -> Maybe String
initialCode =
    andThen percentDecode << parse string


initialState : Url.Url -> Nav.Key -> Model
initialState url key =
    { key = key
    , url = url
    , code = withDefault "" <| initialCode url
    , autocomplete = Nothing
    , autocompleteLoading = False
    , found = Nothing
    , nearest = Nothing
    , loading = False
    , error = Nothing
    }
