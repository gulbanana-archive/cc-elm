module Update where

import Debug
import Model exposing (..)


update : Action -> State -> State
update (Delta timeDelta) state = 
    let 
        foo = 5
    in
        {state | clicks <- state.clicks + state.clickers}
