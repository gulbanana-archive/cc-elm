import Html exposing (..)
import Time
import Window
import Model exposing (..)
import View exposing (..)
import Update exposing (..)



{-- That's all folks! ---------------------------------------------------------

The following code puts it all together and shows it on screen.

------------------------------------------------------------------------------}

delta : Signal Float
delta = Time.fps 60


input : Signal Input
input = Signal.sampleOn delta (Signal.map2 Input delta userInput)


gameState : Signal GameState
gameState = Signal.foldp update initialModel input


main : Signal Html
main = Signal.map2 view Window.dimensions gameState
