
local obfs={}

local function Read(str,sep)
	if sep == nil then
      		sep = "%s"
   	end
   	local t={}
   	for _str in string.gmatch(str, "([^"..sep.."]+)") do
      		table.insert(t, _str)
   	end
   	return t;
end

local function Rdm(len)
	local _s = ""
	for i = 1, len do
		_a=string.char(math.random(97, 122))
		if math.random(2)==1 then _a=_a:upper() end
		_s = _s .. _a
	end
	return _s;
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
	if type(s)~='string' then return nil end;
	local _vars=0
	local t=Read(s,'=')
	for _i,_ in ipairs(t) do
		local _variable=t[_i]
		if _variable:match('local') then
			_variable=Read(_variable,' ')[#Read(_variable,' ')]
			if not _variable:match('%.') then
				_vars=_vars+1
				s=s:gsub(_variable,Rdm(5).._vars)
			end
		end
	end
	return s;
end

function obfs.obfuscateFunctions(s)
	return string.gsub(s, "function", Rdm(30));
end

function obfs.obfuscateControlFlow(s)
  	local lines = split(s, "\n")
  	shuffle(lines)
  	local obfuscated_script = table.concat(lines, "\n")
  	return obfuscated_script;
end

return obfs;
