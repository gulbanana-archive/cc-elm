module StatusBar (Model, Action, init, update, view) where

import List exposing (map, map2)
import Html exposing (..)
import Html.Attributes exposing (..)

type alias StatusElement = { name: String, tooltip: String, count: Int }
type alias Model = List StatusElement

type alias Action = List Int

init : List (String, String) -> Model
init texts = map (\(n, t) -> { name = n, tooltip = t, count = 0 }) texts 

update : Action -> Model -> Model
update ns es = map (\(r, n) -> {r | count <- n}) (map2 (,) es ns)

view : Model -> Html
view pairs = div [style [("font-family", "Courier New"), ("display", "flex")]]
                 (map viewElem pairs)

viewElem : StatusElement -> Html
viewElem r = div [style [("margin-right", "100px")]] 
                 [p [style [("font-size", "18pt")]] [text r.name, text ": ", text (toString r.count)], 
                  p [] [text r.tooltip]]
