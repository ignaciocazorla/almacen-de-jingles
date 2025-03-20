module Application.Helper.View where

import IHP.ViewPrelude
import Generated.Types
import Web.Types

-- Here you can add functions which are available in all your views
hasRolePermissions :: User -> Resources -> Permissions -> Html -> Html
hasRolePermissions user resource permission html = 
    renderElem (hasPermission (roleFromInt user.userRoleId) resource permission) html

renderElem True html  = html
renderElem False hmtl = [hsx||]

-- renderForAdmin :: UserRole -> Html -> Html
-- renderForAdmin Admin elem = elem
-- renderForAdmin _     elem = [hsx||] 
                               