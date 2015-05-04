module Game (Model, Action(..), init, update, view) where

import Debug
import Html exposing (..)
import Html.Attributes exposing (..)
import StatusBar
import Board

type alias Model = 
    { status: StatusBar.Model
    , board: Board.Model
    , clickers: Int
    , clicks: Int
    , fractions: Int
    , idle: Int 
    }

init : Model
init = 
    { status = StatusBar.init [("Clickers", "+1 click per second each"), 
                               ("Clicks", "ten buys you a clicker; 100 = ???"), 
                               ("Idle", "accumulates when not buying")]
    , board = Board.init
    , clickers = 1
    , clicks = 0
    , fractions = 0
    , idle = 0 
    }

type Action = Reset | Delta Int | BuyClicker Int

update : Action -> Model -> Model
update a m = case (Debug.watch "action" a) of
  Reset -> init
  (Delta timeDelta) -> 
    let 
        cost = Debug.watch "click cost" (1000 // m.clickers)
        fractions = Debug.watch "fractional clicks" (m.fractions + timeDelta)
        clicks = m.clicks + fractions // cost
        idle = m.idle + timeDelta
    in
        { m | fractions <- fractions `rem` cost
            , clicks <- clicks
            , idle <- idle
            , status <- StatusBar.update [m.clickers, clicks, idle] m.status
            , board <- Board.update (Board.AvailablePurchases (clicks//10)) m.board
            }
  BuyClicker x -> 
    let 
        clickers = m.clickers + x
        clicks = m.clicks - (x * 10)
        idle = 0
    in
        { m | clickers <- clickers
            , clicks <- clicks
            , idle <- idle
            , status <- StatusBar.update [clickers, clicks, idle] m.status
            , board <- Board.update (Board.AvailablePurchases (clicks//10)) m.board
            }

view : Signal.Address Action -> (Int, Int) -> Model -> Html
view a (w, h) m = div [style [("height", toString (h-22) ++ "px"), ("display", "flex"), ("flex-direction", "column"), ("align-items", "stretch")]] 
                      [ div [] [StatusBar.view m.status]
                      , div [style [("flex", "1"), ("display", "flex"), ("flex-direction", "column"), ("align-content", "stretch"), ("justify-content", "center")]] 
                            [Board.view (Board.Context (Signal.forwardTo a (\x -> BuyClicker x)))
                                        m.board]
                      , div [style [("align-items", "flex-end")]] [StatusBar.view m.status]
                      ]