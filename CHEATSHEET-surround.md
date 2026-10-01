# surround cheatsheet

Keys for nvim-surround in this config. Plugin defaults plus four aliases and one custom surround of yours. Every row below was measured against a live nvim on 2026-09-14, not copied from the README.

## The five you need

| Key | Does | Example |
|---|---|---|
| `ysiw)` | Surround the word under the cursor | `hello` → `(hello)` |
| `yss)` | Surround the whole line | `hello world` → `(hello world)` |
| `S` | Surround the visual selection | select, then `S` then the char. With `V` this already puts delimiters on their own lines |
| `ds"` | Delete the surrounding `"` | `"hello"` → `hello` |
| `cs"'` | Change `"` to `'` | `"hello"` → `'hello'` |

The pattern is `ys` + a motion + a character. `ds` and `cs` need no motion — they find the enclosing pair themselves, from anywhere inside it.

## The character you type at the end

| Type | Get | Note |
|---|---|---|
| `)` `}` `]` `>` | `(hello)` | Closing bracket: tight, no padding |
| `(` `{` `[` `<` | `( hello )` | Opening bracket: adds a space inside |
| `"` `'` `` ` `` | `"hello"` | |
| `t` | `<div>hello</div>` | Prompts for the tag |
| `T` | Same, but `cs` keeps the attributes | |
| `f` | `print(hello)` | Prompts for the function name |
| `C` | ```` ```lua … ``` ```` | Yours. Fenced code block, prompts for the language |

## Your aliases

| Key | Same as | Gives |
|---|---|---|
| `p` | `)` | `(hello)` |
| `c` | `}` | `{hello}` |
| `s` | `]` | `[hello]` |
| `u` | — | `__hello__` |
| `q` | any quote | `ds q` deletes whichever quote encloses you |
| `b` `B` `r` `a` | `)` `}` `]` `>` | Plugin defaults, same as the tight forms |

## Every mapping, in full

| Key | Mode | Does |
|---|---|---|
| `ys<motion><char>` | normal | Surround the motion |
| `yss<char>` | normal | Surround the line |
| `yS<motion><char>` | normal | Surround the motion, delimiters on their own lines |
| `ySS<char>` | normal | Surround the line, delimiters on their own lines |
| `ds<char>` | normal | Delete the surrounding pair |
| `cs<char><char>` | normal | Change the surrounding pair |
| `cS<char><char>` | normal | Change it, delimiters onto their own lines |
| `S<char>` | visual | Surround the selection |
| `gS<char>` | visual | Surround it, delimiters on their own lines |
| `<C-g>s<char>` | insert | Surround, then keep typing inside |
| `<C-g>S<char>` | insert | Same, delimiters on their own lines |

## Fenced code blocks

`V` to select the lines, then `SC`, then the language and Enter. Enter alone gives a bare fence. `dsC` from inside removes it.

**`gSC` also works but the `g` is redundant here.** A linewise selection already forces the delimiters onto their own lines, so from `V` the two are byte-identical — measured. The `g` only earns its place on a charwise `v` selection, where plain `S` hugs the text and `gS` breaks the delimiters out.

It has to be `V`. Charwise `v` opens the fence mid-line, and real visual block `<C-v>` applies the surround to each block segment and shreds the text.

From normal mode with no visual step: `yS2jC` wraps this line and the next two — `yS`, capital, because there is no linewise selection to force the line break.

## How to remember them

**`ys` is "**y**ou **s**urround", and it takes a motion exactly like `d` or `c` does.** `yiw` yanks a word, `ysiw)` surrounds one. Doubling the last letter means "the whole line", the same convention as `dd` and `yy` — hence `yss`.

- `ds` = **d**elete **s**urround, `cs` = **c**hange **s**urround.
- A **capital** S anywhere in the mapping means "put the delimiters on their own lines". `yS`, `cS`, `gS` all follow it — but it is only *needed* where the selection is not already linewise. From `V`, plain `S` does the same thing.
- **The `g` in `gS` has no documented rationale.** It is inherited from tpope's vim-surround, whose help file states the mapping exists and never says why. What can be established: `g` is vim's own namespace for variants of an existing command (`:h index.txt`, "g{char} extended commands"), and visual `S` was already spoken for twice — by vim's `v_S` and by surround's own charwise mapping — so the line variant needed a free key. `gS` is unused in stock nvim. Note the meaning also drifted: in tpope's original, `gS` *suppresses* indentation; nvim-surround kept the key and gave it the on-its-own-lines job.
- **Closing brackets are tight, opening brackets pad.** The mnemonic is that the opening bracket is the wider-looking key, and it gives you the wider result.

## Gotchas

- **`<leader>s` is leap, not surround.** The old `<leader>sa`/`<leader>sd`/`<leader>sr` set was removed in `6c7e4e6` (2026-09-03) because it shared a prefix with leap's `<leader>s` and forced a 1000 ms wait on every leap jump. There is no leader binding for surround; the defaults above are the whole set.
- **Counts do not work the way you expect.** `3ySSC` wraps each of the three lines in its own fence. Use `yS2jC` or select with `V2j` and press `gSC`.
- **`ds` and `cs` work from anywhere inside the pair**, not just on the delimiter. You never have to navigate to the bracket first.
- **`move_cursor = false` is set**, so the cursor stays put after a surround rather than jumping to the opening delimiter.
- **Bare `s` and `S` are still vim's substitute**, deliberately — freeing them was the point of moving surround back to its defaults.
