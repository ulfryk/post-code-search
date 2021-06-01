module Main exposing (..)

import Browser
import Browser.Navigation as Nav
import PostCode.Client exposing (getNearest, getPostCode)
import PostCodeSearch.LayoutHtml exposing (layoutHtml)
import PostCodeSearch.Model exposing (Model, initialState, pathToCode)
import PostCodeSearch.Msg exposing (Msg(..))
import PostCodeSearch.Update exposing (update)
import PostCodeSearch.View exposing (postCodeSearchView)
import Url


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlChange = UrlChanged
        , onUrlRequest = UrlChangeRequested
        }


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
    ( initialState url key
    , case pathToCode url.path of
        Just code ->
            Cmd.batch
                [ Cmd.map Api <| getPostCode code
                , Cmd.map Api <| getNearest code
                ]

        Nothing ->
            Cmd.none
    )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


theTitle : Model -> String
theTitle { found } =
    case found of
        Just { postcode } ->
            "Post Code Search - " ++ postcode

        Nothing ->
            "Post Code Search"


view : Model -> Browser.Document Msg
view ({ url, key, code } as model) =
    { title = theTitle model
    , body = [ layoutHtml << postCodeSearchView <| model ]
    }
