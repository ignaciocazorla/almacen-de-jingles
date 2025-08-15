module Web.Controller.GoogleSessions where
import Web.Controller.Prelude
import Web.View.Sessions.New
import qualified Data.Text as T
import qualified IHP.AuthSupport.Controller.Sessions as Sessions

instance Controller GoogleSessionsController where
    action CreateGoogleSessionAction = do
        let jwt = paramText "jwt"
        decodeJWT (T.unpack jwt)
        -- renderPlain (jwt)
        -- Sessions.usersQueryBuilder
        -- |> filterWhereCaseInsensitive (#email, param "jwt")
        -- |> fetchOneOrNothing
        -- >>= \case
            -- Just (user :: User) -> do
            --     decodeJWT (param "jwt")
                -- putStrLn "Me llega algo"
                -- beforeLogin user
                -- login user
                -- redirectUrl <- getSessionAndClear "IHP.LoginSupport.redirectAfterLogin"
                -- redirectToPath (fromMaybe (afterLoginRedirectPath @record) redirectUrl)
                -- redirectTo JinglesAction
            -- Nothing -> do
            --     putStrLn "Debo crear el usuario"
                --redirectTo buildNewSessionAction
        redirectTo JinglesAction

instance Sessions.SessionsControllerConfig User

        