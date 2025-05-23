const headerSortDownClass = "headerSortDown";
const headerSortUpClass = "headerSortUp";
const tableName = "jingles-table";
const orderAttribute = "data-order";

const isNumber = (x,y) => !isNaN(x) && !isNaN(y);

const tableBodyRows = table => Array.from(table.rows).slice(1);

const compareRows = (a, b, columnIndex, order) => {
    const x = a.cells[columnIndex].innerText;
    const y = b.cells[columnIndex].innerText;

    if (isNumber(x,y)) {
        return stringOrderToBool(order) ? x - y : y - x;
    } else {
        return stringOrderToBool(order)
            ? x.localeCompare(y)
            : y.localeCompare(x);
    }
}

const sortRowsForCol = (rows, columnIndex, order) => rows.sort((a,b) => compareRows(a,b,columnIndex,order));

const stringOrderToBool = stringOrder => {
    switch (stringOrder) {
        case "asc":
            return true;
        case "desc":
            return false;
    }
}

const boolOrderToString = order => order ? "asc" : "desc";

const boolOrderToClass = order => order ? headerSortUpClass : headerSortDownClass;

function updateTable(columnIndex) {
    const table = document.getElementById(tableName);
    const headers = Array.from(table.rows[0].cells);
    const elem = headers.find(each => each.hasAttribute(orderAttribute));
    let order = elem.getAttribute(orderAttribute);
    let sortedBody = sortRowsForCol(tableBodyRows(table), columnIndex, order);
    sortedBody.forEach(row => table.tBodies[0].appendChild(row));
    updateTableHeadRow(headers, columnIndex, stringOrderToBool(order));
}

// Find index of prev cell to add actual cell an arrow and remove arrow from previous elem
function updateTableHeadRow(headers, columnIndex, order){
    let index = headers.findIndex(each => each.hasAttribute(orderAttribute));
    if(index != columnIndex){
        headers[index].removeAttribute(orderAttribute);
    }
    headers[index].classList.remove(boolOrderToClass(order));
    headers[columnIndex].classList.add(boolOrderToClass(!order));
    headers[columnIndex].setAttribute(orderAttribute,boolOrderToString(!order));
}

window.sortTable = updateTable;