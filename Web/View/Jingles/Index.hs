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
import Data.Aeson

data IndexView = IndexView { jingles :: [Jingle] }

instance View IndexView where
    beforeRender view = do
        setLayout loggedInLayout
        
    html IndexView { .. } = [hsx|
        {breadcrumb}

        <script src="/js/sortTable.js"></script>
        <link rel="stylesheet" href="/css/jinglesTable.css"/>

        <h1>Listado de Jingles {renderNewJingleButton}</h1>
        <div class="table-responsive">
            <table id="jingles-table" class="table">
                <thead>
                    <tr>
                        <th onclick="updateTable(0)" class="headerSortDown" data-order="desc">Jingle</th>
                        <th onclick="updateTable(1)">Video</th>
                        <th onclick="updateTable(2)">Fecha</th>
                        <th onclick="updateTable(3)">Artista Original</th>
                        <th onclick="updateTable(4)">Interprete</th>
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
            renderNewJingleButton = 
                case currentUserOrNothing of
                    Just _ -> 
                        hasRolePermissions currentUser Jingles Create
                            [hsx| <a href={pathTo NewJingleAction} class="btn btn-primary ms-4">+ Nuevo</a> |]
                    Nothing -> [hsx||]

renderJingle :: Jingle -> Html
renderJingle jingle = [hsx|
    <tr>
        <td><a href={ShowJingleAction jingle.id}>{jingle.nombre}</a></td>
        <td><a href={jingle.link} target="_blank">{jingle.nombreVideo}</a></td>
        <td>{jingle.fecha}</td>
        <td>{jingle.bandaOriginal}</td>
        <td>{jingle.creadoPor}</td>
        {renderEditButton}
        {renderDeleteButton}
    </tr>
    |]
    where 
        renderEditButton = 
            case currentUserOrNothing of
                    Just _ -> 
                        hasRolePermissions currentUser Jingles Edit
                            [hsx| <td><a href={EditJingleAction jingle.id} class="text-muted">Editar</a></td> |]
                    Nothing -> [hsx||]
    
        renderDeleteButton = 
            case currentUserOrNothing of
                    Just _ -> 
                        hasRolePermissions currentUser Jingles Delete
                            [hsx| <td><a href={DeleteJingleAction jingle.id} class="js-delete text-muted">Borrar</a></td> |]
                    Nothing -> [hsx||]
