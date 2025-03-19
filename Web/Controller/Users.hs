module Web.Controller.Users where

import Web.Controller.Prelude
import Web.View.Users.New
import Web.View.Users.Edit

instance Controller UsersController where
    action UsersAction = do
        let user = newRecord
        render NewView { .. }

    action NewUserAction = do
        let user = newRecord
        render NewView { .. }

    action EditUserAction { userId } = do
        user <- fetch userId
        render EditView { .. }

    action UpdateUserAction { userId } = do
        user <- fetch userId
        user
            |> buildUser
            |> ifValid \case
                Left user -> render EditView { .. }
                Right user -> do
                    user <- user |> updateRecord
                    setSuccessMessage "User updated"
                    redirectTo EditUserAction { .. }

    action CreateUserAction = do
        let user = newRecord @User
        -- The value from the password confirmation input field.
        let passwordConfirmation = param @Text "passwordConfirmation"
        user
            |> fill @["email", "passwordHash"]
            -- We ensure that the error message doesn't include
            -- the entered password.
            |> validateField #passwordHash (isEqual passwordConfirmation |> withCustomErrorMessage "Passwords don't match")
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
                    setSuccessMessage "You have registered successfully"
                    redirectToPath "/"

    -- action CreateUserAction = do
    --     let user = newRecord @User
    --     user
    --         |> buildUser
    --         |> ifValid \case
    --             Left user -> render NewView { .. } 
    --             Right user -> do
    --                 user <- user |> createRecord
    --                 setSuccessMessage "User created"
    --                 redirectTo UsersAction

    action DeleteUserAction { userId } = do
        user <- fetch userId
        deleteRecord user
        setSuccessMessage "User deleted"
        redirectTo UsersAction

buildUser user = user
    |> fill @'["email", "passwordHash", "failedLoginAttempts"]
