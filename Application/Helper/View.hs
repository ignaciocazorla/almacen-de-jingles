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

data Role = Role {
    value   :: Int,
    name    :: Text
} deriving (Show)

roles = [Role {value = 0, name = "Admin"}, Role {value = 1, name = "Editor"}, Role {value = 2, name = "Reader"}]

instance CanSelect Role where
    -- Here we specify that the <option> value should contain an `Int`
    type SelectValue Role = Int
    -- Here we specify how to transform the model into <option>-value
    selectValue role = role.value
    -- And here we specify the <option>-text
    selectLabel role = role.name
                               