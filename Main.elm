import Html exposing (..)
import Time
import Window
import Game


clock = Signal.map Game.Delta (Time.fps 60)


input = Signal.mailbox Game.Reset


actions = Signal.merge clock input.signal


gameState : Signal Game.Model
gameState = Signal.foldp Game.update Game.init actions


main : Signal Html
main = Signal.map2 (Game.view input.address) Window.dimensions gameState
