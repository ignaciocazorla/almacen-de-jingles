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
@module Web.View.UsersRoles.Show
-}

module Web.View.UserRoles.Show where
import Web.View.Prelude
import Data.Aeson

data ShowView = ShowView { userRole :: UserRole, userPermissions :: [UserPermission] }

instance View ShowView where
    json ShowView { userRole, userPermissions } =
        object
            [ "id" .= userRole.id
            , "name" .= userRole.name
            , "permissions" .= userPermissions
            ]

instance ToJSON UserRole where
    toJSON userRole = object
        [ "id" .= userRole.id
        , "name" .= userRole.name
        ]

instance ToJSON UserPermission where
    toJSON userPermission = object
        [ "id" .= userPermission.id
        , "resource" .= userPermission.resource
        , "action" .= userPermission.action
        ]
