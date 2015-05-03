module View where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Model


view : (Int,Int) -> Model.GameState -> Html
view (w,h) gameState = p [style [("font-family", "Courier New")]] [text gameState.text]