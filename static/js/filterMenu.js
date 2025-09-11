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
    const form = document.getElementById("users-filter-form");

    const roleSelect = document.querySelector(".filter-menu select");
    const nameLinks = document.querySelectorAll(".filter-menu ul:nth-of-type(2) a");
    const lastNameLinks = document.querySelectorAll(".filter-menu ul:nth-of-type(3) a");
    const noResultsRow = document.getElementById("no-results");

    const nameInput = form.querySelector('input[name="name-filter"]');
    const lastNameInput = form.querySelector('input[name="lastname-filter"]');

    let activeNameFilter = nameInput.value;
    let activeLastNameFilter = lastNameInput.value;
    let activeRoleFilter = "-";

    async function applyFilters() {        
        nameInput.value = activeNameFilter;
        lastNameInput.value = activeLastNameFilter;
        form.submit();
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

        links.forEach(link => {
            link.addEventListener("click", (e) => {
                e.preventDefault();
                links.forEach(l => l.classList.remove("active"));
                link.classList.add("active");
            });
        });
    }

    function tableIsEmpty(){
        let empty = rows.every(elem => elem.style.display.toString() == "none");
        noResultsRow.style.display = empty ? "" : "none";
    }

    setupFilter(".name-filter");
    setupFilter(".lastname-filter");
    tableIsEmpty();
});