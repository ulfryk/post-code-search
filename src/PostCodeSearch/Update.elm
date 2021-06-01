module PostCodeSearch.Update exposing (..)

import Browser
import Browser.Navigation as Nav
import PostCode.ApiMsg exposing (ApiMsg(..))
import PostCode.Client exposing (getAutocomplete, getPostCode)
import PostCodeSearch.Model exposing (Model)
import PostCodeSearch.Msg exposing (Msg(..))
import String exposing (isEmpty)
import Url


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        DoNothing ->
            ( model, Cmd.none )

        UrlChanged { path } ->
            ( model, Cmd.none )

        UrlChangeRequested urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( model, Nav.load href )

        UpdateCode code ->
            ( { model | code = code, error = Nothing, autocompleteLoading = not <| isEmpty code }
            , if isEmpty code then
                Cmd.none

              else
                Cmd.map Api <| getAutocomplete code
            )

        SubmitCode code ->
            ( { model | error = Nothing, code = code, loading = True }
            , Cmd.batch
                [ Nav.pushUrl model.key ("/post-code-search/" ++ code)
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
                            ( { model
                                | found = Just value
                                , error = Nothing
                                , autocomplete = Nothing
                                , loading = False
                              }
                            , Cmd.none
                            )

                        Err error ->
                            ( { model
                                | error = Just error
                                , found = Nothing
                                , autocomplete = Nothing
                                , loading = False
                              }
                            , Cmd.none
                            )

                GotSuggestions result ->
                    case result of
                        Ok value ->
                            ( { model
                                | autocomplete = Just value
                                , error = Nothing
                                , autocompleteLoading = False
                              }
                            , Cmd.none
                            )

                        Err error ->
                            ( { model
                                | autocomplete = Nothing
                                , error = Nothing
                                , autocompleteLoading = False
                              }
                            , Cmd.none
                            )
