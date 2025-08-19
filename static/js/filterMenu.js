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
@file static/js/filterMenu.js
*/

document.addEventListener("DOMContentLoaded", () => {
    const table = document.getElementById("users-table");
    const rows = Array.from(table.querySelectorAll("tbody tr:not(#no-results)"));

    const roleSelect = document.querySelector(".filter-menu select");
    const nameLinks = document.querySelectorAll(".filter-menu ul:nth-of-type(2) a");
    const lastNameLinks = document.querySelectorAll(".filter-menu ul:nth-of-type(3) a");
    const noResultsRow = document.getElementById("no-results");

    let activeNameFilter = "Todos";
    let activeLastNameFilter = "Todos";
    let activeRoleFilter = "-";

    function applyFilters() {
        rows.forEach(row => {
            const nombre = row.cells[1].textContent.trim();
            const apellido = row.cells[2].textContent.trim();
            const roles = row.cells[3].textContent.trim();

            let show = true;

            // role filter
            if (activeRoleFilter !== "-" && !roles.includes(activeRoleFilter)) {
                show = false;
            }

            // name filter (first letter)
            if (activeNameFilter !== "Todos" && !nombre.startsWith(activeNameFilter)) {
                show = false;
            }

            // last-name filter (first letter)
            if (activeLastNameFilter !== "Todos" && !apellido.startsWith(activeLastNameFilter)) {
                show = false;
            }

            row.style.display = show ? "" : "none";
        });
        
        let empty = rows.every(elem => elem.style.display.toString() == "none");
        noResultsRow.style.display = empty ? "" : "none";
    }

    roleSelect.addEventListener("change", e => {
        activeRoleFilter = e.target.value;
        applyFilters();
    });

    nameLinks.forEach(link => {
        link.addEventListener("click", e => {
            e.preventDefault();
            activeNameFilter = link.textContent.trim();
            applyFilters();
        });
    });

    lastNameLinks.forEach(link => {
        link.addEventListener("click", e => {
            e.preventDefault();
            activeLastNameFilter = link.textContent.trim();
            applyFilters();
        });
    });

    function setupFilter(groupSelector) {
        const links = document.querySelectorAll(`${groupSelector} a`);
        if (links.length === 0) return;

        links[0].classList.add("active");

        links.forEach(link => {
            link.addEventListener("click", (e) => {
                e.preventDefault();
                links.forEach(l => l.classList.remove("active"));
                link.classList.add("active");
            });
        });
    }

    setupFilter(".name-filter");
    setupFilter(".lastname-filter");
});