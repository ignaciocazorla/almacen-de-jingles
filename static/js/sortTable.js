let ascendingOrder = false; // asc = true, desc = false
const headerSortDownClass = "headerSortDown";
const headerSortUpClass = "headerSortUp";
const tableName = "jingles-table";

const isNumber = (x,y) => !isNaN(x) && !isNaN(y);

const tableBodyRows = table => Array.from(table.rows).slice(1);

const compareRows = (a, b, columnIndex) => {
    const x = a.cells[columnIndex].innerText;
    const y = b.cells[columnIndex].innerText;

    if (isNumber(x,y)) {
        return ascendingOrder ? x - y : y - x;
    } else {
        return ascendingOrder
            ? x.localeCompare(y)
            : y.localeCompare(x);
    }
}

function updateTable(columnIndex) {
    const table = document.getElementById(tableName);
    sortRowsForCol(tableBodyRows(table), columnIndex).forEach(row => table.tBodies[0].appendChild(row));
    ascendingOrder = !ascendingOrder;
    updateTableHeadRow(table, columnIndex);
}

const sortRowsForCol = (rows, columnIndex) => rows.sort((a,b) => compareRows(a,b,columnIndex));

// Iterates over all elements to add actual order cell an arrow and remove arrow from previous elem
function updateTableHeadRow(table, columnIndex){
    let headers = Array.from(table.rows[0].cells);
    headers.forEach(each => each.className = "");
    headers[columnIndex].className = newCellOrder();
}

// Depending on ascendingOrder previous value set header arrow
const newCellOrder = () => ascendingOrder ? headerSortUpClass : headerSortDownClass;

window.sortTable = updateTable;