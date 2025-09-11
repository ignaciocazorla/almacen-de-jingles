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
import Data.Aeson

data IndexView = IndexView { users :: [User], roles :: [UserRole], roleFilter :: Text, nameFilter:: Text, lastNameFilter :: Text }

instance View IndexView where
    beforeRender view = do
        setLayout loggedInLayout
        
    html IndexView { .. } = [hsx|
        {breadcrumb}

        <script src="/js/sortTable.js"></script>
        <script src="/js/filterMenu.js"></script>
        <link rel="stylesheet" href="/css/tableSort.css"/>
        <link rel="stylesheet" href="/css/nameFilter.css"/>

        <h1>Usuarios <a href={pathTo AddNewUserAction} class="btn btn-primary ms-4">+ Nuevo</a> </h1>

        <div class="filter-menu">
            <h3>Filtros</h3>
            <form id="users-filter-form" action="/UsersFilter">
                <ul class="horizontal-menu">
                    <li><b>Rol</b></li>
                    <li>
                        <select name="role-filter">
                            <option value="-">-</option>
                            {forEach roles (renderRoles roleFilter)}
                        </select>
                    </li>
                </ul> 
        
                <ul class="horizontal-menu name-filter">
                    <li><b>Nombre</b></li>
                    {forEach listItems (renderListItem nameFilter)}
                </ul>
                <ul class="horizontal-menu lastname-filter">
                    <li><b>Apellido</b></li>
                    {forEach listItems (renderListItem lastNameFilter)}
                </ul>

                <div id="filter-inputs" style="display:none">
                    <input value={nameFilter} name="name-filter">
                    <input value={lastNameFilter} name="lastname-filter">
                </div>
            </form>
        </div>

        <div class="table-responsive">
            <table id="users-table" class="table" data-sortable="true">
                <thead>
                    <tr>
                        <th class="headerSortDown" data-order="desc">Email</th>
                        <th>Nombre</th>
                        <th>Apellido</th>
                        <th>Rol</th>
                    </tr>
                </thead>
                <tbody>
                    {forEach users (renderUser roles)}
                    <tr id="no-results" style="display:none;">
                        <td colspan="6" class="text-center text-muted">No hay usuarios para mostrar</td>
                        <td style="display:none;"></td>
                        <td style="display:none;"></td>
                        <td style="display:none;"></td>
                    </tr>
                </tbody>
            </table>
            
        </div>
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Usuarios" UsersAction
                ]
    json IndexView { .. } = toJSON users

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

renderUser :: [UserRole] -> User ->  Html
renderUser roles user = [hsx|
    <tr>
        <td>{user.email}</td>
        <td>{user.name}</td>
        <td>{user.lastName}</td>
        {renderRoleForUser user roles}
        <td><a href={EditUserAction user.id} class="text-muted">Editar</a></td>
        <td><a href={DeleteUserAction user.id} class="js-delete text-muted">Borrar</a></td>
    </tr>
|]

renderListItem :: Text -> Text -> Html
renderListItem selectedChar char = 
    if char == selectedChar then
        [hsx|
        <li><a href="" name="name" class="active">{char}</a></li>
    |]
    else [hsx|
        <li><a href="" name="name">{char}</a></li>
    |]

listItems :: [Text]
listItems = ["Todos","A","B","C","D","E","F","G","H","I","J","K","L","M","N","Ñ","O","P","Q","R","S","T","U","V","W","X","Y","Z"]

renderRoles :: Text -> UserRole -> Html
renderRoles selectedRole role =
    if role.name == selectedRole then
        [hsx|
        <option value={role.name} selected>{role.name}</option>
    |]
    else [hsx|
        <option value={role.name}>{role.name}</option>
    |]

renderRoleForUser :: User -> [UserRole] -> Html
renderRoleForUser user roles =
    case find (\r -> r.id == user.userRoleId) roles of
        Just role -> [hsx|<td>{role.name}</td>|]
        Nothing   -> [hsx|<td>"-"</td>|]

