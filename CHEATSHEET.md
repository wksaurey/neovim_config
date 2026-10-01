# LSP cheatsheet

Keys for the built-in LSP client. These are Neovim defaults, not custom mappings, so they work in any 0.11+ install. Verified against this config on 2026-09-09 with jdtls attached.

## The five you need

| Key | Does | Notes |
|---|---|---|
| `]d` / `[d` | Next / previous diagnostic | The main loop: jump, read, fix |
| `K` | Hover: type, signature, javadoc | Cursor on any symbol |
| `<C-]>` | Jump to definition | `<C-t>` jumps back |
| `gra` | Code action (quick fix) | Works in visual mode too |
| `grn` | Rename symbol everywhere | Project-wide, not a search-replace |

Everything else is optional. Diagnostics and the completion popup both appear on their own as you type; you do not have to run anything. In the popup: `<Tab>` to pick, `<C-y>` to accept, `<C-e>` to dismiss.

## Worth knowing

| Key | Does |
|---|---|
| `grr` | Find all references, into the quickfix list |
| `gri` | Go to implementation |
| `grt` | Go to type definition |
| `gO` | Document symbols: an outline of the file |
| `grx` | Run the code lens on this line |
| `[D` / `]D` | First / last diagnostic in the buffer |
| `<C-w>d` | Float the diagnostic under the cursor, without moving. Press both keys inside one second, or it becomes vim's old `:dsplit` and errors `E388: Couldn't find definition` |
| `<C-S>` | Insert mode: what does this call want from me. Needs `signatureHelp.enabled` in `lsp/jdtls.lua`, which is on |
| `<Esc>` | Dismiss any float (hover, signature, diagnostic). A local mapping, not a default — see Gotchas |
| `<Tab>` / `<S-Tab>` | Move down / up the completion popup. A literal Tab when no popup is open |
| `<C-y>` | Accept the selected completion, which also inserts its `import` line |
| `<C-e>` | Dismiss the popup and keep what you typed |
| `<C-x><C-o>` | Ask for completion explicitly, if the popup did not open |
| `gq` | Format a motion or selection through the LSP |
| `<leader>f` | Format the whole buffer via google-java-format |

`:lua vim.diagnostic.setqflist()` collects every diagnostic in the buffer into the quickfix list, then `:cnext` / `:cprev` walks them. Useful for a final sweep before submitting an assignment.

## How to remember them

**`gr` is the LSP prefix, and the third key is the first letter of the thing.** That single rule covers most of the list.

- `grn`: **n**ame → rename
- `gra`: **a**ction → code action
- `grr`: **r**eferences
- `gri`: **i**mplementation
- `grt`: **t**ype definition
- `grx`: e**x**ecute → run code lens

The rest hook onto conventions vim already had, which is why they are not under `gr`:

- `K` was always "look up the keyword under the cursor" (it used to open the man page). LSP hover replaced the man page, same key, same idea.
- `gO` shows an **O**utline. This is not new either: `gO` shows a table of contents in `:help` buffers, and document symbols is the same gesture for code.
- `<C-]>` and `<C-t>` are the ctags pair from 1990s vim: jump to tag, pop the tag stack. Neovim points `tagfunc` at the LSP, so the old keys now use real type information. `t` for **t**ag.
- `]d` / `[d` belong to the `]`/`[` next-previous family, alongside `]c` for changes and `]q` for quickfix. `d` for **d**iagnostic, and the capital `]D` / `[D` jumps to the extreme rather than the neighbour, which is the family-wide convention.
- `<C-w>` has always been the window prefix, so `<C-w>d` is "a window showing the **d**iagnostic".
- `<C-x>` opens insert-mode completion submodes; `<C-o>` picks the **o**mni one.
- Insert-mode `<C-`letter`>` is the help-me-while-typing family you already use — `<C-w>` rubs out a word, `<C-r>` pastes a register, `<C-n>` completes. `<C-s>` is **s**ignature, and it is insert-only because a signature is only ever a mid-call question.

## Commands

| Command | Does |
|---|---|
| `:checkhealth vim.lsp` | Attached clients, root directory, path to the server log |
| `:Lazy` | Plugin status |
| `:ConformInfo` | Which formatter will run, and why one will not |

`:LspInfo` and `:LspRestart` do **not** exist here. Those ship with nvim-lspconfig, which this config deliberately does not use. `:checkhealth vim.lsp` is the equivalent.

## Outside nvim

```
checkstyle -c /google_checks.xml Foo.java     style check against the CS-3100 standard
google-java-format --replace Foo.java         reformat in place
```

Both are shims in `~/.local/bin` that pin the tool to `~/tools/jdk-21`. Worth running checkstyle by hand before zipping an assignment.

## Gotchas

- **There is no `gd`.** Core never bound it; `<C-]>` is the definition jump. Add `grd` if your fingers insist.
- **First open of a Java file is slow.** jdtls indexes the project before diagnostics appear. Subsequent files in the same project are fast.
- **jdtls needs Java 21 to run** but compiles your code against 17, which is what `javac` on your PATH is. `JAVA_HOME` stays on 17 for the grid24 Android build; the server gets JDK 21 explicitly via `--java-executable` in `lsp/jdtls.lua`.
- **google-java-format will not add braces** to a braceless `if`. It collapses the statement onto one line instead. The Google style guide requires the braces, so that one is a manual fix.
- **Organize imports and Add all missing imports DO work** through `gra` -- both are standard code-action kinds, not jdtls extensions. Measured: each one inserted the real `import` line. Extract-method is the extension that needs nvim-jdtls.
- **Accepting an omni-completion adds the import for you.** jdtls returns the `import` line as an additional edit on the item, and nvim applies it when you press `<C-y>`.
- **Floats do not close on `q` or `<Esc>` by default.** They are unfocused previews wired to vanish on cursor movement, so your keys go to the code buffer — where `q` silently starts waiting for a macro register and eats your next keystroke. `lua/config/remaps.lua` maps `<Esc>` to close any focusable float; plugin floats that map their own `<Esc>` (telescope, lazy) win over it. Pressing `K` or `<C-w>d` twice enters the float, where `q` closes it.
- **Untested: a real Gradle project.** Everything above was verified in a plain folder with a `.git` marker, which puts jdtls in single-file mode. A Gradle build makes jdtls import the project on first open, which is a different and slower path.
