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
@module Web.View.Users.New
-}

module Web.View.Users.New where
import Web.View.Prelude

data NewView = NewView { user :: User }

instance View NewView where

    html NewView { .. } = [hsx|
        {breadcrumb}
        <h1>Nuevo usuario</h1>
        {renderForm user}
    |]
        where
            breadcrumb = renderBreadcrumb
                [ 
                  breadcrumbText "Nuevo usuario"
                ]

renderForm :: User -> Html
renderForm user = formFor user [hsx|
    {(textField #email)}
    {(textField #name) {fieldLabel = "Nombre", required = True}}
    {(textField #lastName) {fieldLabel = "Apellido", required = True}}
    {(passwordField #passwordHash) {fieldLabel = "Contraseña", required = True}}
    {(passwordField #passwordHash) { required = True, fieldLabel = "Confirmar contraseña", fieldName = "passwordConfirmation", validatorResult = Nothing }}
    {submitButton {label = "Crear Usuario"}}
|]