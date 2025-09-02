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
@module Web.View.Jingles.Show
-}

module Web.View.Jingles.Show where
import Web.View.Prelude
import Data.Aeson

data ShowView = ShowView { jingle :: Jingle }

instance View ShowView where
    beforeRender view = do
        setLayout loggedInLayout

    html ShowView { .. } = [hsx|
        {breadcrumb}
        <h1>{jingle.nombre}</h1>
        <div class="table-responsive">
            <table id="jingle-show" class="table">
                <thead>
                </thead>
                <tbody>
                    <tr>
                        <td><strong>Jingle:</strong></td>
                        <td>{jingle.nombre}</td>
                    </tr>
                    <tr>
                        <td><strong>Autor:</strong></td>
                        <td>{jingle.autor}</td>
                    </tr>
                    <tr>
                        <td><strong>Fecha de salida:</strong></td>
                        <td>{jingle.fecha}</td>
                    </tr>
                    <tr>
                        <td><strong>Tema original:</strong></td>
                        <td>{jingle.temaOriginal}</td>
                    </tr>
                    <tr>
                        <td><strong>Banda original:</strong></td>
                        <td>{jingle.bandaOriginal}</td>
                    </tr>
                    <tr>
                        <td><strong>Nombre del video:</strong></td>
                        <td>{jingle.nombreVideo}</td>
                    </tr>
                    <tr>
                        <td><strong>Enlace:</strong></td>
                        <td><a href={jingle.link} target="_blank">{jingle.link}</a></td>
                    </tr>
                    <tr>
                        <td><strong>Tiempo dentro del video:</strong></td>
                        <td>{jingle.tiempoInicio}</td>
                    </tr>
                    <tr>
                        <td><strong>Comentario:</strong></td>
                        <td>{jingle.comentario}</td>
                    </tr>
                </tbody>
            </table>
        </div> 

    |]
        where
            breadcrumb = renderBreadcrumb
                            [ breadcrumbLink "Jingles" JinglesAction
                            , breadcrumbText "Detalle del Jingle"
                            ]
    json ShowView { .. } = toJSON jingle

instance ToJSON Jingle where
    toJSON jingle = object
        [ "id" .= jingle.id
        , "nombre" .= jingle.nombre
        , "fecha" .= jingle.fecha
        , "enlace" .= jingle.link
        , "tiempo_inicio" .= jingle.tiempoInicio
        , "nombre_video" .= jingle.nombreVideo
        , "banda_original" .= jingle.bandaOriginal
        , "autor" .= jingle.autor
        , "user_id" .= jingle.userId
        , "tema_original" .= jingle.temaOriginal
        , "comentario" .= jingle.comentario
        ]