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
@module Web.Controller.Users
-}

module Web.Controller.Users where

import Web.Controller.Prelude
import Web.View.Users.New
import Web.View.Users.Edit
import Web.View.Users.Index
import Web.View.Users.AddUser
import Web.View.Users.Show

instance Controller UsersController where
    action UsersAction = do
        ensurePermission "List"
        users <- query @User |> fetch
        render IndexView { .. }

    action ShowUserAction { userId } = do
        user <- fetch userId
        render ShowView { .. }

    -- Registratiom form
    action NewUserAction = do
        let user = newRecord
        render NewView { .. }

    -- Manual admin add form
    action AddNewUserAction = do
        ensurePermission "Create"
        let user = newRecord
        roles <- query @UserRole |> fetch
        render AddUserView { .. }

    action EditUserAction { userId } = do
        ensurePermission "Edit"
        user <- fetch userId
        roles <- query @UserRole |> fetch

        render EditView { .. }

    action UpdateUserAction { userId } = do
        ensurePermission "Edit"
        user <- fetch userId
        roles <- query @UserRole |> fetch
        user
            |> buildUser
            |> ifValid \case
                Left user -> render EditView { .. }
                Right user -> do
                    user <- user |> updateRecord
                    setSuccessMessage "Usuario actualizado"
                    redirectTo EditUserAction { .. }

    -- Manual admin add
    action AddUserAction = do
        let user = newRecord @User
        -- The value from the password confirmation input field.
        let passwordConfirmation = param @Text "passwordConfirmation"
        user
            |> fill @["email", "name", "lastName", "passwordHash", "userRoleId"]
            |> validateUserFields passwordConfirmation
            >>= ifValid \case
                Left user -> redirectTo AddNewUserAction -- render AddUserView { .. }
                Right user -> do
                    hashed <- hashPassword user.passwordHash
                    user <- user
                        |> set #passwordHash hashed
                        |> createRecord
                    setSuccessMessage "Registraste un usuario exitosamente"
                    redirectTo UsersAction

    -- Registration
    action CreateUserAction = do
        let user = newRecord @User
        -- The value from the password confirmation input field.
        let passwordConfirmation = param @Text "passwordConfirmation"
        user
            |> fill @["email", "name", "lastName", "passwordHash"]
            |> validateUserFields passwordConfirmation
            >>= ifValid \case
                Left user -> render NewView { .. }
                Right user -> do
                    hashed <- hashPassword user.passwordHash
                    userRole <- query @UserRole
                        |> filterWhere (#name, "Editor")
                        |> fetchOne
                    user <- user
                        |> set #passwordHash hashed
                        |> set #userRoleId userRole.id
                        |> createRecord
                    setSuccessMessage "Te registraste exitosamente"
                    redirectTo NewSessionAction


    action DeleteUserAction { userId } = do
        ensurePermission "List"
        user <- fetch userId
        deleteRecord user
        setSuccessMessage "Usuario eliminado"
        redirectTo UsersAction

buildUser user = user
    |> fill @'["email", "name", "lastName", "passwordHash", "failedLoginAttempts", "userRoleId"]

validateUserFields passwordConfirmation user = user
    -- We ensure that the error message doesn't include
    -- the entered password.
    |> validateField #passwordHash (isEqual passwordConfirmation |> withCustomErrorMessage "Las contraseñas no coinciden")
    |> validateField #passwordHash nonEmpty
    |> validateField #email isEmail
    -- After this validation, since it's operation on the IO, we'll need to use >>=.
    |> validateIsUnique #email

ensurePermission action = ensurePermissions action "Users"