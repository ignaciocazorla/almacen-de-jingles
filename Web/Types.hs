{-
*****************************************************************************
Copyright (C) 2025 Ignacio Cazorla, Pablo E. --Fidel-- Martínez López

This program is free software distributed under the terms of the
GNU Affero General Public License version 3.
Additional terms added in compliance to section 7 of such license apply.

You may read the full license at https://github.com/ignaciocazorla/almacen-de-jingles/LICENSE.
*****************************************************************************
-}

{-
@author Ignacio Cazorla <cazorla.ignacio@hotmail.com>
@original_idea Pablo E. --Fidel-- Martínez López <fidel.ml@gmail.com> 
@module Web.Types
-}

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
    | AddUserAction
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

hasPermission :: UserRole -> Resources -> Permissions -> Bool
hasPermission Admin  _       _    = True
hasPermission Editor Users   _    = False
hasPermission Editor Jingles Read = True
hasPermission Editor Jingles Edit = True
hasPermission Editor Jingles List = True
hasPermission Editor Jingles _    = False
hasPermission Reader Users   _    = False
hasPermission Reader Jingles Read = True
hasPermission Reader Jingles List = True
hasPermission Reader Jingles _    = False

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

