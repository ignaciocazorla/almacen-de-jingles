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
@module Application.Helper.Controller
-}

module Application.Helper.Controller where

import IHP.ControllerPrelude
import Generated.Types
import Web.Types

-- Here you can add functions which are available in all your controllers

isAdmin :: User -> Bool
isAdmin user = roleFromInt user.userRoleId == Admin

isEditor :: User -> Bool
isEditor user = roleFromInt user.userRoleId == Editor

hasRolePermissions :: User -> Resources -> Permissions -> Bool
hasRolePermissions user resource permission = hasPermission (roleFromInt user.userRoleId) resource permission
