module Board (Model, Action(..), Context, init, update, view) where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import List exposing (..)


type alias Model = { show: List Int, enableUpTo: Int}


type Action = AvailablePurchases Int


type alias Context = { buy: Signal.Address Int }


init : Model
init = { show = [1], enableUpTo = 0 }


update : Action -> Model -> Model
update (AvailablePurchases x) m = { m | show <- available (m.show |> reverse |> head) (x)
                                 , enableUpTo <- x }


available : Maybe Int -> Int -> List Int
available current new = 
    let 
        max = case current of
            Just c -> Basics.max c new
            Nothing -> new
    in
        reverse (availRec max 1 [])
        

availRec : Int -> Int -> [Int] -> [Int]
availRec n x xs = if n // x == 0 then xs else avail' n (x * 10 ) (x :: xs)    


view : Context -> Model -> Html
view c m = div [style [("display", "flex"), ("flex-direction", "row"), ("justify-content", "center")]]
               (map (makeButton c m.enableUpTo) m.show)


makeButton : Context -> Int -> Int -> Html
makeButton c max n = button [style [("margin-right", "5px")], disabled (n > max), onClick c.buy n] 
                            [text ("Buy " ++ (if n == 1 then "clicker" else (toString n)))]