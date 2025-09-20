#!/bin/bash
{- #!/usr/bin/env run-script -}
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
@module InitializeApp
-}

module Application.Script.InitializeApp where

import Application.Script.Prelude
import Config

import IHP.EnvVar


newtype AdminEmail = AdminEmail Text
newtype AdminPass = AdminPass Text

createPermission roleId resource action = 
    newRecord @UserPermission 
            |> set #userRoleId roleId 
            |> set #resource resource 
            |> set #action action
            |> createRecord

run :: Script
run = do
    adminEmail <- AdminEmail <$> env @Text "ADMIN_USER_EMAIL"
    adminPass <- AdminPass <$> env @Text "ADMIN_USER_PASS"

    -- Roles
    adminRole <- newRecord @UserRole
                |> set #name "Admin"
                |> createRecord
    editorRole <- newRecord @UserRole
                |> set #name "Editor"
                |> createRecord
    readerRole <- newRecord @UserRole
                |> set #name "Reader"
                |> createRecord
    chiefReaderRole <- newRecord @UserRole
                |> set #name "ChiefEditor"
                |> createRecord

    -- Admin permissions
    -- Jingles resource
    createPermission adminRole.id "Jingles" "Create"
    createPermission adminRole.id "Jingles" "Edit"
    createPermission adminRole.id "Jingles" "Delete"
    createPermission adminRole.id "Jingles" "List"
    createPermission adminRole.id "Jingles" "Read"

    -- Users resource
    createPermission adminRole.id "Users" "Create"
    createPermission adminRole.id "Users" "Edit"
    createPermission adminRole.id "Users" "Delete"
    createPermission adminRole.id "Users" "List"
    createPermission adminRole.id "Users" "Read"

    -- UserRoles resource
    createPermission adminRole.id "UserRoles" "List"

    -- ChiefEditor permissions
    -- Jingles resource
    createPermission chiefReaderRole.id "Jingles" "Edit"
    createPermission chiefReaderRole.id "Jingles" "Delete"
    createPermission chiefReaderRole.id "Jingles" "List"
    createPermission chiefReaderRole.id "Jingles" "Read"

    -- Editor permissions
    -- Jingles resource
    createPermission editorRole.id "Jingles" "Edit"
    createPermission editorRole.id "Jingles" "List"
    createPermission editorRole.id "Jingles" "Read"

    -- Reader permissions
    -- Jingles resource
    createPermission readerRole.id "Jingles" "Read"

    let (AdminEmail email) = adminEmail
    let (AdminPass pass) = adminPass

    -- Check whether admin user exists
    maybeAdmin <- query @User
        |> filterWhere (#email, email)
        |> fetchOneOrNothing

    case maybeAdmin of
        Just _ -> putStrLn "Admin ya existe, omitiendo creación."
        Nothing -> do
            hashedPassword <- hashPassword pass
            let adminUser = newRecord @User
                    |> set #email email
                    |> set #passwordHash hashedPassword
                    |> set #userRoleId adminRole.id

            adminUser |> create
            putStrLn "Usuario administrador creado con éxito."
