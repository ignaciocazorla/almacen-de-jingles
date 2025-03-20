module Web.Controller.Jingles where

import Web.Controller.Prelude
import Web.View.Jingles.Index
import Web.View.Jingles.New
import Web.View.Jingles.Edit
import Web.View.Jingles.Show

instance Controller JinglesController where
    beforeAction = ensureIsUser

    action JinglesAction = do
        jingles <- query @Jingle |> fetch
        render IndexView { .. }

    action NewJingleAction = do
        accessDeniedUnless ( hasRolePermissions currentUser Jingles Create)
        let jingle = newRecord
        render NewView { .. }

    action ShowJingleAction { jingleId } = do
        jingle <- fetch jingleId
        render ShowView { .. }

    action EditJingleAction { jingleId } = do
        accessDeniedUnless ( hasRolePermissions currentUser Jingles Edit)
        jingle <- fetch jingleId
        render EditView { .. }

    action UpdateJingleAction { jingleId } = do
        accessDeniedUnless ( hasRolePermissions currentUser Jingles Edit)
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
        accessDeniedUnless ( hasRolePermissions currentUser Jingles Create)
        let jingle = newRecord @Jingle
        jingle
            |> buildJingle
            |> ifValid \case
                Left jingle -> render NewView { .. } 
                Right jingle -> do
                    jingle <- jingle |> createRecord
                    setSuccessMessage "Jingle creado!"
                    redirectTo JinglesAction

    action DeleteJingleAction { jingleId } = do
        accessDeniedUnless ( hasRolePermissions currentUser Jingles Delete)
        jingle <- fetch jingleId
        deleteRecord jingle
        setSuccessMessage "Jingle eliminado"
        redirectTo JinglesAction

buildJingle jingle = jingle
    |> fill @'["nombre", "fecha", "link", "tiempoInicio", "nombreVideo", "bandaOriginal", "creadoPor"]
    |> validateField #nombre (nonEmpty |> withCustomErrorMessage "Campo obligatorio")
    |> validateField #link (nonEmpty |> withCustomErrorMessage "Campo obligatorio")
    |> validateField #nombreVideo (nonEmpty |> withCustomErrorMessage "Campo obligatorio")
