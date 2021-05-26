module Main exposing (..)

import Browser
import Browser.Navigation as Nav
import Html exposing (Html, p, text)
import Maybe exposing (withDefault)
import PostCodeSearch.Model exposing (Model, initialState)
import String exposing (fromInt)
import Url


type Msg
    = Bump
    | DoNothing
    | LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlChange = UrlChanged
        , onUrlRequest = LinkClicked
        }


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
    ( initialState url key, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Bump ->
            ( { model | version = model.version + 1 }, Cmd.none )

        DoNothing ->
            ( model, Cmd.none )

        UrlChanged { path } ->
            ( model, Cmd.none )

        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( model, Nav.load href )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


view : Model -> Browser.Document Msg
view { version, url } =
    { title = "URL Interceptor"
    , body =
        [ p []
            [ text
                ("App version: "
                    ++ fromInt version
                    ++ " url: "
                    ++ url.path
                    ++ " query: "
                    ++ withDefault "null" url.query
                    ++ " fragment: "
                    ++ withDefault "null" url.fragment
                )
            ]
        ]
    }
