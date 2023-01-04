local obfs = {}

local function Read(str, sep)
  if sep == nil then
    sep = "%s"
  end
  local t = {}
  for _str in string.gmatch(str, "([^"..sep.."]+)") do
    table.insert(t, _str)
  end
  return t
end

local function Rdm(len)
  local _s = ""
  for i = 1, len do
    _a = string.char(math.random(97, 122))
    if math.random(2) == 1 then _a = _a:upper() end
    _s = _s .. _a
  end
  return _s
end

local function split(str, delimiter)
  local result = {}
  for line in string.gmatch(str, "[^"..delimiter.."]+") do
    table.insert(result, line)
  end
  return result
end

local function shuffle(array)
  for i = #array, 2, -1 do
    local j = math.random(i)
    array[i], array[j] = array[j], array[i]
  end
end

function obfs.obfuscateVariableNames(s)
  local lines = split(script, "\n")

  for i, line in ipairs(lines) do
    line = string.gsub(line, "%b()", function(match)
      local tokens = split(match, " ")
      for j, token in ipairs(tokens) do
        if token ~= "local" and token ~= "function" and not tonumber(token) then
          tokens[j] = generate_random_string()
        end
      end
      return table.concat(tokens, " ")
    end)
    lines[i] = line
  end
  local obfuscated_script = table.concat(lines, "\n")
  return obfuscated_script
end

function obfs.obfuscateFunctions(s)
  return string.gsub(s, "function", Rdm(30))
end

function obfs.obfuscateControlFlow(s)
  local lines = split(s, "\n")
  shuffle(lines)
  local obfuscated_script = table.concat(lines, "\n")
  return obfuscated_script
end

return obfs
