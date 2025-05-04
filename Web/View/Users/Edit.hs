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
@module Web.View.Users.Edit
-}

module Web.View.Users.Edit where
import Web.View.Prelude

data EditView = EditView { user :: User }

instance View EditView where
    beforeRender view = do
        setLayout loggedInLayout
        
    html EditView { .. } = [hsx|
        {breadcrumb}
        <h1>Editar usuario</h1>
        {renderForm user}
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Usuarios" UsersAction
                , breadcrumbText "Editar usuario"
                ]

renderForm :: User -> Html
renderForm user = formFor user [hsx|
    {(emailField #email)}
    {(textField #name) {fieldLabel = "Nombre", required = True}}
    {(textField #lastName) {fieldLabel = "Apellido", required = True}}
    {(selectField #userRoleId roles) {fieldLabel = "Rol del usuario", placeholder = "Seleccionar Rol"}}
    {submitButton {label = "Editar Usuario"}}

|]