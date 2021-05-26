module PostCodeSearch.Model exposing (..)

import Browser.Navigation as Nav
import Url


type alias Model =
    { version : Int
    , key : Nav.Key
    , url : Url.Url
    }


initialState : Url.Url -> Nav.Key -> Model
initialState url key =
    { version = 1, key = key, url = url }
