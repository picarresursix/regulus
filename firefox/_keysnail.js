// ========================== KeySnail Init File =========================== //

// You can preserve your code in this area when generating the init file using GUI.
// Put all your code except special key, set*key, hook, blacklist.
// ========================================================================= //
//{{%PRESERVE%
// Put your codes here
//}}%PRESERVE%
// ========================================================================= //

// ========================= Special key settings ========================== //

key.quitKey              = "C-g";
key.helpKey              = "<f1>";
key.escapeKey            = "M-g";
key.macroStartKey        = "<f3>";
key.macroEndKey          = "<f4>";
key.universalArgumentKey = "C-u";
key.negativeArgument1Key = "C--";
key.negativeArgument2Key = "C-M--";
key.negativeArgument3Key = "M--";
key.suspendKey           = "<f2>";

// ================================= Hooks ================================= //


hook.setHook('KeyBoardQuit', function (aEvent) {
    if (key.currentKeySequence.length) return;

    command.closeFindBar();

    let marked = command.marked(aEvent);

    if (util.isCaretEnabled()) {
        if (marked) {
            command.resetMark(aEvent);
        } else {
            if ("blur" in aEvent.target) aEvent.target.blur();

            gBrowser.focus();
            _content.focus();
        }
    } else {
        goDoCommand("cmd_selectNone");
    }

    if (KeySnail.windowType === "navigator:browser" && !marked) {
        key.generateKey(aEvent.originalTarget, KeyEvent.DOM_VK_ESCAPE, true);
    }
});


// ============================= Key bindings ============================== //

key.setGlobalKey('C-M-r', function (ev) {
                userscript.reload();
            }, 'Reload the initialization file', true);

key.setGlobalKey('M-a', function (ev, arg) {
                ext.select(arg, ev);
            }, 'List exts and execute selected one', true);

key.setGlobalKey('M-:', function (ev) {
                command.iSearchBackwardKs(ev);
            }, 'Emacs like incremental search backward', true);

key.setGlobalKey(['<f1>', 'b'], function (ev) {
                key.listKeyBindings();
            }, 'List all keybindings');

key.setGlobalKey(['<f1>', 'F'], function (ev) {
                openHelpLink("firefox-help");
            }, 'Display Firefox help');

key.setGlobalKey('C-m', function (ev) {
                key.generateKey(ev.originalTarget, KeyEvent.DOM_VK_RETURN, true);
            }, 'Generate the return key code');

key.setGlobalKey('M-s', function (ev) {
                command.focusToById("urlbar");
            }, 'Focus to the location bar', true);

key.setGlobalKey(['C-x', 't'], function (ev) {
                command.focusElement(command.elementsRetrieverTextarea, 0);
            }, 'Focus to the first textarea', true);

key.setGlobalKey(['C-x', 's'], function (ev) {
                command.focusElement(command.elementsRetrieverButton, 0);
            }, 'Focus to the first button', true);

key.setGlobalKey(['C-x', '2'], function (ev) {
                closeWindow(true);
            }, 'Close the window');

key.setGlobalKey(['C-x', '3'], function (ev) {
                OpenBrowserWindow();
            }, 'Open new window');

key.setGlobalKey(['C-x', 'o'], function (ev, arg) {
                command.focusOtherFrame(arg);
            }, 'Select next frame');

key.setGlobalKey(['C-x', '1'], function (ev) {
                window.loadURI(ev.target.ownerDocument.location.href);
            }, 'Show current frame only', true);

key.setGlobalKey('C-w', function (ev) {
                BrowserCloseTabOrWindow();
            }, 'Close tab / window');

key.setGlobalKey('C-f', function (ev) {
                BrowserOpenFileWindow();
            }, 'Open the local file', true);

key.setGlobalKey('C-s', function (ev) {
                saveDocument(window.content.document);
            }, 'Save current page to the file', true);

key.setGlobalKey('C-q', function (ev) {
                goQuitApplication();
            }, 'Exit Firefox', true);

key.setGlobalKey('M-c', function (ev) {
                command.copyRegion(ev);
            }, 'Copy selected text', true);

key.setGlobalKey('M-;', function (ev) {
                command.iSearchForwardKs(ev);
            }, 'Emacs like incremental search forward', true);

key.setGlobalKey('C-T', function (ev) {
                undoCloseTab();
            }, 'Undo closed tab');

