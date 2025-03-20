module Web.View.Jingles.Edit where
import Web.View.Prelude

data EditView = EditView { jingle :: Jingle }

instance View EditView where
    html EditView { .. } = [hsx|
        {breadcrumb}
        <h1>Editar Jingle</h1>
        {renderForm jingle}
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Jingles" JinglesAction
                , breadcrumbText "Editar Jingle"
                ]

renderForm :: Jingle -> Html
renderForm jingle = formFor jingle [hsx|
    {(textField #nombre)}
    {(dateField #fecha) {helpText = "Debe usar formato año-mes-día"}}
    {(urlField #link)}
    {(textField #tiempoInicio)}
    {(textField #nombreVideo)}
    {(textField #bandaOriginal)}
    {(textField #creadoPor)}
    {submitButton {label = "Guardar cambios"}}

|]