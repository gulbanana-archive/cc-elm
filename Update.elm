module Update where

import Debug
import Model exposing (..)


type alias UserInput = {}


type alias Input = { 
    timeDelta : Float,
    userInput : UserInput
}


update : Input -> GameState -> GameState
update {timeDelta,userInput} state = 
    let 
        newElapsed = Debug.watch "elapsed" state.elapsed + Debug.watch "timeDelta" timeDelta
    in
        {state | elapsed <- newElapsed
               , text <- "Hello, Elm @" ++ (toString newElapsed)}
