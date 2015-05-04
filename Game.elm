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
    , fractions: Float
    , idle: Int 
    }


type Action = Reset | Delta Float | BuyClicker Int


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


update : Action -> Model -> Model
update a m = updateUI (case (Debug.watch "action" a) of
  Reset -> init
  (Delta timeDelta) -> 
    let 
        cost = Debug.watch "click cost" (1000 / toFloat (m.clickers))
        fractions = Debug.watch "fractional clicks" (m.fractions + timeDelta)
        newClicks = floor (fractions / cost)
        clicks = m.clicks + newClicks
        idle = m.idle + floor timeDelta
    in
        { m | fractions <- fractions - (cost * toFloat newClicks)
            , clicks <- clicks
            , idle <- idle }
  BuyClicker x -> 
    let 
        clickers = m.clickers + x
        clicks = m.clicks - (x * 10)
        idle = 0
    in
        { m | clickers <- clickers
            , clicks <- clicks
            , idle <- idle })


updateUI : Model -> Model
updateUI m = { m | status <- StatusBar.update [m.clickers, m.clicks, m.idle // 1000] m.status
                 , board <- Board.update (Board.AvailablePurchases (m.clicks // 10)) m.board }


view : Signal.Address Action -> (Int, Int) -> Model -> Html
view a (w, h) m = div [style [("height", toString (h-22) ++ "px"), ("display", "flex"), ("flex-direction", "column"), ("align-items", "stretch")]] 
                      [ div [] [StatusBar.view m.status]
                      , div [style [("flex", "1"), ("display", "flex"), ("flex-direction", "column"), ("align-content", "stretch"), ("justify-content", "center")]] 
                            [Board.view (Board.Context (Signal.forwardTo a (\x -> BuyClicker x)))
                                        m.board]
                      , div [style [("align-items", "flex-end")]] [StatusBar.view m.status]
                      ]