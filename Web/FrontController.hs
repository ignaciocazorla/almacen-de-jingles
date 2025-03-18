module Web.FrontController where

import IHP.RouterPrelude
import Web.Controller.Prelude
import Web.View.Layout (defaultLayout)

-- Controller Imports
import Web.Controller.Users
import Web.Controller.Jingles
import Web.Controller.Sessions

instance FrontController WebApplication where
    controllers = 
        [ startPage SessionsAction
        -- Generator Marker
        , parseRoute @UsersController
        , parseRoute @JinglesController
        ]

instance InitControllerContext WebApplication where
    initContext = do
        setLayout defaultLayout
        initAutoRefresh
