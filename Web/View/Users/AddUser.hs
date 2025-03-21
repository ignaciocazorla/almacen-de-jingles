module Web.View.Users.AddUser where
import Web.View.Prelude

data AddUserView = AddUserView { user :: User }

instance View AddUserView where
    beforeRender view = do
        setLayout loggedInLayout
        
    html AddUserView { .. } = [hsx|
        {breadcrumb}
        <h1>Agregar usuario</h1>
        {renderForm user}
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Usuarios" UsersAction
                , breadcrumbText "Agregar Usuario"
                ]

renderForm :: User -> Html
renderForm user = formFor' user (pathTo AddUserAction) [hsx|
    {(emailField #email)}
    {(passwordField #passwordHash) {fieldLabel = "Contraseña", required = True}}
    {(passwordField #passwordHash) { required = True, fieldLabel = "Confirmar contraseña", fieldName = "passwordConfirmation", validatorResult = Nothing }}
    {(selectField #userRoleId roles) {fieldLabel = "Rol del usuario", placeholder = "Seleccionar Rol"}}
    {submitButton {label = "Agregar Usuario"}}

|]