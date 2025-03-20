module Web.View.Users.Index where
import Web.View.Prelude

data IndexView = IndexView { users :: [User] }

instance View IndexView where
    html IndexView { .. } = [hsx|
        {breadcrumb}

        <h1>Usuarios <a href={pathTo AddNewUserAction} class="btn btn-primary ms-4">+ Nuevo</a> </h1>
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>User</th>
                        <th></th>
                        <th></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>{forEach users renderUser}</tbody>
            </table>
            
        </div>
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Usuarios" UsersAction
                ]
            -- renderAddButton = renderForAdmin (roleFromInt currentUser.userRole) 
            --                                  [hsx| 
            --                                     <a href={pathTo AddNewUserAction} class="btn btn-primary ms-4">+ New</a> 
            --                                 |]

                

renderUser :: User -> Html
renderUser user = [hsx|
    <tr>
        <td>{user.email}</td>
        <td><a href={ShowUserAction user.id}>Detalle</a></td>
        <td><a href={EditUserAction user.id} class="text-muted">Editar</a></td>
        <td><a href={DeleteUserAction user.id} class="js-delete text-muted">Borrar</a></td>
    </tr>
|]