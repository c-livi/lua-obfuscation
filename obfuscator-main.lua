local obfs={}

function obfs.changeVariableNames(s)
	if type(s)~='string' then return nil end;
	local _vars=0
	local function Read(str,sep)
		local t={}
        for _str in string.gmatch(str, "([^"..sep.."]+)") do
                table.insert(t, _str)
        end
		return t;
	end
	local t=Read(s,'=')
	for _i,_ in ipairs(t) do
		local _variable=t[_i]
		if _variable:match('local') then
			_variable=Read(_variable,' ')[#Read(_variable,' ')]
			if not _variable:match('%.') then
				_vars=_vars+1
				s=s:gsub(_variable,'__V_'.._vars)
			end
		end
	end
	return s;
end

function obfs.changeValueNames(s)
	
end

return obfs;
