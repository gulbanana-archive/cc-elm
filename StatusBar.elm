module StatusBar (Model, Action, init, update, view) where

import List exposing (map, map2)
import Html exposing (..)
import Html.Attributes exposing (..)

type alias Model = List ((String, String), Int)

type alias Action = List Int

init : List (String, String) -> Model
init texts = map (\t -> (t, 0)) texts 

update : Action -> Model -> Model
update ns es = map (\((t, oldN), newN) -> (t, newN)) (map2 (,) es ns)

view : Model -> Html
view pairs = div [style [("font-family", "Courier New"), ("display", "flex")]]
                 (map viewPair pairs)

viewPair : ((String, String), Int) -> Html
viewPair ((t, h), n) = div [style [("margin-right", "100px")]] [p [style [("font-size", "18pt")]] [text t, text ": ", text (toString n)], p [] [text h]]
