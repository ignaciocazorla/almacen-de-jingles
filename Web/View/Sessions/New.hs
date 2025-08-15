{-
*****************************************************************************
Copyright (C) 2025 Ignacio Cazorla, Pablo E. --Fidel-- Martínez López

This program is free software distributed under the terms of the
GNU Affero General Public License version 3.
Additional terms added in compliance to section 7 of such license apply.

You may read the full license at https://github.com/ignaciocazorla/almacen-de-jingles/LICENSE.
*****************************************************************************
-}

{-
@author Ignacio Cazorla <cazorla.ignacio@hotmail.com>
@original_idea Pablo E. --Fidel-- Martínez López <fidel.ml@gmail.com> 
@module Web.View.Sessions.New
-}

module Web.View.Sessions.New where
import Web.View.Prelude
import IHP.AuthSupport.View.Sessions.New

instance View (NewView User) where

    html NewView { .. } = [hsx|
        <script>
            function handleCredentialResponse(response){
                console.log(response);
                var form = document.getElementById('new-session-with-google-form');
                form.querySelector("input[name='jwt']").value = response.credential;
                form.submit();
            }
        </script>

        <div class="h-100" id="sessions-new">
            <div class="d-flex align-items-center">
                <div class="w-100">
                    <div style="max-width: 400px" class="mx-auto mb-5">
                        <h5>Login</h5>
                        {renderForm user}
                        <a href={pathTo NewUserAction} class="btn btn-primary btn-block">Registrarse</a>

                        <script src="https://accounts.google.com/gsi/client" async defer></script>
                        <div id="g_id_onload"
                                data-client_id="1086644617391-t8ikttegtm5j73a0kop400redpt6eg2n.apps.googleusercontent.com"
                                data-callback="handleCredentialResponse">
                        </div>
                        <div class="g_id_signin" data-type="standard">
                            <button>Login with Google</button>
                        </div>
                        <form method="POST" action={CreateGoogleSessionAction} id="new-session-with-google-form">
                                <input type="hidden" name="jwt" value=""/>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    |]


renderForm :: User -> Html
renderForm user = [hsx|
    <form method="POST" action={CreateSessionAction}>
        <div class="form-group">
            <input name="email" value={user.email} type="email" class="form-control" placeholder="E-Mail" required="required" autofocus="autofocus" />
        </div>
        <div class="form-group">
            <input name="password" type="password" class="form-control" placeholder="Contraseña"/>
        </div>
        <button type="submit" class="btn btn-primary btn-block">Login</button>
    </form>
|]