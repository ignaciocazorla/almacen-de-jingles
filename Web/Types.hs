module Web.Types where

import IHP.Prelude
import IHP.ModelSupport
import IHP.LoginSupport.Types
import Generated.Types

data WebApplication = WebApplication deriving (Eq, Show)

data SessionsController
    = NewSessionAction
    | CreateSessionAction
    | DeleteSessionAction
    deriving (Eq, Show, Data)

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
    | AddNewUserAction
    deriving (Eq, Show, Data)

instance HasNewSessionUrl User where
    newSessionUrl _ = "/NewSession"

type instance CurrentUserRecord = User

data UserRole 
    = Admin 
    | Editor 
    | Reader
    deriving (Eq, Show)

roleFromInt :: Int -> UserRole
roleFromInt 0 = Admin
roleFromInt 1 = Editor
roleFromInt 2 = Reader
    
roleToInt :: UserRole -> Int
roleToInt Admin  = 0
roleToInt Editor = 1
roleToInt Reader = 2

data Permissions
    = Read
    | Edit
    | Create
    | Delete
    | List
    deriving (Eq, Show)

data Resources
    = Jingles
    | Users
    deriving (Eq, Show)

