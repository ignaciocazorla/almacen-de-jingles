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