key.setGlobalKey(['C-c', 'C-c', 'C-v'], function (ev) {
                toJavaScriptConsole();
            }, 'Display JavaScript console', true);

key.setGlobalKey(['C-c', 'C-c', 'C-c'], function (ev) {
                command.clearConsole();
            }, 'Clear Javascript console', true);

key.setGlobalKey('C-<next>', function (ev) {
                getBrowser().mTabContainer.advanceSelectedTab(1, true);
            }, 'Select next tab');

key.setGlobalKey('C-<prior>', function (ev) {
                getBrowser().mTabContainer.advanceSelectedTab(-1, true);
            }, 'Select previous tab');

key.setGlobalKey('C-<up>', function (ev) {
    FullZoom.enlarge();
}, 'Enlarge text size');

key.setGlobalKey('C-<down>', function (ev) {
    FullZoom.reduce();
}, 'Reduce text size');

key.setGlobalKey('C-0', function (ev) {
    FullZoom.reset();
}, 'Reset text size');

key.setViewKey('n', function (ev) {
    getBrowser().mTabContainer.advanceSelectedTab(1, true);
}, 'Select next tab');

key.setViewKey('p', function (ev) {
    getBrowser().mTabContainer.advanceSelectedTab(-1, true);
}, 'Select previous tab');

key.setViewKey([['M-k'], ['k']], function (ev) {
                key.generateKey(ev.originalTarget, KeyEvent.DOM_VK_DOWN, true);
            }, 'Scroll line down');

key.setViewKey([['M-i'], ['i']], function (ev) {
                key.generateKey(ev.originalTarget, KeyEvent.DOM_VK_UP, true);
            }, 'Scroll line up');

key.setViewKey('M-m', function (ev) {
                getBrowser().mTabContainer.advanceSelectedTab(1, true);
            }, 'Select next tab');

key.setViewKey('<right>', function (ev) {
                key.generateKey(ev.originalTarget, KeyEvent.DOM_VK_RIGHT, true);
            }, 'Scroll right');

key.setViewKey([['M-j'], ['<left>']], function (ev) {
                key.generateKey(ev.originalTarget, KeyEvent.DOM_VK_LEFT, true);
            }, 'Scroll left');

key.setViewKey([['M-u'], ['u']], function (ev) {
                goDoCommand("cmd_scrollPageUp");
            }, 'Scroll page up');

key.setViewKey('M-o', function (ev) {
                goDoCommand("cmd_scrollPageDown");
            }, 'Scroll page down');

key.setViewKey('M-J', function (ev) {
                goDoCommand("cmd_scrollTop");
            }, 'Scroll to the top of the page', true);

key.setViewKey('M-L', function (ev) {
                goDoCommand("cmd_scrollBottom");
            }, 'Scroll to the bottom of the page', true);

key.setViewKey(':', function (ev, arg) {
                shell.input(null, arg);
            }, 'List and execute commands', true);

key.setViewKey('b', function (ev) {
                BrowserBack();
            }, 'Back');

key.setViewKey('f', function (ev) {
                command.focusElement(command.elementsRetrieverTextarea, 0);
            }, 'Focus to the first textarea', true);

key.setViewKey('C-a', function (ev) {
                goDoCommand("cmd_selectAll");
            }, 'Select all', true);

key.setViewKey('M-n', function (ev) {
                command.walkInputElement(command.elementsRetrieverButton, true, true);
            }, 'Focus to the next button');

key.setViewKey('M-p', function (ev) {
                command.walkInputElement(command.elementsRetrieverButton, false, true);
            }, 'Focus to the previous button');

key.setViewKey('o', function (ev) {
    goDoCommand("cmd_scrollPageDown");
}, 'Scroll page down');

key.setEditKey('C-a', function (ev) {
                command.selectAll(ev);
            }, 'Select whole text', true);

key.setEditKey([['M-z'], ['C-_']], function (ev) {
                display.echoStatusBar("Undo!", 2000);
                goDoCommand("cmd_undo");
            }, 'Undo');

key.setEditKey(['C-x', 'r', 'd'], function (ev, arg) {
                command.replaceRectangle(ev.originalTarget, "", false, !arg);
            }, 'Delete text in the region-rectangle', true);

