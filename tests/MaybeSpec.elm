module MaybeSpec exposing (..)

import Common.Maybe exposing (mfilter)
import Expect exposing (Expectation)
import Test exposing (..)


constFalse : t -> Bool
constFalse _ =
    False


constTrue : t -> Bool
constTrue _ =
    True

greaterThanFive : Int -> Bool
greaterThanFive n = n > 5



suite : Test
suite =
    describe "Common.Maybe module"
        [ describe "Common.Maybe.mfilter"
            [ test "does not affect Nothing (on failed predicate)" <|
                \_ ->
                    Expect.equal Nothing (mfilter constFalse Nothing)
            , test "does not affect Nothing (on always successful predicate)" <|
                \_ ->
                    Expect.equal Nothing (mfilter constTrue Nothing)
            , test "does not affect Just anything on always successful predicate" <|
                \_ ->
                    Expect.equal (Just 5) (mfilter constTrue <| Just 5)
            , test "swaps to Nothing on always failing predicate" <|
                \_ ->
                    Expect.equal Nothing (mfilter constFalse <| Just 5)
            , test "swaps to Nothing on failing predicate" <|
                \_ ->
                    Expect.equal Nothing (mfilter greaterThanFive <| Just 5)
            , test "keeps original value on successful predicate" <|
                \_ ->
                    Expect.equal (Just 6) (mfilter greaterThanFive <| Just 6)
            ]
        ]
