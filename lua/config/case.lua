local M = {}

-- A segment is a run of non-space, non-hyphen: "foo-bar" is two words, "baz's"
-- is one. Leading punctuation is skipped so "## heading" and "**bold**" reach
-- the letter rather than the marker.
local function case_token(tok, upper)
    local i = tok:find('%a')
    if not i then
        return tok
    end
    local c = tok:sub(i, i)
    return tok:sub(1, i - 1) .. (upper and c:upper() or c:lower()) .. tok:sub(i + 1)
end

local function case_words(s, upper)
    return (s:gsub('[^%s-]+', function(tok)
        return case_token(tok, upper)
    end))
end

-- direction comes from the first letter in the region, so the key round-trips
local function wants_upper(s)
    local c = s:match('%a')
    return c == nil or c:match('%l') ~= nil
end

function M.word()
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    local line = vim.api.nvim_get_current_line()
    for st, tok in line:gmatch('()([^%s-]+)') do
        if col + 1 >= st and col + 1 <= st + #tok - 1 then
            vim.api.nvim_set_current_line(
                line:sub(1, st - 1) .. case_token(tok, wants_upper(tok)) .. line:sub(st + #tok))
            vim.api.nvim_win_set_cursor(0, { row, col })
            return
        end
    end
end

function M.selection()
    local sp, ep = vim.fn.getpos("'<"), vim.fn.getpos("'>")
    local charwise = vim.fn.visualmode() == 'v'
    local first, last = sp[2], ep[2]
    local lines = vim.api.nvim_buf_get_lines(0, first - 1, last, false)

    local function bounds(i, line)
        local s = (charwise and i == 1) and sp[3] or 1
        local e = (charwise and i == #lines) and math.min(ep[3], #line) or #line
        return s, e
    end

    local region = {}
    for i, line in ipairs(lines) do
        local s, e = bounds(i, line)
        region[#region + 1] = line:sub(s, e)
    end
    local upper = wants_upper(table.concat(region, ' '))

    for i, line in ipairs(lines) do
        local s, e = bounds(i, line)
        lines[i] = line:sub(1, s - 1) .. case_words(line:sub(s, e), upper) .. line:sub(e + 1)
    end
    vim.api.nvim_buf_set_lines(0, first - 1, last, false, lines)
end

return M
