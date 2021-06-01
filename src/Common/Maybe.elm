module Common.Maybe exposing (..)

import Maybe exposing (andThen)


mfilter : (t -> Bool) -> Maybe t -> Maybe t
mfilter f =
    andThen
        (\a ->
            if f a then
                Just a

            else
                Nothing
        )
