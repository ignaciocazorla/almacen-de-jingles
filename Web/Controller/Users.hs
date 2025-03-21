module Web.Controller.Users where

import Web.Controller.Prelude
import Web.View.Users.New
import Web.View.Users.Edit
import Web.View.Users.Index
import Web.View.Users.AddUser

instance Controller UsersController where
    action UsersAction = do
        accessDeniedUnless ( hasRolePermissions currentUser Users List)
        users <- query @User |> fetch
        render IndexView { .. }

    action NewUserAction = do
        let user = newRecord
        render NewView { .. }

    action AddNewUserAction = do
        accessDeniedUnless ( hasRolePermissions currentUser Users Create)
        let user = newRecord
        render AddUserView { .. }

    action EditUserAction { userId } = do
        accessDeniedUnless ( hasRolePermissions currentUser Users Edit)
        user <- fetch userId
        render EditView { .. }

    action UpdateUserAction { userId } = do
        accessDeniedUnless ( hasRolePermissions currentUser Users Edit)
        user <- fetch userId
        user
            |> buildUser
            |> ifValid \case
                Left user -> render EditView { .. }
                Right user -> do
                    user <- user |> updateRecord
                    setSuccessMessage "Usuario actualizado"
                    redirectTo EditUserAction { .. }

    action AddUserAction = do
        let user = newRecord @User
        -- The value from the password confirmation input field.
        let passwordConfirmation = param @Text "passwordConfirmation"
        user
            |> fill @["email", "passwordHash", "userRoleId"]
            -- We ensure that the error message doesn't include
            -- the entered password.
            |> validateField #passwordHash (isEqual passwordConfirmation |> withCustomErrorMessage "Las contraseñas no coinciden")
            |> validateField #passwordHash nonEmpty
            |> validateField #email isEmail
            -- After this validation, since it's operation on the IO, we'll need to use >>=.
            |> validateIsUnique #email
            >>= ifValid \case
                Left user -> render AddUserView { .. }
                Right user -> do
                    hashed <- hashPassword user.passwordHash
                    user <- user
                        |> set #passwordHash hashed
                        |> createRecord
                    setSuccessMessage "Registraste un usuario exitosamente"
                    redirectTo UsersAction

    action CreateUserAction = do
        let user = newRecord @User
        -- The value from the password confirmation input field.
        let passwordConfirmation = param @Text "passwordConfirmation"
        user
            |> fill @["email", "passwordHash"]
            -- We ensure that the error message doesn't include
            -- the entered password.
            |> validateField #passwordHash (isEqual passwordConfirmation |> withCustomErrorMessage "Las contraseñas no coinciden")
            |> validateField #passwordHash nonEmpty
            |> validateField #email isEmail
            -- After this validation, since it's operation on the IO, we'll need to use >>=.
            |> validateIsUnique #email
            >>= ifValid \case
                Left user -> render NewView { .. }
                Right user -> do
                    hashed <- hashPassword user.passwordHash
                    user <- user
                        |> set #passwordHash hashed
                        |> createRecord
                    setSuccessMessage "Te registraste exitosamente"
                    redirectTo NewSessionAction


    action DeleteUserAction { userId } = do
        accessDeniedUnless ( hasRolePermissions currentUser Users List)
        user <- fetch userId
        deleteRecord user
        setSuccessMessage "Usuario eliminado"
        redirectTo UsersAction

buildUser user = user
    |> fill @'["email", "passwordHash", "failedLoginAttempts", "userRoleId"]
