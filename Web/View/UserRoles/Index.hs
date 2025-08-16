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
@module Web.View.UsersRoles.Index
-}

module Web.View.UserRoles.Index where
import Web.View.Prelude
import Data.Aeson

data IndexView = IndexView { userRoles :: [UserRole] }

instance View IndexView where
    beforeRender view = do
        setLayout loggedInLayout

    html IndexView { .. } = [hsx|
        {breadcrumb}

        <h1>Roles</h1>
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th></th>
                        <th></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>{forEach userRoles renderUserRole}</tbody>
            </table>
            
        </div>
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Roles de usuario" UserRolesAction
                ]
    json IndexView { .. } = toJSON userRoles

instance ToJSON UserRole where
    toJSON userRoles = object
        [ "id" .= userRoles.id
        , "name" .= userRoles.name
        ]
        
renderUserRole :: UserRole -> Html
renderUserRole userRole = [hsx|
    <tr>
        <td>{userRole.name}</td>
        <!-- <td><a href={EditUserRoleAction userRole.id} class="text-muted">Editar</a></td>
        <td><a href={DeleteUserRoleAction userRole.id} class="js-delete text-muted">Borrar</a></td> -->
    </tr>
|]