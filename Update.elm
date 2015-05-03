module Update where

import Debug
import Model exposing (..)

{-- Part 1: Model the user input ----------------------------------------------

What information do you need to represent all relevant user input?

Task: Redefine `UserInput` to include all of the information you need.
      Redefine `userInput` to be a signal that correctly models the user
      input as described by `UserInput`.

------------------------------------------------------------------------------}

type alias UserInput = {}


userInput : Signal UserInput
userInput = Signal.constant {}


type alias Input = { 
    timeDelta : Float,
    userInput : UserInput
}

{-- Part 3: Update the game ---------------------------------------------------

How does the game step from one state to another based on user input?

Task: redefine `stepGame` to use the UserInput and GameState
      you defined in parts 1 and 2. Maybe use some helper functions
      to break up the work, stepping smaller parts of the game.

------------------------------------------------------------------------------}

update : Input -> GameState -> GameState
update {timeDelta,userInput} state = 
    let 
        newElapsed = Debug.watch "elapsed" state.elapsed + Debug.watch "timeDelta" timeDelta
    in
        {state | elapsed <- newElapsed
               , text <- "Hello, Elm @" ++ (toString newElapsed)}
