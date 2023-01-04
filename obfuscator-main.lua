local obfs={}

local function Read(str,sep)
	local t={}
        for _str in string.gmatch(str, "([^"..sep.."]+)") do
                table.insert(t, _str)
        end
	return t;
end

local function Rdm(len)
	local _s = ""
	for i = 1, len do
		_s = _s .. string.char(math.random(97, 122))
	end
	return _s;
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

function obfs.obfuscateMathFunctions(s)
	if type(s)~='string' then return nil end;
	for key,_ in pairs(math) do
		local _splt=Read(s,'math.')
		local _found=false
		for _,_v in ipairs(_splt) do 
			if _v:match(s) then
				_found=true
				_splt=_v
				break
			end
		end
		if _found==true then
			_splt=Read(_splt,' ')[1]
			local _vars = Read(_splt,'(')[2]:gsub(')','')
			_vars=Read(_vars,',')
			local _args = {}
			for _,_i in ipairs(_vars) do
				table.insert(_args,tonumber(_i))
			end
			local answer = math[_splt](unpack(_args))
			local new = '(function()return'..answer..';end)'
			s=s:gsub(_splt,new)
		end
	end
	return s;
end

return obfs;
