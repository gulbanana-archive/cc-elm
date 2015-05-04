module View where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import Model
import StatusBar


view : (Int,Int) -> Model.State -> Html
view (w,h) gameState = StatusBar.view (StatusBar.update [gameState.clickers, gameState.clicks] (StatusBar.init ["Clickers", "Clicks"]))