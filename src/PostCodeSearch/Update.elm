module PostCodeSearch.Update exposing (..)

import Browser
import Browser.Navigation as Nav
import Debug exposing (toString)
import PostCode.ApiMsg exposing (ApiMsg(..))
import PostCode.Client exposing (getPostCode)
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
            ( model
            , Cmd.batch
                [ Nav.pushUrl model.key ("/" ++ code)
                , Cmd.map Api <| getPostCode code
                ]
            )

        Api apiMsg ->
            case apiMsg of
                Noop ->
                    ( model, Cmd.none )

                GotCode result ->
                    case result of
                        Ok value ->
                            ( { model | found = Just value }, Cmd.none )

                        Err error ->
                            ( { model | error = Just (toString error) }, Cmd.none )

                GotSuggestions result ->
                    case result of
                        Ok value ->
                            ( { model | autocomplete = Just value }, Cmd.none )

                        Err error ->
                            ( { model | error = Just (toString error) }, Cmd.none )
