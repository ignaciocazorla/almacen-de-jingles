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
@module Web.View.Jingles.Index
-}

module Web.View.Jingles.Index where
import Web.View.Prelude

data IndexView = IndexView { jingles :: [Jingle] }

instance View IndexView where
    beforeRender view = do
        setLayout loggedInLayout
        
    html IndexView { .. } = [hsx|
        {breadcrumb}

        <h1>Listado de Jingles {newJingleButton}</h1>
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>Jingle</th>
                        <th></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>{forEach jingles renderJingle}</tbody>
            </table>
            
        </div>
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Jingles" JinglesAction
                ]
            newJingleButton = hasRolePermissions currentUser Jingles Create
                [hsx| <a href={pathTo NewJingleAction} class="btn btn-primary ms-4">+ Nuevo</a> |]

renderJingle :: Jingle -> Html
renderJingle jingle = [hsx|
    <tr>
        <td><a href={ShowJingleAction jingle.id}>{jingle.nombre}</a></td>
        {editButton}
        {deleteButton}
    </tr>
    |]
    where 
        editButton = hasRolePermissions currentUser Jingles Edit
                [hsx| <td><a href={EditJingleAction jingle.id} class="text-muted">Editar</a></td> |]
        deleteButton = hasRolePermissions currentUser Jingles Delete
                [hsx| <td><a href={DeleteJingleAction jingle.id} class="js-delete text-muted">Borrar</a></td> |]
