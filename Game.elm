module Game (Model, Action(..), init, update, view) where

import Html exposing (..)
import Html.Attributes exposing (..)
import StatusBar
import Board

type alias Model = 
    { status: StatusBar.Model
    , board: Board.Model
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
    , board = Board.init
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
view (w, h) m = div [style [("height", toString (h-22) ++ "px"), ("display", "flex"), ("flex-direction", "column"), ("align-items", "stretch")]] 
                    [ div [] [StatusBar.view m.status]
                    , div [style [("flex", "1"), ("display", "flex"), ("align-content", "stretch"), ("justify-content", "center")]] [Board.view m.board]
                    , div [style [("align-items", "flex-end")]] [StatusBar.view m.status]
                    ]