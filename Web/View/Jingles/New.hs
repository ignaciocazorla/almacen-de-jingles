module Web.View.Jingles.New where
import Web.View.Prelude

data NewView = NewView { jingle :: Jingle }

instance View NewView where
    html NewView { .. } = [hsx|
        {breadcrumb}
        <h1>Nuevo Jingle</h1>
        {renderForm jingle}
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Jingles" JinglesAction
                , breadcrumbText "Nuevo Jingle"
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
    {submitButton {label = "Crear Jingle"}}

|]