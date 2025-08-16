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
@module Web.View.Users.Show
-}

module Web.View.Users.Show where
import Web.View.Prelude
import Data.Aeson

data ShowView = ShowView { user :: User }

instance View ShowView where
    beforeRender view = do
        setLayout loggedInLayout

    json ShowView { .. } = toJSON user

instance ToJSON User where
    toJSON user = object
        [ "id" .= user.id
        , "email" .= user.email
        , "password_hash" .= user.passwordHash
        , "locked_at" .= user.lockedAt
        , "failed_login_attempts" .= user.failedLoginAttempts
        , "name" .= user.name
        , "last_name" .= user.lastName
        , "user_role_id" .= user.userRoleId
        ]    