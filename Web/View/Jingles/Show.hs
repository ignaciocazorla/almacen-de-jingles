module Web.View.Jingles.Show where
import Web.View.Prelude

data ShowView = ShowView { jingle :: Jingle }

instance View ShowView where
    beforeRender view = do
        setLayout loggedInLayout

    html ShowView { .. } = [hsx|
        {breadcrumb}
        <h1>{jingle.nombre}</h1>
        <div>
            <ul class="jingle-list">
                <li><strong>Nombre del Jingle:</strong> {jingle.nombre}</li>
                <li><strong>Enlace:</strong> <a href={jingle.link} target="_blank">{jingle.link}</a></li>
                <li><strong>Fecha de salida:</strong> {jingle.fecha}</li>
                <li><strong>Tiempo dentro del video:</strong> {jingle.tiempoInicio}</li>
                <li><strong>Nombre del video:</strong> {jingle.nombreVideo}</li>
                <li><strong>Banda original:</strong> {jingle.bandaOriginal}</li>
                <li><strong>Artista creador:</strong> {jingle.creadoPor}</li>
            </ul>
        </div> 

    |]
        where
            breadcrumb = renderBreadcrumb
                            [ breadcrumbLink "Jingles" JinglesAction
                            , breadcrumbText "Detalle del Jingle"
                            ]