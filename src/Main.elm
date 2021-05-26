module Main exposing (..)

import Browser
import Html exposing (Html, p, text)
import PostCodeSearch.Model exposing (Model, initialState)
import String exposing (fromInt)


type Msg
    = Bump
    | DoNothing


main =
    Browser.element { init = init, update = update, view = view, subscriptions = subscriptions }


init : () -> ( Model, Cmd Msg )
init _ =
    ( initialState, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Bump ->
            ( { model | version = model.version + 1 }, Cmd.none )

        DoNothing ->
            ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


view : Model -> Html Msg
view { version } =
    p [] [ text ("App version: " ++ fromInt version) ]