key.setEditKey(['C-x', 'r', 'i'], function (ev) {
                prompt.read("String rectangle: ", function (aStr, aInput) {
                                command.replaceRectangle(aInput, aStr);
                            },
                            ev.originalTarget);
            }, 'Replace text in the region-rectangle with user inputted string', true);

key.setEditKey(['C-x', 'r', 'o'], function (ev) {
                command.openRectangle(ev.originalTarget);
            }, 'Blank out the region-rectangle, shifting text right', true);

key.setEditKey(['C-x', 'r', 'x'], function (ev, arg) {
                command.kill.buffer = command.killRectangle(ev.originalTarget, !arg);
            }, 'Delete the region-rectangle and save it as the last killed one', true);

key.setEditKey(['C-x', 'r', 'v'], function (ev) {
                command.yankRectangle(ev.originalTarget, command.kill.buffer);
            }, 'Yank the last killed rectangle with upper left corner at point', true);

key.setEditKey([['C-SPC'], ['C-@']], function (ev) {
                command.setMark(ev);
            }, 'Set the mark', true);

key.setEditKey('C-o', function (ev) {
                command.openLine(ev);
            }, 'Open line');

key.setEditKey('C-\\', function (ev) {
                display.echoStatusBar("Redo!", 2000);
                goDoCommand("cmd_redo");
            }, 'Redo');

key.setEditKey('M-h', function (ev) {
                command.beginLine(ev);
            }, 'Beginning of the line');

key.setEditKey('M-m', function (ev) {
                command.endLine(ev);
            }, 'End of the line');

key.setEditKey('M-l', function (ev) {
                command.nextChar(ev);
            }, 'Forward char');

key.setEditKey('M-j', function (ev) {
                command.previousChar(ev);
            }, 'Backward char');

key.setEditKey('M-o', function (ev) {
                command.forwardWord(ev);
            }, 'Next word');

key.setEditKey('M-u', function (ev) {
                command.backwardWord(ev);
            }, 'Previous word');

key.setEditKey('M-k', function (ev) {
                command.nextLine(ev);
            }, 'Next line');

key.setEditKey('M-i', function (ev) {
                command.previousLine(ev);
            }, 'Previous line');

key.setEditKey('M-O', function (ev) {
                command.pageDown(ev);
            }, 'Page down');

key.setEditKey('M-U', function (ev) {
                command.pageUp(ev);
            }, 'Page up');

key.setEditKey('M-J', function (ev) {
                command.moveTop(ev);
            }, 'Beginning of the text area');

key.setEditKey('M-L', function (ev) {
                command.moveBottom(ev);
            }, 'End of the text area');

key.setEditKey('M-f', function (ev) {
                goDoCommand("cmd_deleteCharForward");
            }, 'Delete forward char');

key.setEditKey('M-d', function (ev) {
                command.deleteForwardWord(ev);
            }, 'Delete forward word');

key.setEditKey([['M-e'], ['M-<delete>']], function (ev) {
                command.deleteBackwardWord(ev);
            }, 'Delete backward word');

key.setEditKey('C-k', function (ev) {
                command.killLine(ev);
            }, 'Kill the rest of the line');

key.setEditKey('M-v', command.yank, 'Paste (Yank)');

key.setEditKey('M-V', command.yankPop, 'Paste pop (Yank pop)', true);

key.setEditKey('C-M-y', function (ev) {
                if (!command.kill.ring.length)
                    return;

                let (ct = command.getClipboardText())
                    (!command.kill.ring.length || ct != command.kill.ring[0]) && command.pushKillRing(ct);

                prompt.selector(
                    {
                        message: "Paste:",
                        collection: command.kill.ring,
                        callback: function (i) { if (i >= 0) key.insertText(command.kill.ring[i]); }
                    }
                );
            }, 'Show kill-ring and select text to paste', true);

key.setEditKey('M-x', function (ev) {
                goDoCommand("cmd_copy");
                goDoCommand("cmd_delete");
                command.resetMark(ev);
            }, 'Cut current region', true);

key.setEditKey('M-n', function (ev) {
                command.walkInputElement(command.elementsRetrieverTextarea, true, true);
            }, 'Focus to the next text area');

key.setEditKey('M-p', function (ev) {
                command.walkInputElement(command.elementsRetrieverTextarea, false, true);
            }, 'Focus to the previous text area');

key.setCaretKey([['M-j'], ['h'], ['C-h']], function (ev) {
                ev.target.ksMarked ? goDoCommand("cmd_selectCharPrevious") : goDoCommand("cmd_scrollLeft");
            }, 'Move caret to the left');

