module Model where


type alias State = 
    { clickers: Int
    , clicks: Int
    }

type Action = Delta Float

initialModel : State
initialModel = 
    { clickers = 1
    , clicks = 0
    }
