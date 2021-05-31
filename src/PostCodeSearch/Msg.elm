module PostCodeSearch.Msg exposing (Msg(..))

import Browser
import Url


type Msg
    = DoNothing
    | LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | UpdateCode String
    | SubmitCode String
