module Application.Helper.Controller where

import IHP.ControllerPrelude
import Generated.Types
import Web.Types

-- Here you can add functions which are available in all your controllers

isAdmin :: User -> Bool
isAdmin user = roleFromInt user.userRoleId == Admin

isEditor :: User -> Bool
isEditor user = roleFromInt user.userRoleId == Editor

hasRolePermissions :: User -> Resources -> Permissions -> Bool
hasRolePermissions user resource permission = hasPermission (roleFromInt user.userRoleId) resource permission

hasPermission :: UserRole -> Resources -> Permissions -> Bool
hasPermission Admin _ _        = True
hasPermission Editor Users _   = False
hasPermission Editor Jingles Read = True
hasPermission Editor Jingles Edit = True
hasPermission Editor Jingles List = True
hasPermission Reader Users _   = False
hasPermission Reader Jingles Read = True
hasPermission Reader Jingles List = True
hasPermission Reader Jingles _ = False
