module View where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Model


view : (Int,Int) -> Model.State -> Html
view (w,h) gameState = 
    div [style [("font-family", "Courier New")]]
        [p [] [text "Clickers: ", text (toString gameState.clickers), text " (", text (toString gameState.clickers), text " click per second)"],
         p [] [text "Clicks: ", text (toString gameState.clicks)]]