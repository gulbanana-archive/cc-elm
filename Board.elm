module Board (Model, Action, init, update, view) where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

type alias Model = Bool

type Action = Enable | Disable

init : Model
init = False

update : Action -> Model -> Model
update a m = case a of 
    Enable -> True
    Disable -> False

view : Model -> Html
view m = div [style [("display", "flex"), ("flex-direction", "column"), ("justify-content", "center")]] 
             [button [disabled (not m)] [text "Buy clicker"]]