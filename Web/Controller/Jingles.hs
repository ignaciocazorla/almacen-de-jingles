{-
* *****************************************************************************
* Copyright (C) 2025 Ignacio Cazorla, Pablo E. --Fidel-- Martínez López
*
* This program is free software distributed under the terms of the
* GNU Affero General Public License version 3.
* Additional terms added in compliance to section 7 of such license apply.
*
* You may read the full license at https://github.com/ignaciocazorla/almacen-de-jingles/LICENSE.
* *****************************************************************************
-}

{-
@author Ignacio Cazorla <cazorla.ignacio@hotmail.com>
@original_idea Pablo E. --Fidel-- Martínez López <fidel.ml@gmail.com> 
@module Web.Controller.Jingles
-}

module Web.Controller.Jingles where

import Web.Controller.Prelude
import Web.View.Jingles.Index
import Web.View.Jingles.New
import Web.View.Jingles.Edit
import Web.View.Jingles.Show
import Data.Time (Day)

instance Controller JinglesController where

    action JinglesAction = do
        jingles <- query @Jingle |> fetch
        case currentUserOrNothing of
            Just currentUser -> do
                role <- fetch currentUser.userRoleId
                permissions <- query @UserPermission
                        |> filterWhere (#userRoleId, role.id)
                        |> fetch
                render IndexView { .. }
            Nothing -> do
                let permissions = []
                render IndexView { .. }

    action NewJingleAction = do
        ensureIsUser
        ensurePermission "Create"
        let jingle = newRecord
        render NewView { .. }

    action ShowJingleAction { jingleId } = do
        jingle <- fetch jingleId
        render ShowView { .. }

    action EditJingleAction { jingleId } = do
        ensureIsUser
        ensurePermission "Edit"
        jingle <- fetch jingleId
        render EditView { .. }

    action UpdateJingleAction { jingleId } = do
        ensureIsUser
        ensurePermission "Edit"
        jingle <- fetch jingleId
        jingle
            |> buildJingle
            |> ifValid \case
                Left jingle -> render EditView { .. }
                Right jingle -> do
                    jingle <- jingle |> updateRecord
                    setSuccessMessage "Jingle actualizado!"
                    redirectTo EditJingleAction { .. }

    action CreateJingleAction = do
        ensureIsUser
        ensurePermission "Create"
        let jingle = newRecord @Jingle
        jingle
            |> set #userId currentUser.id
            |> buildJingle
            |> ifValid \case
                Left jingle -> render NewView { .. } 
                Right jingle -> do
                    jingle <- jingle |> createRecord
                    setSuccessMessage "Jingle creado!"
                    redirectTo JinglesAction

    action DeleteJingleAction { jingleId } = do
        ensureIsUser
        ensurePermission "Delete"
        jingle <- fetch jingleId
        deleteRecord jingle
        setSuccessMessage "Jingle eliminado"
        redirectTo JinglesAction

    action SearchByFieldAction = do
        let field = paramText "selectedField"
        let value = paramText "search"
        let searchPattern = "%" <> value <> "%"
        jingles <- filterJinglesBy field searchPattern
        case currentUserOrNothing of
            Just currentUser -> do
                role <- fetch currentUser.userRoleId
                permissions <- query @UserPermission
                        |> filterWhere (#userRoleId, role.id)
                        |> fetch
                render IndexView { .. }
            Nothing -> do
                let permissions = []
                render IndexView { .. }

    action SearchByDateAction = do
        let field = paramText "selectedField"
        let from = param @Day "fecha_desde"
        let to = param @Day "fecha_hasta"
        jingles <- sqlQuery "SELECT * FROM jingles WHERE fecha BETWEEN ? AND ?" (from, to)
        case currentUserOrNothing of
            Just currentUser -> do
                role <- fetch currentUser.userRoleId
                permissions <- query @UserPermission
                        |> filterWhere (#userRoleId, role.id)
                        |> fetch
                render IndexView { .. }
            Nothing -> do
                let permissions = []
                render IndexView { .. }
        

buildJingle jingle = jingle
    |> fill @'["nombre", "fecha", "link", "tiempoInicio", "nombreVideo", "bandaOriginal", "autor", "userId", "temaOriginal", "comentario"]
    |> validateField #nombre (nonEmpty |> withCustomErrorMessage "Campo obligatorio")
    |> validateField #link (nonEmpty |> withCustomErrorMessage "Campo obligatorio")
    |> validateField #nombreVideo (nonEmpty |> withCustomErrorMessage "Campo obligatorio")

ensurePermission action = ensurePermissions action "Jingles"

filterJinglesBy :: (?modelContext :: ModelContext) => Text -> Text -> IO[Jingle]
filterJinglesBy "nombre" searchPattern = filterByName searchPattern
filterJinglesBy "nombreVideo" searchPattern = filterByVideoName searchPattern
filterJinglesBy "bandaOriginal" searchPattern = filterByOriginalBand searchPattern
filterJinglesBy "autor" searchPattern = filterByAuthor searchPattern
filterJinglesBy "temaOriginal" searchPattern = filterByOriginalTheme searchPattern
filterJinglesBy _ _ = pure []

filterByName :: (?modelContext :: ModelContext) => Text -> IO[Jingle]
filterByName searchPattern = sqlQuery "SELECT * FROM jingles WHERE nombre ILIKE ?" (Only searchPattern)

filterByVideoName :: (?modelContext :: ModelContext) => Text -> IO[Jingle]
filterByVideoName searchPattern = sqlQuery "SELECT * FROM jingles WHERE nombre_video ILIKE ?" (Only searchPattern)

filterByOriginalBand :: (?modelContext :: ModelContext) => Text -> IO[Jingle]
filterByOriginalBand searchPattern = sqlQuery "SELECT * FROM jingles WHERE banda_original ILIKE ?" (Only searchPattern)

filterByAuthor :: (?modelContext :: ModelContext) => Text -> IO[Jingle]
filterByAuthor searchPattern = sqlQuery "SELECT * FROM jingles WHERE autor ILIKE ?" (Only searchPattern)

filterByOriginalTheme :: (?modelContext :: ModelContext) => Text -> IO[Jingle]
filterByOriginalTheme searchPattern = sqlQuery "SELECT * FROM jingles WHERE tema_original ILIKE ?" (Only searchPattern)