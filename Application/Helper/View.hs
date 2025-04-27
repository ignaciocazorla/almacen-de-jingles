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
@module Application.Helper.View
-}

module Application.Helper.View where

import IHP.ViewPrelude
import Generated.Types
import Web.Types

-- Here you can add functions which are available in all your views
hasRolePermissions :: User -> Resources -> Permissions -> Html -> Html
hasRolePermissions user resource permission html = 
    renderElem (hasPermission (roleFromInt user.userRoleId) resource permission) html

renderElem True html  = html
renderElem False hmtl = [hsx||]

data Role = Role {
    value   :: Int,
    name    :: Text
} deriving (Show)

roles = [Role {value = 0, name = "Admin"}, Role {value = 1, name = "Editor"}, Role {value = 2, name = "Reader"}]

instance CanSelect Role where
    -- Here we specify that the <option> value should contain an `Int`
    type SelectValue Role = Int
    -- Here we specify how to transform the model into <option>-value
    selectValue role = role.value
    -- And here we specify the <option>-text
    selectLabel role = role.name
                               