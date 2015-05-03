module Model where


type alias GameState = 
    { elapsed: Float
    , text: String
    }

initialModel : GameState
initialModel = 
    { elapsed = 0
    , text = "Hello, Elm"
    }
