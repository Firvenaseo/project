let mainValues = []; // Значения главной таблицы
let activeRowIndex = null; // Индекс активной строки

function userFetch(url, options, callback) { // Отправка запроса
    fetch(url, options)
    .then(function(response) {
        return response.json();
    }).then(function(data) {
        if (data.error == 1) {
            throw(data.errorMsg);
        }
        
        callback(data.data)
    }).catch(function(error) {
        alert(error);
    });
}

userFetch('api/extra/read.php', null, function(data) {
    const rows = [];

    data.forEach(function(item) {
        rows.push(`<option value="${item.id}">${item.name}</option>`);
    });

    document.querySelector('#select-extra').innerHTML += rows.join('');
    updateMain();
});


function updateMain() {
    setActiveRow(null); // сброс активной строки

    userFetch('api/main/read.php', null, function(data) { // получение данных из БД
        mainValues = data;
        buildTable();
    });
}

hideItem();

function removeRow(index) { // удаление строки
    const needToRemove = confirm('Вы действительно хотите удалить запись?');

    if (!needToRemove) {
        return;
    }

    const id = mainValues[index].id;

    userFetch(`api/main/delete.php?id=${id}`, null, function() {
        updateMain();
    });
    hideItem();
}

function buildTable() { // создание таблицы и заполнение данными
    const rows = [];

    mainValues.forEach(function(item, index) {
        const row = `
        <tr data-index="${index}" onclick="rowClick(${index})">
            <td>${item.name_phone}</td>
            <td>${item.price}</td>
            <td>${item.color}</td>
            <td>${item.manufacturer}</td>
            <td>${item.extra_name}</td>
            <td onclick="event.stopPropagation(); removeRow(${index})">
                <img width="20" src="img/delete.svg">
            </td>
        </tr>`;
        rows.push(row);
    });

    document.querySelector('#main-container').innerHTML = rows.join('');
}

function setActiveRow(index) {
// если есть активная строка, удалить у нее класс activeRow
    if (activeRowIndex !== null) {
        const item = document.querySelector(`[data-index="${activeRowIndex}"]`);
        if (item) {
            item.classList.remove('activeRow');
        }
    }

    activeRowIndex = index; // установить индекс активной строки

    if (index === null) {
        ['#name_phone', '#price','#color', '#manufacturer'].forEach(function(id) {
            document.querySelector(id).value = null;
        });

        return;
    }
    // добваление новой активной строке класс activeRow
    const item = document.querySelector(`[data-index="${index}"]`);
    if (item) {
        item.classList.add('activeRow');
    }
}

function rowClick(index) {
    setActiveRow(index);
    const item = mainValues[index];
    // заполнение полей редактирования
    document.querySelector('#name_phone').value = item.name_phone;
    document.querySelector('#price').value = item.price;
    document.querySelector('#color').value = item.color;
    document.querySelector('#manufacturer').value = item.manufacturer;
    document.querySelector('#select-extra').value = item.extra_id;
    showEditItem();
}

function addRow() { // добавление строки
    const bodyJson = {
        name_phone: document.querySelector('#name_phone').value,
        price: document.querySelector('#price').value,
        color: document.querySelector('#color').value,
        manufacturer: document.querySelector('#manufacturer').value,
        extra_id: document.querySelector('#select-extra').value
    }

    userFetch(`api/main/upgrade.php`, {
        method: 'POST',
        body: JSON.stringify(bodyJson)
    }, function(data) {
        updateMain();
    });
    hideItem();
}

function editRow() {
    if (activeRowIndex === null) {
        return;
    }
    // подготовка данных для отправления
    const bodyJson = {
        id: mainValues[activeRowIndex].id,
        name_phone: document.querySelector('#name_phone').value,
        price: document.querySelector('#price').value,
        color: document.querySelector('#color').value,
        manufacturer: document.querySelector('#manufacturer').value,
        extra_id: document.querySelector('#select-extra').value
    }

    userFetch(`api/main/upgrade.php`, {
        method: 'POST',
        body: JSON.stringify(bodyJson)
    }, function() {
        updateMain();
    });
    hideItem();
}

function hideItem(){ // скрыть элементы
    setActiveRow(null);

    var content = document.getElementById('new-container');
    var elements = content.querySelectorAll('*');
    for (var i = 0; i < elements.length; i++) {
          elements[i].style.opacity = 0;
    }

    var x = document.getElementById("add-button");
    if (x.style.display === "inline") {
      x.style.display = "none";
    } 

    var x = document.getElementById("edit-button");
    if (x.style.display === "inline") {
      x.style.display = "none";
    } 
}

function showEditItem(){ 
    showContainer()

    var x = document.getElementById("add-button");
    if (x.style.display === "inline") {
      x.style.display = "none";
    } 

    var x = document.getElementById("edit-button");
    if (x.style.display === "none") {
      x.style.display = "inline";
    } 

    var p = document.getElementById("title-add-edit");
      p.textContent  = "Изменение записи";
}

function showAddItem() { 
    setActiveRow(null);
    showContainer()

    var x = document.getElementById("add-button");
    if (x.style.display === "none") {
        x.style.display = "inline";
       
    } 

    var x = document.getElementById("edit-button");
    if (x.style.display === "inline") {
      x.style.display = "none";
    } 

    var p = document.getElementById("title-add-edit");
    p.textContent  ="Добавление новой записи";
}

function showContainer()
{
    var content = document.getElementById('new-container');
    var elements = content.querySelectorAll('*');
    for (var i = 0; i < elements.length; i++) {
          elements[i].style.opacity = 100;
    }
}