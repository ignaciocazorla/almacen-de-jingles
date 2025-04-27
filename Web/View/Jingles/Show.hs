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
@module Web.View.Jingles/Show
-}

module Web.View.Jingles.Show where
import Web.View.Prelude

data ShowView = ShowView { jingle :: Jingle }

instance View ShowView where
    beforeRender view = do
        setLayout loggedInLayout

    html ShowView { .. } = [hsx|
        {breadcrumb}
        <h1>{jingle.nombre}</h1>
        <div>
            <ul class="jingle-list">
                <li><strong>Nombre del Jingle:</strong> {jingle.nombre}</li>
                <li><strong>Enlace:</strong> <a href={jingle.link} target="_blank">{jingle.link}</a></li>
                <li><strong>Fecha de salida:</strong> {jingle.fecha}</li>
                <li><strong>Tiempo dentro del video:</strong> {jingle.tiempoInicio}</li>
                <li><strong>Nombre del video:</strong> {jingle.nombreVideo}</li>
                <li><strong>Banda original:</strong> {jingle.bandaOriginal}</li>
                <li><strong>Artista creador:</strong> {jingle.creadoPor}</li>
            </ul>
        </div> 

    |]
        where
            breadcrumb = renderBreadcrumb
                            [ breadcrumbLink "Jingles" JinglesAction
                            , breadcrumbText "Detalle del Jingle"
                            ]