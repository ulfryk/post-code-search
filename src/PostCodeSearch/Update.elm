module PostCodeSearch.Update exposing (..)

import Browser
import Browser.Navigation as Nav
import PostCodeSearch.Model exposing (Model)
import PostCodeSearch.Msg exposing (Msg(..))
import Url


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
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

        UpdateCode code ->
            ( { model | code = code }, Cmd.none )

        SubmitCode code ->
            ( model, Nav.pushUrl model.key ("/" ++ code) )
