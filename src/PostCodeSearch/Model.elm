module PostCodeSearch.Model exposing (..)

import Browser.Navigation as Nav
import Http
import List exposing (filter, head, tail)
import Maybe exposing (andThen, withDefault)
import PostCode.DTO.PostCode exposing (PostCode)
import String exposing (split)
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


dropPathBase : Maybe (List String) -> Maybe (List String)
dropPathBase =
    Maybe.map <| filter (\part -> part /= "post-code-search")


pathToCode : String -> Maybe String
pathToCode =
    andThen percentDecode << head << withDefault [] << dropPathBase << tail << split "/"


--initialCode : Url.Url -> Maybe String
--initialCode =
--    andThen percentDecode << parse string


initialState : Url.Url -> Nav.Key -> Model
initialState url key =
    { key = key
    , url = url
    , code = withDefault "" <| pathToCode url.path
    , autocomplete = Nothing
    , autocompleteLoading = False
    , found = Nothing
    , nearest = Nothing
    , loading = False
    , error = Nothing
    }
