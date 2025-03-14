module Web.Types where

import IHP.Prelude
import IHP.ModelSupport
import Generated.Types

data WebApplication = WebApplication deriving (Eq, Show)


data StaticController = WelcomeAction deriving (Eq, Show, Data)

data JinglesController
    = JinglesAction
    | NewJingleAction
    | ShowJingleAction { jingleId :: !(Id Jingle) }
    | CreateJingleAction
    | EditJingleAction { jingleId :: !(Id Jingle) }
    | UpdateJingleAction { jingleId :: !(Id Jingle) }
    | DeleteJingleAction { jingleId :: !(Id Jingle) }
    deriving (Eq, Show, Data)
