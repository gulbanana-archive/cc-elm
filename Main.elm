import Html exposing (..)
import Time
import Window
import Model exposing (..)
import View exposing (..)
import Update exposing (..)


input : Signal Action
input = Signal.map Delta (Time.fps 60)


gameState : Signal State
gameState = Signal.foldp update initialModel input


main : Signal Html
main = Signal.map2 view Window.dimensions gameState
