module Board (Model, Action(..), Context, init, update, view) where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

type alias Model = Bool

type Action = Enable | Disable

type alias Context = { buy: Signal.Address () }

init : Model
init = False

update : Action -> Model -> Model
update a m = case a of 
    Enable -> True
    Disable -> False

view : Context -> Model -> Html
view context m = div [style [("display", "flex"), ("flex-direction", "column"), ("justify-content", "center")]] 
                     [button [disabled (not m), onClick context.buy ()] [text "Buy clicker"]]