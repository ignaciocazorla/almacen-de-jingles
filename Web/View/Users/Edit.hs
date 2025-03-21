module Web.View.Users.Edit where
import Web.View.Prelude

data EditView = EditView { user :: User }

instance View EditView where
    beforeRender view = do
        setLayout loggedInLayout
        
    html EditView { .. } = [hsx|
        {breadcrumb}
        <h1>Editar usuario</h1>
        {renderForm user}
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Usuarios" UsersAction
                , breadcrumbText "Editar usuario"
                ]

renderForm :: User -> Html
renderForm user = formFor user [hsx|
    {(emailField #email)}
    {(selectField #userRoleId roles) {fieldLabel = "Rol del usuario", placeholder = "Seleccionar Rol"}}
    {submitButton {label = "Editar Usuario"}}

|]