module Web.View.Jingles.Index where
import Web.View.Prelude

data IndexView = IndexView { jingles :: [Jingle] }

instance View IndexView where
    html IndexView { .. } = [hsx|
        {breadcrumb}

        <h1>Listado de Jingles<a href={pathTo NewJingleAction} class="btn btn-primary ms-4">+ Nuevo</a></h1>
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>Jingle</th>
                        <th></th>
                        <th></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>{forEach jingles renderJingle}</tbody>
            </table>
            
        </div>
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Jingles" JinglesAction
                ]

renderJingle :: Jingle -> Html
renderJingle jingle = [hsx|
    <tr>
        <td><a href={ShowJingleAction jingle.id}>{jingle.nombre}</a></td>
        <td><a href={EditJingleAction jingle.id} class="text-muted">Editar</a></td>
        <td><a href={DeleteJingleAction jingle.id} class="js-delete text-muted">Borrar</a></td>
    </tr>
|]