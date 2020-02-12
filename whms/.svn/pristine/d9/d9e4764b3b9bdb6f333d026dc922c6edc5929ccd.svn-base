onload = function () {

    // initialize tabs used to show the source code
    var tabSrc = document.querySelectorAll('.tab-source');
    for (var i = 0; i < tabSrc.length; i++) {
        new wijmo.nav.TabPanel(tabSrc[i]);
    }

    // create some random data
    function getData(cnt) {
        var data = [],
            dt = new Date(),
            countries = ['US', 'Germany', 'UK', 'Japan', 'Italy', 'Greece'],
            products = ['Widget', 'Gadget', 'Doohickey'],
            colors = ['Black', 'White', 'Red', 'Green', 'Blue'];
        for (var i = 0; i < cnt; i++) {
            var date = new Date(dt.getFullYear(), i % 12, 25, i % 24, i % 60, i % 60),
                countryId = Math.floor(Math.random() * countries.length),
                productId = Math.floor(Math.random() * products.length),
                colorId = Math.floor(Math.random() * colors.length);
            data.push({
                id: i,
                start: date,
                end: date,
                country: countries[countryId],
                product: products[productId],
                color: colors[colorId],
                amount: Math.random() * 10000 - 5000,
                active: i % 4 === 0,
            });
        }
        return data;
    }
    function getNames() {
        return 'id,start,end,country,product,color,amount,active'.split(',');
    }


    /////////////////////////////////////////////////////////
    // Getting Started
    var cvGettingStarted = new wijmo.collections.CollectionView(getData(10));
    var gsGrid = new wijmo.grid.FlexGrid('#gsGrid', {
        itemsSource: cvGettingStarted
    });


    /////////////////////////////////////////////////////////
    // Current Record Management
    var cvCRM = new wijmo.collections.CollectionView(getData(10));
    var crmGrid = new wijmo.grid.FlexGrid('#crmGrid', {
        isReadOnly: true,
        selectionMode: 'Row',
        itemsSource: cvCRM
    });

    // handle prev/next buttons
    document.getElementById('btnCRMMoveNext').addEventListener('click', function () {
        cvCRM.moveCurrentToNext();
    });
    document.getElementById('btnCRMMovePrev').addEventListener('click', function () {
        cvCRM.moveCurrentToPrevious();
    });

    // handle the currentChanging event to restrict navigation
    document.getElementById('btnCRMStop4').addEventListener('click', function () {
        cvCRM.currentChanging.addHandler(stopCurrentIn4th);
    });

    // remove navigation restriction
    document.getElementById('btnCRMReset').addEventListener('click', function () {
        cvCRM.currentChanging.removeHandler(stopCurrentIn4th);
    });

    // restrict navigation at the fourth item
    function stopCurrentIn4th(sender, e) {
        e.cancel = sender.currentPosition == 3;
    }


    /////////////////////////////////////////////////////////
    // Sorting
    var cvSorting = new wijmo.collections.CollectionView(getData(10));
    var sortingGrid = new wijmo.grid.FlexGrid('#sortingGrid', {
        isReadOnly: true,
        allowSorting: false,
        itemsSource: cvSorting
    });

    // select sort field and direction
    var sortingFieldNameList = new wijmo.input.ComboBox('#sortingFieldNameList', {
        itemsSource: getNames(),
        placeholder: 'Choose Field to Sort On',
        isRequired: false,
        selectedIndex: -1,
        textChanged: applySort
    });
    var sortingOrderList = new wijmo.input.ComboBox('#sortingOrderList', {
        itemsSource: ['Ascending', 'Descending'],
        textChanged: applySort
    });

    // apply the sort
    function applySort() {
        var sds = cvSorting.sortDescriptions,
            fieldName = sortingFieldNameList.text,
            ascending = sortingOrderList.text == 'Ascending';

        // remove old sort
        sds.splice(0, sds.length);

        // add new sort
        if (fieldName) {
            sds.push(new wijmo.collections.SortDescription(fieldName, ascending));
        }
    }


    /////////////////////////////////////////////////////////
    // Filtering
    var cvFiltering = new wijmo.collections.CollectionView(getData(20));
    var filteringGrid = new wijmo.grid.FlexGrid('#filteringGrid', {
        isReadOnly: true,
        itemsSource: cvFiltering
    });

    // apply filter when input changes
    var toFilter = null;
    document.getElementById('filteringInput').addEventListener('input', function () {
        if (toFilter) {
            clearTimeout(toFilter);
        }
        toFilter = setTimeout(function () {
            toFilter = null;
            if (cvFiltering.filter == filterFunction) {
                cvFiltering.refresh();
            } else {
                cvFiltering.filter = filterFunction;
            }
        }, 500);
    });

    // filter function for the collection view.
    function filterFunction(item) {
        var filter = filteringInput.value.toLowerCase();
        return filter
            ? item.country.toLowerCase().indexOf(filter) > -1
            : true;
    }


    /////////////////////////////////////////////////////////
    // Grouping
    var cvGrouping = new wijmo.collections.CollectionView(getData(20));
    var groupingGrid = new wijmo.grid.FlexGrid('#groupingGrid', {
        isReadOnly: true,
        itemsSource: cvGrouping
    });

    // initialize the field combo and listen to changes
    var groupingFieldNameList = new wijmo.input.ComboBox('#groupingFieldNameList', {
        itemsSource: getNames(),
        placeholder: 'Select field',
        isRequired: false,
        selectedIndex: -1,
        textChanged: applyGrouping
    });

    // clear groups
    document.getElementById('btnClearGroups').addEventListener('click', function () {
        groupingFieldNameList.text = '';
    });

    // apply the selected grouping
    function applyGrouping() {
        var gd = cvGrouping.groupDescriptions,
            fieldName = groupingFieldNameList.text;

        // no field? clear grouping
        if (!fieldName) {
            gd.splice(0, gd.length);
            return;
        }

        // add group description if not already defined
        if (!groupDefined(fieldName)) {
            if (fieldName === 'amount') {
                // when grouping by amount, use ranges instead of specific values
                gd.push(new wijmo.collections.PropertyGroupDescription(fieldName, function (item, propName) {
                    var value = item[propName]; // amount
                    if (value > 1000) return 'Large Amounts';
                    if (value > 100) return 'Medium Amounts';
                    if (value > 0) return 'Small Amounts';
                    return 'Negative Amounts';
                }));
            } else {
                // group by specific property values
                gd.push(new wijmo.collections.PropertyGroupDescription(fieldName));
            }
        }
    }

    // check whether the group with the specified property name already exists.
    function groupDefined(propName) {
        var gd = cvGrouping.groupDescriptions;
        for (var i = 0; i < gd.length; i++) {
            if (gd[i].propertyName === propName) {
                return true;
            }
        }
        return false;
    }


    /////////////////////////////////////////////////////////
    // Editing
    var cvEditing = new wijmo.collections.CollectionView(getData(10), {

        // define newItemCreator with proper unique id
        newItemCreator: function () {
            var item = getData(1)[0];
            item.id = wijmo.getAggregate(wijmo.Aggregate.Max, cvEditing.sourceCollection, 'id') + 1;
            return item;
        }
    });
    var editingGrid = new wijmo.grid.FlexGrid('#editingGrid', {
        selectionMode: wijmo.grid.SelectionMode.Row,
        itemsSource: cvEditing
    });

    // create dialog used to edit items
    var dlgDetail = new wijmo.input.Popup('#dlgDetail', {
        removeOnHide: false
    });

    // start editing item
    document.getElementById('btnEdit').addEventListener('click', function () {
        var editItem = cvEditing.currentItem;
        cvEditing.editItem(editItem);
        showDialog(editItem, 'Edit Item');
    });

    // start adding item
    document.getElementById('btnAdd').addEventListener('click', function () {
        var editedItem = cvEditing.addNew();
        showDialog(editedItem, 'Add Item');
    });

    // delete current item
    document.getElementById('btnDelete').addEventListener('click', function () {
        cvEditing.remove(cvEditing.currentItem);
    });

    // populate the dialog with the current item's values
    function showDialog(item, title) {

        // update dialog inputs
        setInputValue('edtID', item.id != null ? wijmo.Globalize.format(item.id) : '');
        setInputValue('edtStart', item.start != null ? wijmo.Globalize.format(item.start) : '');
        setInputValue('edtEnd', item.end != null ? wijmo.Globalize.format(item.end) : '');
        setInputValue('edtCountry', item.country != null ? item.country : '');
        setInputValue('edtProduct', item.product != null ? item.product : '');
        setInputValue('edtColor', item.color != null ? item.color : '');
        setInputValue('edtAmount', item.amount != null ? wijmo.Globalize.format(item.amount) : '');
        setInputValue('edtActive', item.active);
        title.innerHTML = title;

        // show dialog
        dlgDetail.show(true, function (s) {
            if (s.dialogResult == 'wj-hide-ok') {

                // commit changes
                var item = cvEditing.currentEditItem || cvEditing.currentAddItem;
                if (item) {
                    updateItem(item);
                }
                cvEditing.commitEdit();
                cvEditing.commitNew();

            } else {

                // cancel changes
                cvEditing.cancelEdit();
                cvEditing.cancelNew();
            }
        });
    }

    // update item with values from the dialog
    function updateItem(item) {
        setItemValue(item, 'id', 'edtID', wijmo.DataType.Number);
        setItemValue(item, 'start', 'edtStart', wijmo.DataType.Date);
        setItemValue(item, 'end', 'edtEnd', wijmo.DataType.Date);
        setItemValue(item, 'country', 'edtCountry', wijmo.DataType.String);
        setItemValue(item, 'product', 'edtProduct', wijmo.DataType.String);
        setItemValue(item, 'color', 'edtColor', wijmo.DataType.String);
        setItemValue(item, 'amount', 'edtAmount', wijmo.DataType.Number);
        setItemValue(item, 'active', 'edtActive', wijmo.DataType.Boolean);
    }

    // set the value of an input element
    function setInputValue(id, value) {
        var input = document.getElementById(id);
        if (input.type == 'checkbox') {
            input.checked = value;
        } else {
            input.value = value;
        }
    }

    // set the value of an input element
    function setItemValue(item, prop, id, dataType) {
        var input = document.getElementById(id);
        item[prop] = input.type == 'checkbox'
            ? input.checked
            : wijmo.changeType(input.value, dataType)
    }


    /////////////////////////////////////////////////////////
    // Paging
    var cvPaging = new wijmo.collections.CollectionView(getData(55), {
        pageSize: 10,
        pageChanged: function () {
            updatePagingButtons();
        }
    });
    var pagingGrid = new wijmo.grid.FlexGrid('#pagingGrid', {
        isReadOnly: true,
        itemsSource: cvPaging
    });

    // edit page size
    var pagingInput = new wijmo.input.InputNumber('#pagingInput', {
        min: 0,
        max: 20,
        step: 5,
        valueChanged: function (s, e) {
            cvPaging.pageSize = s.value;
            updatePagingButtons();
        },
        value: cvPaging.pageSize
    });

    // page navigation
    document.getElementById('btnFirstPage').addEventListener('click', function () {
        cvPaging.moveToFirstPage();
    });;
    document.getElementById('btnPreviousPage').addEventListener('click', function () {
        cvPaging.moveToPreviousPage();
    });
    document.getElementById('btnNextPage').addEventListener('click', function () {
        cvPaging.moveToNextPage();
    });;
    document.getElementById('btnLastPage').addEventListener('click', function () {
        cvPaging.moveToLastPage();
    });;

    // update the navigation buttons
    function updatePagingButtons() {

        // show/hide navigation bar
        var nav = document.getElementById('currentPagePanel');
        if (cvPaging.pageSize <= 0) {
            nav.style.display = 'none';
            return;
        }
        nav.style.display = '';

        // show current page
        document.getElementById('btnCurrentPage').textContent =
            (cvPaging.pageIndex + 1) + ' / ' + cvPaging.pageCount;

        // first/prev
        var disabled = cvPaging.pageIndex == 0 ? 'disabled' : null;
        wijmo.setAttribute(document.getElementById('btnFirstPage'), 'disabled', disabled);
        wijmo.setAttribute(document.getElementById('btnPreviousPage'), 'disabled', disabled);

        // next/last
        disabled = cvPaging.pageIndex >= cvPaging.pageCount - 1 ? 'disabled' : null;
        wijmo.setAttribute(document.getElementById('btnNextPage'), 'disabled', disabled);
        wijmo.setAttribute(document.getElementById('btnLastPage'), 'disabled', disabled);
    }


    /////////////////////////////////////////////////////////
    // Change Tracking

    // create CollectionView with change tracking enabled
    var cvTrackingChanges = new wijmo.collections.CollectionView(getData(6), {
        trackChanges: true
    });

    // create a grid to show and edit the data
    var tcMainGrid = new wijmo.grid.FlexGrid('#tcMainGrid', {
        allowAddNew: true,
        allowDelete: true,
        itemsSource: cvTrackingChanges
    });

    // create gridS to show the changes (edits, additions, removals)
    var colDefs = [
        { header: 'id', binding: 'id' },
        { header: 'start', binding: 'start' },
        { header: 'end', binding: 'end' },
        { header: 'country', binding: 'country' },
        { header: 'product', binding: 'product' },
        { header: 'color', binding: 'color' },
        { header: 'amount', binding: 'amount' },
        { header: 'active', binding: 'active' }
    ];
    var tcEditedGrid = new wijmo.grid.FlexGrid('#tcEditedGrid', {
        isReadOnly: true,
        autoGenerateColumns: false,
        columns: colDefs,
        itemsSource: cvTrackingChanges.itemsEdited
    });
    var tcAddedGrid = new wijmo.grid.FlexGrid('#tcAddedGrid', {
        isReadOnly: true,
        autoGenerateColumns: false,
        columns: colDefs,
        itemsSource: cvTrackingChanges.itemsAdded
    });
    var tcRemovedGrid = new wijmo.grid.FlexGrid('#tcRemovedGrid', {
        isReadOnly: true,
        autoGenerateColumns: false,
        columns: colDefs,
        itemsSource: cvTrackingChanges.itemsRemoved
    });
    
}