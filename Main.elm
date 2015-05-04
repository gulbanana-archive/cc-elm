import Html exposing (..)
import Time
import Window
import Game


input : Signal Game.Action
input = Signal.map Game.Delta (Time.fps 60)


gameState : Signal Game.Model
gameState = Signal.foldp Game.update Game.init input


main : Signal Html
main = Signal.map2 Game.view Window.dimensions gameState
