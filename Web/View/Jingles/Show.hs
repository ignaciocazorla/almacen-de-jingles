module Web.View.Jingles.Show where
import Web.View.Prelude

data ShowView = ShowView { jingle :: Jingle }

instance View ShowView where
    html ShowView { .. } = [hsx|
        {breadcrumb}
        <h1>{jingle.nombre}</h1>
        <a href={jingle.link}>{jingle.link}</a>

    |]
        where
            breadcrumb = renderBreadcrumb
                            [ breadcrumbLink "Jingles" JinglesAction
                            , breadcrumbText "Show Jingle"
                            ]