key.setCaretKey('^', function (ev) {
                ev.target.ksMarked ? goDoCommand("cmd_selectBeginLine") : goDoCommand("cmd_beginLine");
            }, 'Move caret to the beginning of the line');

key.setCaretKey([['M-m'], ['$'], ['M->'], ['G']], function (ev) {
                ev.target.ksMarked ? goDoCommand("cmd_selectEndLine") : goDoCommand("cmd_endLine");
            }, 'Move caret to the end of the line');

key.setCaretKey([['M-k'], ['j']], function (ev) {
                ev.target.ksMarked ? goDoCommand("cmd_selectLineNext") : goDoCommand("cmd_scrollLineDown");
            }, 'Move caret to the next line');

key.setCaretKey([['M-i'], ['k']], function (ev) {
                ev.target.ksMarked ? goDoCommand("cmd_selectLinePrevious") : goDoCommand("cmd_scrollLineUp");
            }, 'Move caret to the previous line');

key.setCaretKey([['M-l'], ['l']], function (ev) {
                ev.target.ksMarked ? goDoCommand("cmd_selectCharNext") : goDoCommand("cmd_scrollRight");
            }, 'Move caret to the right');

key.setCaretKey([['M-o'], ['w']], function (ev) {
                ev.target.ksMarked ? goDoCommand("cmd_selectWordNext") : goDoCommand("cmd_wordNext");
            }, 'Move caret to the right by word');

key.setCaretKey([['M-u'], ['W']], function (ev) {
                ev.target.ksMarked ? goDoCommand("cmd_selectWordPrevious") : goDoCommand("cmd_wordPrevious");
            }, 'Move caret to the left by word');

key.setCaretKey([['M-O'], ['SPC']], function (ev) {
                ev.target.ksMarked ? goDoCommand("cmd_selectPageNext") : goDoCommand("cmd_movePageDown");
            }, 'Move caret down by page');

key.setCaretKey([['M-U'], ['b']], function (ev) {
                ev.target.ksMarked ? goDoCommand("cmd_selectPagePrevious") : goDoCommand("cmd_movePageUp");
            }, 'Move caret up by page');

key.setCaretKey([['M-J'], ['g']], function (ev) {
                ev.target.ksMarked ? goDoCommand("cmd_selectTop") : goDoCommand("cmd_scrollTop");
            }, 'Move caret to the top of the page');

key.setCaretKey('J', function (ev) {
                util.getSelectionController().scrollLine(true);
            }, 'Scroll line down');

key.setCaretKey('K', function (ev) {
                util.getSelectionController().scrollLine(false);
            }, 'Scroll line up');

key.setCaretKey(',', function (ev) {
                util.getSelectionController().scrollHorizontal(true);
                goDoCommand("cmd_scrollLeft");
            }, 'Scroll left');

key.setCaretKey('.', function (ev) {
                goDoCommand("cmd_scrollRight");
                    util.getSelectionController().scrollHorizontal(false);
            }, 'Scroll right');

key.setCaretKey('z', function (ev) {
                command.recenter(ev);
            }, 'Scroll to the cursor position');

key.setCaretKey([['C-SPC'], ['C-@']], function (ev) {
                command.setMark(ev);
            }, 'Set the mark', true);

key.setCaretKey(':', function (ev, arg) {
                shell.input(null, arg);
            }, 'List and execute commands', true);

key.setCaretKey('R', function (ev) {
                BrowserReload();
            }, 'Reload the page', true);

key.setCaretKey('B', function (ev) {
                BrowserBack();
            }, 'Back');

key.setCaretKey('F', function (ev) {
                BrowserForward();
            }, 'Forward');

key.setCaretKey(['C-x', 'h'], function (ev) {
                goDoCommand("cmd_selectAll");
            }, 'Select all', true);

key.setCaretKey('f', function (ev) {
                command.focusElement(command.elementsRetrieverTextarea, 0);
            }, 'Focus to the first textarea', true);

key.setCaretKey('M-p', function (ev) {
                command.walkInputElement(command.elementsRetrieverButton, true, true);
            }, 'Focus to the next button');

key.setCaretKey('M-n', function (ev) {
                command.walkInputElement(command.elementsRetrieverButton, false, true);
            }, 'Focus to the previous button');
