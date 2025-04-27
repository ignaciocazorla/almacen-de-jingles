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
@module Web.View.Prelude
-}

module Web.View.Prelude
( module IHP.ViewPrelude
, module Web.View.Layout
, module Generated.Types
, module Web.Types
, module Application.Helper.View
) where

import IHP.ViewPrelude
import Web.View.Layout
import Generated.Types
import Web.Types
import Web.Routes ()
import Application.Helper.View
