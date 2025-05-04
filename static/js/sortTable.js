let ascendingOrder = false; // asc = true, desc = false

function sortTable(columnIndex) {
    const table = document.getElementById("jingles-table");
    const rows = Array.from(table.rows).slice(1);
    rows.sort((a, b) => {
        const x = a.cells[columnIndex].innerText;
        const y = b.cells[columnIndex].innerText;

        const isNumber = !isNaN(x) && !isNaN(y);
        if (isNumber) {
            return ascendingOrder ? x - y : y - x;
        } else {
            return ascendingOrder
                ? x.localeCompare(y)
                : y.localeCompare(x);
        }
    });

    rows.forEach(row => table.tBodies[0].appendChild(row));
    ascendingOrder = !ascendingOrder;
}

window.sortTable = sortTable;