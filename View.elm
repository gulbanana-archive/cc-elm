module View where

import Graphics.Element exposing (..)
import Model

{-- Part 4: Display the game --------------------------------------------------

How should the GameState be displayed to the user?

Task: redefine `display` to use the GameState you defined in part 2.

------------------------------------------------------------------------------}

view : (Int,Int) -> Model.GameState -> Element
view (w,h) gameState = show gameState.text
