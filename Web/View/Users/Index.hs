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
@module Web.View.Users.Index
-}

module Web.View.Users.Index where
import Web.View.Prelude

data IndexView = IndexView { users :: [User] }

instance View IndexView where
    beforeRender view = do
        setLayout loggedInLayout
        
    html IndexView { .. } = [hsx|
        {breadcrumb}

        <h1>Usuarios <a href={pathTo AddNewUserAction} class="btn btn-primary ms-4">+ Nuevo</a> </h1>
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>Usuario</th>
                        <th></th>
                        <th></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>{forEach users renderUser}</tbody>
            </table>
            
        </div>
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Usuarios" UsersAction
                ]
                

renderUser :: User -> Html
renderUser user = [hsx|
    <tr>
        <td>{user.email}</td>
        <td><a href={EditUserAction user.id} class="text-muted">Editar</a></td>
        <td><a href={DeleteUserAction user.id} class="js-delete text-muted">Borrar</a></td>
    </tr>
|]