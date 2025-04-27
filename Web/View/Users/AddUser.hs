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
@module Web.View.Users.AddUser
-}

module Web.View.Users.AddUser where
import Web.View.Prelude

data AddUserView = AddUserView { user :: User }

instance View AddUserView where
    beforeRender view = do
        setLayout loggedInLayout
        
    html AddUserView { .. } = [hsx|
        {breadcrumb}
        <h1>Agregar usuario</h1>
        {renderForm user}
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Usuarios" UsersAction
                , breadcrumbText "Agregar Usuario"
                ]

renderForm :: User -> Html
renderForm user = formFor' user (pathTo AddUserAction) [hsx|
    {(emailField #email)}
    {(passwordField #passwordHash) {fieldLabel = "Contraseña", required = True}}
    {(passwordField #passwordHash) { required = True, fieldLabel = "Confirmar contraseña", fieldName = "passwordConfirmation", validatorResult = Nothing }}
    {(selectField #userRoleId roles) {fieldLabel = "Rol del usuario", placeholder = "Seleccionar Rol"}}
    {submitButton {label = "Agregar Usuario"}}

|]