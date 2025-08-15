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
@module Application.Helper.Controller
-}

module Application.Helper.Controller where

import IHP.ControllerPrelude
import Generated.Types
import Web.Types

-- JWT decode imports
import Web.JWT as JWT
import qualified Data.Text as T
import qualified Data.Text.IO as TIO
import Data.Aeson (Value(..))
import qualified Data.Map.Strict as M

-- Here you can add functions which are available in all your controllers

ensurePermissions action resource = do
    role <- fetch currentUser.userRoleId
    permission <- query @UserPermission
                        |> filterWhere (#userRoleId, role.id)
                        |> filterWhere (#resource, resource)
                        |> filterWhere (#action, action)
                        |> fetch
    accessDeniedUnless (hasPermission permission)

hasPermission :: [UserPermission] -> Bool
hasPermission [] = False
hasPermission permission = True

decodeJWT jwt = do
    -- Pega tu JWT aquí o usa entrada por consola:
    let jwtText = jwt

    -- Parsear el JWT
    let decodedJWT = JWT.decode (T.pack jwtText)

    case decodedJWT of
        Nothing -> putStrLn "JWT inválido o malformado."
        Just verifiedJWT -> do
            putStrLn "JWT decodificado exitosamente.\nClaims:"
            
            -- Obtener el objeto ClaimsSet
            let claimsSet = claims verifiedJWT

            -- Imprimir claims estándar
            -- putStrLn $ "- Issuer (iss): " ++ maybe "Ninguno" T.unpack (stringOrURIToText <$> iss claimsSet)
            -- putStrLn $ "- Subject (sub): " ++ maybe "Ninguno" T.unpack (stringOrURIToText <$> sub claimsSet)
            -- putStrLn $ "- Expiration (exp): " ++ maybe "Ninguno" show (exp claimsSet)

            -- Imprimir claims personalizados (si existen)
            -- putStrLn "\nClaims personalizados:"
            -- putStrLn (unregisteredClaims claimsSet)

            -- putStrLn $ "- Email: " ++ maybe "Ninguno" T.unpack (getEmailClaim claimsSet)
            let email = getEmailClaim claimsSet
            case email of
                Nothing -> putStrLn "Error"
                Just email -> putStrLn email

-- Recuperar el valor del claim "email"
getEmailClaim :: JWTClaimsSet -> Maybe T.Text
getEmailClaim claimsSet =
    case M.lookup "email" (unClaimsMap (unregisteredClaims claimsSet)) of
        Just (String email) -> Just email
        _ -> Nothing
