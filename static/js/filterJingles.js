/*
*****************************************************************************
Copyright (C) 2025 Ignacio Cazorla, Pablo E. --Fidel-- Martínez López

This program is free software distributed under the terms of the
GNU Affero General Public License version 3.
Additional terms added in compliance to section 7 of such license apply.

You may read the full license at https://github.com/ignaciocazorla/almacen-de-jingles/LICENSE.
*****************************************************************************
*/

/*
@author Ignacio Cazorla <cazorla.ignacio@hotmail.com>
@original_idea Pablo E. --Fidel-- Martínez López <fidel.ml@gmail.com> 
@file static/js/filterJingles.js
*/

document.addEventListener("DOMContentLoaded", () => {
    const select = document.getElementById("search");
    const form = document.getElementById("jingles-filter-form");
    const textInput = form.querySelector('input[name="search"]');
    const inputContainer = document.getElementById("dateInputs")

    select.addEventListener("change", () => {
        if (select.value === "fecha") {
            textInput.value = "";
            textInput.style.display = "none";

            inputContainer.style.display = "inline-block";

            // Set SearchByDate action to form
            form.setAttribute("action", "/SearchByDate");
        } else {
            textInput.style.display = "inline-block";
            inputContainer.style.display = "none";

            // Set SearchByField action to form
            form.setAttribute("action", "/SearchByField");
        }
    });
});
