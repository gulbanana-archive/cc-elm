module Game (Model, Action(..), init, update, view) where

import Html exposing (..)
import StatusBar

type alias Model = 
    { status: StatusBar.Model
    , clickers: Int
    , clicks: Int
    , clickUpdate: Int
    , idle: Int 
    }

init : Model
init = 
    { status = StatusBar.init [("Clickers", "+1 click per second each"), 
                               ("Clicks", "used to buy clickers"), 
                               ("Idle", "accumulates when not buying")]
    , clickers = 1
    , clicks = 0
    , clickUpdate = 0
    , idle = 0 
    }

type Action = Delta Int

update : Action -> Model -> Model
update (Delta timeDelta) m = 
    let 
        clickUpdate = (m.clickUpdate + timeDelta) `rem` 1000
        clicks = m.clicks + (m.clickUpdate + timeDelta) // 1000
        idle = m.idle + timeDelta
    in
        { m | clickUpdate <- clickUpdate
            , clicks <- clicks
            , idle <- idle
            , status <- StatusBar.update [m.clickers, clicks, idle] m.status }

view : (Int, Int) -> Model -> Html
view (w, h) m = StatusBar.view m.status