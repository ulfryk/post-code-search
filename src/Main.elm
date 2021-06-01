module Main exposing (..)

import Browser
import Browser.Navigation as Nav
import Html exposing (Html, footer, h1, header, text)
import PostCode.Client exposing (getPostCode)
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
            Cmd.map Api <| getPostCode code

        Nothing ->
            Cmd.none
    )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


view : Model -> Browser.Document Msg
view ({ url, key, code } as model) =
    { title = "URL Interceptor"
    , body =
        [ header [] [ h1 [] [ text "Post Code Search " ] ]
        , postCodeSearchView model
        , footer [] [ text "© Ulfryk 2021" ]
        ]
    }
