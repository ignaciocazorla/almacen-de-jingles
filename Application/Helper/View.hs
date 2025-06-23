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
hasRolePermissions :: [UserPermission] -> Text -> Text -> Html -> Html
hasRolePermissions userPermission resource permission html = 
    renderElem (hasPermission userPermission resource permission) html

hasPermission :: [UserPermission] -> Text -> Text -> Bool
hasPermission [] resource action = False
hasPermission (x:xs) resource action = (x.resource == resource && x.action == action) || hasPermission xs resource action

renderElem True html  = html
renderElem False hmtl = [hsx||]

instance CanSelect UserRole where
    -- Here we specify that the <option> value should contain an `Id`
    type SelectValue UserRole = Id UserRole
    -- Here we specify how to transform the model into <option>-value
    selectValue userRole = userRole.id
    -- And here we specify the <option>-text
    selectLabel userRole = userRole.name
                               