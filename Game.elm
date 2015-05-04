module Game (Model, Action(..), init, update, view) where

import Html exposing (..)
import StatusBar

type alias Model = { status: StatusBar.Model, clickers: Int, clicks: Int }

init : Model
init = { status = StatusBar.init ["Clickers", "Clicks", "Idles"], clickers = 1, clicks = 0 }

type Action = Delta Float

update : Action -> Model -> Model
update (Delta timeDelta) state = 
    let 
        clicks = state.clicks + state.clickers
    in
        {state | clicks <- clicks, 
                 status <- StatusBar.update [state.clickers, clicks, 0] state.status }

view : (Int, Int) -> Model -> Html
view (w, h) m = StatusBar.view m.status