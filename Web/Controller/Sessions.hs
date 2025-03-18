module Web.Controller.Sessions where
import Web.Controller.Prelude
import Web.View.Sessions.New

instance Controller SessionsController where
    -- action SessionsAction = render NewView

    action SessionsAction = do
        let user = newRecord
        render NewView { .. }