module Web.View.Users.AddUser where
import Web.View.Prelude

data AddUserView = AddUserView { user :: User }

instance View AddUserView where
    html AddUserView { .. } = [hsx|
        {breadcrumb}
        <h1>Agregar usuario</h1>
        {renderForm user}
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Users" UsersAction
                , breadcrumbText "Edit User"
                ]

renderForm :: User -> Html
renderForm user = formFor user [hsx|
    {(emailField #email)}
    {(passwordField #passwordHash) {fieldLabel = "Contraseña"}}
    {(passwordField #passwordHash) {fieldLabel = "Repetir contraseña"}}
    {submitButton {label = "Crear Usuario"}}

|]