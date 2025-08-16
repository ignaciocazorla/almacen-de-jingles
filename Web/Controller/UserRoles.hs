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
@module Web.Controller.UserRoles
-}


module Web.Controller.UserRoles where

import Web.Controller.Prelude
import Web.View.UserRoles.Index
import Web.View.UserRoles.Show

instance Controller UserRolesController where
    action UserRolesAction = do
        userRoles <- query @UserRole |> fetch
        render IndexView { .. }

    action ShowUserRoleAndPermissionsAction { userRoleId } = do
        userRole <- fetch userRoleId
        userPermissions <- query @UserPermission 
            |> filterWhere (#userRoleId, userRoleId)
            |> fetch
        render ShowView { .. }

