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
@module Web.View.Jingles.New
-}

module Web.View.Jingles.New where
import Web.View.Prelude

data NewView = NewView { jingle :: Jingle }

instance View NewView where
    beforeRender view = do
        setLayout loggedInLayout
        
    html NewView { .. } = [hsx|
        {breadcrumb}
        <h1>Nuevo Jingle</h1>
        {renderForm jingle}
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Jingles" JinglesAction
                , breadcrumbText "Nuevo Jingle"
                ]

renderForm :: Jingle -> Html
renderForm jingle = formFor jingle [hsx|
    {(textField #nombre)}
    {(dateField #fecha) {helpText = "Debe usar formato año-mes-día"}} 
    {(urlField #link)}
    {(textField #tiempoInicio)}
    {(textField #nombreVideo)}
    {(textField #bandaOriginal)}
    {(textField #creadoPor)}
    {submitButton {label = "Crear Jingle"}}

|]