var CustomGridEditor = /** @class */ (function () {
    /**
     * Initializes a new instance of a CustomGridEditor.
     */
    function CustomGridEditor(flex, binding, edtClass, options) {
        var _this = this;
        // save references
        this._grid = flex;
        this._col = flex.columns.getColumn(binding);
        // create editor
        this._ctl = new edtClass(document.createElement('div'), options);
        // connect grid events
        flex.beginningEdit.addHandler(this._beginningEdit, this);
        flex.sortingColumn.addHandler(function () {
            _this._commitRowEdits();
        });
        flex.scrollPositionChanged.addHandler(function () {
            if (_this._ctl.containsFocus()) {
                flex.focus();
            }
        });
        flex.selectionChanging.addHandler(function (s, e) {
            if (e.row != s.selection.row) {
                _this._commitRowEdits();
            }
        });
        // connect editor events
        this._ctl.addEventListener(this._ctl.hostElement, 'keydown', function (e) {
            switch (e.keyCode) {
                case wijmo.Key.Tab:
                case wijmo.Key.Enter:
                    e.preventDefault(); // TFS 255685
                    _this._closeEditor(true);
                    _this._grid.focus();
                    // forward event to the grid so it will move the selection
                    var evt = document.createEvent('HTMLEvents');
                    evt.initEvent('keydown', true, true);
                    'altKey,metaKey,ctrlKey,shiftKey,keyCode'.split(',').forEach(function (prop) {
                        evt[prop] = e[prop];
                    });
                    _this._grid.hostElement.dispatchEvent(evt);
                    break;
                case wijmo.Key.Escape:
                    _this._closeEditor(false);
                    _this._grid.focus();
                    break;
            }
        });
        // close the editor when it loses focus
        this._ctl.lostFocus.addHandler(function () {
            setTimeout(function () {
                if (!_this._ctl.containsFocus()) {
                    _this._closeEditor(true); // apply edits and close editor
                    _this._grid.onLostFocus(); // commit item edits if the grid lost focus
                }
            });
        });
        // commit edits when grid loses focus
        this._grid.lostFocus.addHandler(function () {
            setTimeout(function () {
                if (!_this._grid.containsFocus() && !CustomGridEditor._isEditing) {
                    _this._commitRowEdits();
                }
            });
        });
        // open drop-down on f4/alt-down
        this._grid.addEventListener(this._grid.hostElement, 'keydown', function (e) {
            // open drop-down on f4/alt-down
            _this._openDropDown = false;
            if (e.keyCode == wijmo.Key.F4 ||
                (e.altKey && (e.keyCode == wijmo.Key.Down || e.keyCode == wijmo.Key.Up))) {
                var colIndex = _this._grid.selection.col;
                if (colIndex > -1 && _this._grid.columns[colIndex] == _this._col) {
                    _this._openDropDown = true;
                    _this._grid.startEditing(true);
                    e.preventDefault();
                }
            }
            // commit edits on Enter (in case we're at the last row, TFS 268944)
            if (e.keyCode == wijmo.Key.Enter) {
                _this._commitRowEdits();
            }
        }, true);
        // close editor when user resizes the window
        // REVIEW: hides editor when soft keyboard pops up (TFS 326875)
        window.addEventListener('resize', function () {
            if (_this._ctl.containsFocus()) {
                _this._closeEditor(true);
                _this._grid.focus();
            }
        });
    }
    Object.defineProperty(CustomGridEditor.prototype, "control", {
        // gets an instance of the control being hosted by this grid editor
        get: function () {
            return this._ctl;
        },
        enumerable: true,
        configurable: true
    });
    // handle the grid's beginningEdit event by canceling the built-in editor,
    // initializing the custom editor and giving it the focus.
    CustomGridEditor.prototype._beginningEdit = function (grid, args) {
        var _this = this;
        // check that this is our column
        if (grid.columns[args.col] != this._col) {
            return;
        }
        // check that this is not the Delete key
        // (which is used to clear cells and should not be messed with)
        var evt = args.data;
        if (evt && evt.keyCode == wijmo.Key.Delete) {
            return;
        }
        // cancel built-in editor
        args.cancel = true;
        // save cell being edited
        this._rng = args.range;
        CustomGridEditor._isEditing = true;
        // initialize editor host
        var rcCell = grid.getCellBoundingRect(args.row, args.col), rcBody = document.body.getBoundingClientRect(), ptOffset = new wijmo.Point(-rcBody.left, -rcBody.top), zIndex = (args.row < grid.frozenRows || args.col < grid.frozenColumns) ? '3' : '';
        wijmo.setCss(this._ctl.hostElement, {
            position: 'absolute',
            left: rcCell.left - 1 + ptOffset.x + 10,
            top: rcCell.top - 1 + ptOffset.y + 20,
            width: rcCell.width + 1,
            height: grid.rows[args.row].renderHeight + 1,
            borderRadius: '0px',
            zIndex: zIndex,
        });
        // initialize editor content
        if (!wijmo.isUndefined(this._ctl['text'])) {
            this._ctl['text'] = grid.getCellData(this._rng.row, this._rng.col, true);
        }
        else {
            throw 'Can\'t set editor value/text...';
        }
        // start editing item
        var ecv = grid.editableCollectionView, item = grid.rows[args.row].dataItem;
        if (ecv && item && item != ecv.currentEditItem) {
            setTimeout(function () {
                grid.onRowEditStarting(args);
                ecv.editItem(item);
                grid.onRowEditStarted(args);
            }, 50); // wait for the grid to commit edits after losing focus
        }
        // activate editor
        document.body.appendChild(this._ctl.hostElement);
        this._ctl.focus();
        setTimeout(function () {
            // get the key that triggered the editor
            var key = (evt && evt.charCode > 32)
                ? String.fromCharCode(evt.charCode)
                : null;
            // get input element in the control
            var input = _this._ctl.hostElement.querySelector('input');
            // send key to editor
            if (input) {
                if (key) {
                    input.value = key;
                    wijmo.setSelectionRange(input, key.length, key.length);
                    var evtInput = document.createEvent('HTMLEvents');
                    evtInput.initEvent('input', true, false);
                    input.dispatchEvent(evtInput);
                }
                else {
                    input.select();
                }
            }
            // give the control focus
            if (!input && !_this._openDropDown) {
                _this._ctl.focus();
            }
            // open drop-down on F4/alt-down
            if (_this._openDropDown && _this._ctl instanceof wijmo.input.DropDown) {
                _this._ctl.isDroppedDown = true;
                _this._ctl.dropDown.focus();
            }
        }, 50);
    };
    // close the custom editor, optionally saving the edits back to the grid
    CustomGridEditor.prototype._closeEditor = function (saveEdits) {
        if (this._rng) {
            var grid = this._grid, ctl = this._ctl, host = ctl.hostElement;
            // raise grid's cellEditEnding event
            var e = new wijmo.grid.CellEditEndingEventArgs(grid.cells, this._rng);
            grid.onCellEditEnding(e);
            // save editor value into grid
            if (saveEdits) {
                if (!wijmo.isUndefined(ctl['value'])) {
                    this._grid.setCellData(this._rng.row, this._rng.col, ctl['value']);
                }
                else if (!wijmo.isUndefined(ctl['text'])) {
                    this._grid.setCellData(this._rng.row, this._rng.col, ctl['text']);
                }
                else {
                    throw 'Can\'t get editor value/text...';
                }
                this._grid.invalidate();
            }
            // close editor and remove it from the DOM
            if (ctl instanceof wijmo.input.DropDown) {
                ctl.isDroppedDown = false;
            }
            host.parentElement.removeChild(host);
            this._rng = null;
            CustomGridEditor._isEditing = false;
            // raise grid's cellEditEnded event
            grid.onCellEditEnded(e);
        }
    };
    // commit row edits, fire events (TFS 339615)
    CustomGridEditor.prototype._commitRowEdits = function () {
        var grid = this._grid, ecv = grid.editableCollectionView;
        this._closeEditor(true);
        if (ecv && ecv.currentEditItem) {
            var e = new wijmo.grid.CellEditEndingEventArgs(grid.cells, grid.selection);
            ecv.commitEdit();
            window.setTimeout("grid.onRowEditEnding(e); grid.onRowEditEnded(e); grid.invalidate(); ", 100);
        }
    };
    return CustomGridEditor;
}());