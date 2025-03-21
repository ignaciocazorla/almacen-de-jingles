module Web.View.Users.New where
import Web.View.Prelude

data NewView = NewView { user :: User }

instance View NewView where
    beforeRender view = do
        setLayout loggedInLayout

    html NewView { .. } = [hsx|
        {breadcrumb}
        <h1>New User</h1>
        {renderForm user}
    |]
        where
            breadcrumb = renderBreadcrumb
                [ 
                  breadcrumbText "New User"
                ]

renderForm :: User -> Html
renderForm user = formFor user [hsx|
    {(textField #email)}
    {(passwordField #passwordHash) {fieldLabel = "Contraseña", required = True}}
    {(passwordField #passwordHash) { required = True, fieldLabel = "Confirmar contraseña", fieldName = "passwordConfirmation", validatorResult = Nothing }}
    {submitButton {label = "Crear Usuario"}}
|]