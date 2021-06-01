module PostCodeSearch.Msg exposing (Msg(..))

import Browser
import PostCode.ApiMsg exposing (ApiMsg)
import Url


type Msg
    = DoNothing
    | UrlChangeRequested Browser.UrlRequest
    | UrlChanged Url.Url
    | UpdateCode String
    | SubmitCode String
    | Api ApiMsg
