module Web.Types where

import IHP.Prelude
import IHP.ModelSupport
import Generated.Types

data WebApplication = WebApplication deriving (Eq, Show)


data SessionsController = SessionsAction deriving (Eq, Show, Data)

data JinglesController
    = JinglesAction
    | NewJingleAction
    | ShowJingleAction { jingleId :: !(Id Jingle) }
    | CreateJingleAction
    | EditJingleAction { jingleId :: !(Id Jingle) }
    | UpdateJingleAction { jingleId :: !(Id Jingle) }
    | DeleteJingleAction { jingleId :: !(Id Jingle) }
    deriving (Eq, Show, Data)

data UsersController
    = UsersAction
    | NewUserAction
    | ShowUserAction { userId :: !(Id User) }
    | CreateUserAction
    | EditUserAction { userId :: !(Id User) }
    | UpdateUserAction { userId :: !(Id User) }
    | DeleteUserAction { userId :: !(Id User) }
    deriving (Eq, Show, Data)
