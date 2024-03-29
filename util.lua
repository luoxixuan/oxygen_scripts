function DumpTableXML(t, name)
    name = name or ""
    function dumpinternal(t, outstr, indent)
        for key, value in pairs(t) do
            if type(value) == "table" then
                table.insert(outstr,indent.."<table name='"..tostring(key).."'>\n")
                dumpinternal(value, outstr, indent.."\t")
                table.insert(outstr, indent.."</table>\n")
            else
                table.insert(outstr, indent.."<"..type(value).." name='"..tostring(key).."' val='"..tostring(value).."'/>\n")
            end
        end
    end
    outstr = {"<table name='"..name.."'>\n"}
    dumpinternal(t, outstr, "\t")
    table.insert(outstr, "</table>")
    return table.concat(outstr)
end

function DebugSpawn(prefab)
    if TheSim ~= nil and TheInput ~= nil then
        TheSim:LoadPrefabs({ prefab })
        if Prefabs[prefab] ~= nil and not Prefabs[prefab].is_skin then
			local inst = SpawnPrefab(prefab)
			if inst ~= nil then
				inst.Transform:SetPosition(ConsoleWorldPosition():Get())
				return inst
			end
		end
    end
end

function GetClosest(target, entities)
    local max_dist = nil
    local min_dist = nil

    local closest = nil

    local tpos = target:GetPosition()

    for k,v in pairs(entities) do
        local epos = v:GetPosition()
        local dist = distsq(tpos, epos)

        if not max_dist or dist > max_dist then
            max_dist = dist
        end

        if not min_dist or dist < min_dist then
            min_dist = dist
            closest = v
        end
    end

    return closest
end

function SpawnAt(prefab, loc, scale, offset)

    offset = ToVector3(offset) or Vector3(0,0,0)

    if not loc or not prefab then return end

    prefab = (prefab.GUID and prefab.prefab) or prefab

    local spawn = SpawnPrefab(prefab)
    local pos = nil

    if loc.prefab then
        pos = loc:GetPosition()
    else
        pos = loc
    end

    if spawn and pos then
        pos = pos + offset
        spawn.Transform:SetPosition(pos:Get())
        if scale then
            scale = ToVector3(scale)
            spawn.Transform:SetScale(scale:Get())
        end
        return spawn
    end
end

function string:split(sep)
    local sep, fields = sep or ":", {}
    local pattern = string.format("([^%s]+)", sep)
    self:gsub(pattern, function(c) fields[#fields+1] = c end)
    return fields
end

-- Like string.find, but returns an array of first,last pairs. Never returns
-- nil. Does not return captures -- if you want text matches, see
-- string.gmatch.
function string.findall(s, pattern, init, plain)
    local matches = {}
    local first = init or 1
    local last = first
    while first ~= nil do
        first, last = s:find(pattern, first, plain)
        if first ~= nil then
            table.insert(matches, {first,last})
            first = last + 1
        end
    end
    return matches
end

-- Like string.find, but finds the last match. init is normal index (1 is first
-- character).
function string.rfind(s, pattern, init, plain)
    local matches = s:findall(pattern, init, plain)
    if #matches > 0 then
        return table.unpack(matches[#matches])
    end
    return nil
end


-- Like string.find, but finds the last match and always does plain matches.
-- init is normal index (1 is first character).
function string.rfind_plain(s, query, init)
    local s_rev = s:reverse()
    local query_rev = query:reverse()
    local first,last = s_rev:find(query_rev, init, true)
    local len = #s
    if first then
        return len - last + 1, len - first + 1
    end
    return nil
end

function table.contains(table, element)
    if table == nil then return false end
    
    for _, value in pairs(table) do
        if value == element then
          return true
        end
    end
    return false
end

-- Why use containskey instead of table[key] ~= nil?
function table.containskey(table, key)
    if table == nil then return false end

    for k, value in pairs(table) do
        if k == key then
            return true
        end
    end
    return false
end

-- Return an array table of the keys of the input table.
function table.getkeys(t)
    local keys = {}
    for key,val in pairs(t) do
        table.insert(keys, key)
    end
    return keys
end

-- only for indexed tables!
function table.reverse(tab)
    local size = #tab
    local newTable = {}
 
    for i,v in ipairs(tab) do
        newTable[size-i+1] = v
    end
 
    return newTable
end

function table.invert(t)
    local invt = {}
    for k, v in pairs(t) do
        invt[v] = k
    end
    return invt
end

function table.removearrayvalue(t, lookup_value)
    for i, v in ipairs(t) do
        if v == lookup_value then
            table.remove(t, i)
            return v
        end
    end
end

function table.removetablevalue(t, lookup_value)
    for k, v in pairs(t) do
        if v == lookup_value then
            t[k] = nil
            return v
        end
    end
end

function table.reverselookup(t, lookup_value)
    for k, v in pairs(t) do
        if v == lookup_value then
            return k
        end
    end
    return nil
end


local function reverse_next(t, index)
    if index > 0 then
        return index - 1, t[index]
    end
end
-- Equivalent of the ipairs() function on tables, but in reverse order.
function ipairs_reverse(t)
    return reverse_next, t, #t
end

-- only use on indexed tables!
function GetFlattenedSparse(tab)
    local keys = {}
    for index,value in pairs(tab) do keys[#keys+1]=index end
    table.sort(keys)

    local ret = {}
    for _,oidx in ipairs(keys) do
        ret[#ret+1]=tab[oidx]
    end
    return ret
end

-- RemoveByValue only applies to array-type tables
-- Removes all instances of the value from the table
-- See table.removearrayvalue above
function RemoveByValue(t, value)
    if t ~= nil then
        for i = #t, 1, -1 do
            if t[i] == value then
                table.remove(t, i)
            end
        end
    end
end

-- Count the number of keys/values. Like #t for map-type tables.
function GetTableSize(table)
	local numItems = 0
	if table ~= nil then
		for k,v in pairs(table) do
		    numItems = numItems + 1
		end
	end
	return numItems
end

function GetRandomItem(choices)
    local numChoices = GetTableSize(choices)

    if numChoices < 1 then
        return
    end

 	local choice = math.random(numChoices) -1

 	local picked = nil
 	for k,v in pairs(choices) do
 		picked = v
 		if choice<= 0 then
 			break
 		end
 		choice = choice -1
 	end
 	assert(picked~=nil)
	return picked
end

function GetRandomItemWithIndex(choices)
    local choice = math.random(GetTableSize(choices)) -1
    
    local idx = nil
    local item = nil

    for k,v in pairs(choices) do
        idx = k
        item = v
        if choice<= 0 then
            break
        end
        choice = choice -1
    end
    assert(idx~=nil and item~=nil)
    return idx, item
end

-- Made to work with (And return) array-style tables
-- This function does not preserve the original table
function PickSome(num, choices)
	local l_choices = choices
	local ret = {}
	for i=1,num do
		local choice = math.random(#l_choices)
		table.insert(ret, l_choices[choice])
		table.remove(l_choices, choice)
	end
	return ret
end

function PickSomeWithDups(num, choices)
    local l_choices = choices
    local ret = {}
    for i=1,num do
        local choice = math.random(#l_choices)
        table.insert(ret, l_choices[choice])       
    end
    return ret
end

-- concatenate two array-style tables
function JoinArrays(...)
	local ret = {}
	for i,array in ipairs({...}) do
		for j,val in ipairs(array) do
			table.insert(ret, val)
		end
	end
	return ret
end

-- returns a new array with the difference between the two provided arrays
function ExceptionArrays(tSource, tException)
	local ret = {}
	ret = JoinArrays(ret, tSource)
	for i, val in ipairs(tException) do
		if table.contains(ret, val) then
			RemoveByValue(ret, val)
		end
	end
	return ret
end

-- merge two array-style tables, only allowing each value once
function ArrayUnion(...)
	local ret = {}
	for i,array in ipairs({...}) do
		for j,val in ipairs(array) do
			if not table.contains(ret, val) then
				table.insert(ret, val)
			end
		end
	end
	return ret
end

-- return only values found in all arrays
function ArrayIntersection(...)
    local arg = {n=select('#',...),...}
	local ret = {}
	for i,val in ipairs(arg[1]) do
		local good = true
		for i=2,#arg do
			if not table.contains(arg[i], val) then
				good = false
				break
			end
		end
		if good then
			table.insert(ret, val)
		end
	end
	return ret
end

-- merge two map-style tables, overwriting duplicate keys with the latter map's value
function MergeMaps(...)
	local ret = {}
	for i,map in ipairs({...}) do
		for k,v in pairs(map) do
			ret[k] = v
		end
	end
	return ret
end

-- merge two map-style tables, overwriting duplicate keys with the latter map's value
-- subtables are recursed into
function MergeMapsDeep(...)
    local keys = {}
    for i,map in ipairs({...}) do
        for k,v in pairs(map) do
            if keys[k] == nil then
                keys[k] = type(v)
            else
                assert(keys[k] == type(v), "Attempting to merge incompatible tables.")
            end
        end
    end

    local ret = {}
    for k,t in pairs(keys) do
        if t == "table" then
            local subtables = {}
            for i,map in ipairs({...}) do
                if map[k] ~= nil then
                    table.insert(subtables, map[k])
                end
            end
            ret[k] = MergeMapsDeep(unpack(subtables))
        else
            for i,map in ipairs({...}) do
                if map[k] ~= nil then
                    ret[k] = map[k]
                end
            end
        end
    end

    return ret
end

-- merges two lists of this form (used in e.g. our customization stuff)
-- {
--      { "key", "value" },
--      { "key2", "value2" },
-- }
-- overwrites duplicate "keys" with the latter list's value
function MergeKeyValueList(...)
    local ret = {}
    for i,list in ipairs({...}) do
        for i,map in ipairs(list) do
            local found = false
            for i2,savedmap in ipairs(ret) do
                if map[1] == savedmap[1] then
                    found = true
                    savedmap[2] = map[2]
                    break
                end
            end
            if not found then
                table.insert(ret, map)
            end
        end
    end
    return ret
end

function SubtractMapKeys(base, subtract)
    local ret = {}
    for k,v in pairs(base) do
        if subtract[k] ~= nil then
            if type(subtract[k]) == "table" then
                local subtable = SubtractMapKeys(v, subtract[k])
                if GetTableSize(subtable) > 0 then
                    ret[k] = subtable
                end
            elseif subtract[k] == nil then
                ret[k] = v
            end
        end
    end
    return ret
end

-- Adds 'addition' to the end of 'orig', 'mult' times.
-- ExtendedArray({"one"}, {"two","three"}, 2) == {"one", "two", "three", "two", "three" }
function ExtendedArray(orig, addition, mult)
	local ret = {}
	for k,v in pairs(orig) do
		ret[k] = v
	end
	mult = mult or 1
	for i=1,mult do
		table.insert(ret,addition)
	end
	return ret
end

local function _FlattenTree(tree, ret, exclude, unique)
    for k, v in pairs(tree) do
        if type(v) == "table" then
            _FlattenTree(v, ret, exclude, unique)
        elseif not exclude[v] then
            table.insert(ret, v)
            exclude[v] = unique
        end
    end
    return ret
end

function FlattenTree(tree, unique)
    return _FlattenTree(tree, {}, {}, unique)
end

function GetRandomKey(choices)
 	local choice = math.random(GetTableSize(choices)) -1
 	
 	local picked = nil
 	for k,v in pairs(choices) do
 		picked = k
 		if choice<= 0 then
 			break
 		end
 		choice = choice -1
 	end
 	assert(picked)
	return picked
end

function GetRandomWithVariance(baseval, randomval)
    return baseval + (math.random()*2*randomval - randomval)
end

function GetRandomMinMax(min, max)
    return min + math.random()*(max - min)
end

function distsq(v1, v2, v3, v4)

    -- PLEASE FORGIVE US! WE NEVER MEANT FOR IT TO END THIS WAY!

    assert(v1, "Something is wrong: v1 is nil stale component reference?")
    assert(v2, "Something is wrong: v2 is nil stale component reference?")
    
    --special case for 2dvects passed in as numbers
    if v4 and v3 and v2 and v1 then
        local dx = v1-v3
        local dy = v2-v4
        return dx*dx + dy*dy
    end

    local dx = (v1.x or v1[1]) - (v2.x or v2[1])
    local dy = (v1.y or v1[2]) - (v2.y or v2[2])
    local dz = (v1.z or v1[3]) - (v2.z or v2[3])
    return dx*dx+dy*dy+dz*dz
end

local memoizedFilePaths = {}

-- look in package loaders to find the file from the root directories
-- this will look first in the mods and then in the data directory
function resolvefilepath( filepath, force_path_search )
    if memoizedFilePaths[filepath] then
        return memoizedFilePaths[filepath]
    end
    local resolved = softresolvefilepath(filepath, force_path_search)
    assert(resolved ~= nil, "Could not find an asset matching "..filepath.." in any of the search paths.")
    memoizedFilePaths[filepath] = resolved
   return resolved
end

function softresolvefilepath(filepath, force_path_search)
    force_path_search = force_path_search or false

	if IsConsole() and not force_path_search then
		return filepath -- it's already absolute, so just send it back
	end

	-- on PC platforms, search all the possible paths

	-- mod folders don't have "data" in them, so we strip that off if necessary. It will
	-- be added back on as one of the search paths.
	local filepath = string.gsub(filepath, "^/", "")

	local searchpaths = package.path
    for path in string.gmatch(searchpaths, "([^;]+)") do
        local filename = string.gsub(path, "scripts\\%?%.lua", filepath) -- why is this not string.gsub(path, "%?", modulepath) like in worldgen_main.lua?!?
        filename = string.gsub(filename, "\\", "/")
		--print("looking for: "..filename.." ("..filepath..")")
		if not kleifileexists or kleifileexists(filename) then
			--print("found it! "..filename)
            return filename
        end
    end
	-- as a last resort see if the file is an already correct path (incase this asset has already been processed)
	if not kleifileexists or kleifileexists(filepath) then
		--print("found it in it's actual path! "..filepath)
		return filepath
	end

	return nil
end

-------------------------MEMREPORT

local global_type_table = nil

local function type_name(o)
	if global_type_table == nil then
		global_type_table = {}
		for k,v in pairs(_G) do
			global_type_table[v] = k
		end
		global_type_table[0] = "table"
	end
	local mt = getmetatable(o)
	if mt then
		return global_type_table[mt] or "table"
	else
		return type(o) --"Unknown"
	end
end


local function count_all(f)
	local seen = {}
	local count_table
	count_table = function(t)
		if seen[t] then return end
		f(t)
		seen[t] = true
		for k,v in pairs(t) do
			if type(v) == "table" then
				count_table(v)
			else
				f(v)
            end
		end
	end
	count_table(_G)
end

function isnan(x) return x ~= x end
math.inf = 1/0 
function isinf(x) return x == math.inf or x == -math.inf end
function isbadnumber(x) return isinf(x) or isnan(x) end

local function type_count()
	local counts = {}
	local enumerate = function (o)
		local t = type_name(o)
		counts[t] = (counts[t] or 0) + 1
	end
	count_all(enumerate)
	return counts
end
   
function mem_report()
    local tmp = {}
    
    for k,v in pairs(type_count()) do 
        table.insert(tmp, {num=v, name=k})
    end
    table.sort(tmp, function(a,b) return a.num > b.num end)
    local tmp2 = {"MEM REPORT:\n"}
    for k,v in ipairs(tmp) do
        table.insert(tmp2, tostring(v.num).."\t"..tostring(v.name))
    end
    
    print (table.concat(tmp2,"\n"))
end

-------------------------MEMREPORT



function weighted_random_choice(choices)

    local function weighted_total(choices)
        local total = 0
        for choice, weight in pairs(choices) do
            total = total + weight
        end
        return total
    end

    local threshold = math.random() * weighted_total(choices)
    
    local last_choice
    for choice, weight in pairs(choices) do
        threshold = threshold - weight
        if threshold <= 0 then return choice end
        last_choice = choice
    end
    
    return last_choice
end
 

 
 function PrintTable(tab)
    local str = {}
    
    local function internal(tab, str, indent)
        for k,v in pairs(tab) do
            if type(v) == "table" then
                table.insert(str, indent..tostring(k)..":\n")
                internal(v, str, indent..' ')
            else
                table.insert(str, indent..tostring(k)..": "..tostring(v).."\n")
            end
        end
    end
    
    internal(tab, str, '')
    return table.concat(str, '')
end


-- make environment
local env = {  -- add functions you know are safe here
    loadstring=loadstring -- functions can get serialized to text, this is required to turn them back into functions
 }
 

function RunInEnvironment(fn, fnenv)
	setfenv(fn, fnenv)
	return xpcall(fn, debug.traceback)
end

function RunInEnvironmentSafe(fn, fnenv)
	setfenv(fn, fnenv)
	return xpcall(fn, function(msg) print(msg) StackTraceToLog() print(debugstack()) return "" end )
end

-- run code under environment [Lua 5.1]
function RunInSandbox(untrusted_code)
	if untrusted_code:byte(1) == 27 then return nil, "binary bytecode prohibited" end
	local untrusted_function, message = loadstring(untrusted_code)
	if not untrusted_function then return nil, message end
	return RunInEnvironment(untrusted_function, env)
end

-- RunInSandboxSafe uses an empty environement
-- By default this function does not assert
-- If you wish to run in a safe sandbox, with normal assertions:
-- RunInSandboxSafe( untrusted_code, debug.traceback )
function RunInSandboxSafe(untrusted_code, error_handler)
	if untrusted_code:byte(1) == 27 then return nil, "binary bytecode prohibited" end
	local untrusted_function, message = loadstring(untrusted_code)
	if not untrusted_function then return nil, message end
	setfenv(untrusted_function, {} )
	return xpcall(untrusted_function, error_handler or function() end)
end

function GetTickForTime(target_time) 
	return math.floor( target_time/GetTickTime() )
end

function GetTimeForTick(target_tick)
	return target_tick*GetTickTime()
end

function GetTaskRemaining(task)
    return (task == nil and -1)
        or (task:NextTime() == nil and -1)
        or (task:NextTime() < GetTime() and -1)
        or task:NextTime() - GetTime()
end

function GetTaskTime(task)
    return (task == nil and -1)
        or (task:NextTime() == nil and -1)
        or (task:NextTime())
end

function shuffleArray(array)
    local arrayCount = #array
    for i = arrayCount, 2, -1 do
        local j = math.random(1, i)
        array[i], array[j] = array[j], array[i]
    end
    return array
end

function shuffledKeys(dict)
	local keys = {}
	for k,v in pairs(dict) do
		table.insert(keys, k)
	end
	return shuffleArray(keys)
end

function sortedKeys(dict)
    local keys = {}
    for k,v in pairs(dict) do
        table.insert(keys, k)
    end
    table.sort(keys)
    return keys
end

function TrackedAssert(tracking_data, function_ptr, function_data)
	--print("TrackedAssert", tracking_data, function_ptr, function_data)
	_G['tracked_assert'] = function(pass, reason)		
							--print("Tracked:Assert", tracking_data, pass, reason)	 								
			 				assert(pass, tracking_data.." --> "..reason)
			 			end
			 							
	local result = function_ptr( function_data )
					
	_G['tracked_assert'] = _G.assert
	
	return result
end

function deepcopy(object)
    local lookup_table = {}
    local function _copy(object)
        if type(object) ~= "table" then
            return object
        elseif lookup_table[object] then
            return lookup_table[object]
        end
        local new_table = {}
        lookup_table[object] = new_table
        for index, value in pairs(object) do
            new_table[_copy(index)] = _copy(value)
        end
        return setmetatable(new_table, getmetatable(object))
    end
    return _copy(object)
end

-- http://lua-users.org/wiki/CopyTable
function shallowcopy(orig, dest)
    local copy
    if type(orig) == 'table' then
        copy = dest or {}
        for k, v in pairs(orig) do
            copy[k] = v
        end
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

-- if next(table) == nil, then the table is empty
function IsTableEmpty(t)
    -- https://stackoverflow.com/a/1252776/79125
    return next(t) == nil
end

function fastdump(value)
	local tostring = tostring
	local string = string
	local table = table
	local items = {"return "}
	local type = type

	local function printtable(in_table)
		table.insert(items, "{")
		
		for k,v in pairs(in_table) do
			local t = type(v)
			local comma = true
			if type(k) == "number" then
				if t == "number" then
					table.insert(items, string.format("%s", tostring(v)))
				elseif t == "string" then
					table.insert(items, string.format("[%q]", v))
				elseif t == "boolean" then
					table.insert(items, string.format("%s", tostring(v)))
				elseif type(v) == "table" then
					printtable(v)
				end
			elseif type(k) == "string" then
				local key = tostring(k)
				if t == "number" then
					table.insert(items, string.format("%s=%s", key, tostring(v)))
				elseif t == "string" then
					table.insert(items, string.format("%s=%q", key, v))
				elseif t == "boolean" then
					table.insert(items, string.format("%s=%s", key, tostring(v)))
				elseif type(v) == "table" then
					if next(v) then
						table.insert(items, string.format("%s=", key))
						printtable(v)
					else
						comma = false
					end
				end
			else
				assert(false, "trying to save invalid data type")
			end
			if comma and next(in_table, k) then
				table.insert(items, ",")
			end
		end
		
		table.insert(items, "}")
		collectgarbage("step")
	end
	printtable(value)
	return table.concat(items)
end

-- Get a table index as if the table were circular.
--
-- You probably want circular_index instead.
-- Due to Lua's 1-based arrays, this is more complex than usual.
function circular_index_number(count, index)
    local zb_current = index - 1
    local zb_result = zb_current
    zb_result = zb_result % count
    return zb_result + 1
end

-- Index a table as if it were circular.
-- Use like this:
--      next_item = circular_index(item_list, index + 1)
function circular_index(t, index)
    return t[circular_index_number(#t, index)]
end

--[[ Data Structures --]]

-----------------------------------------------------------------
-- Class RingBuffer (circular array)

RingBuffer = Class(function(self, maxlen)
    if type(maxlen) ~= "number" or maxlen < 1 then
        maxlen = 10
    end
    self.buffer = {}
    self.maxlen = maxlen or 10
    self.entries = 0
    self.pos = #self.buffer
end)

function RingBuffer:Clear()
    self.buffer = {}
    self.entries = 0
    self.pos = #self.buffer
end

-- Add an element to the circular buffer
function RingBuffer:Add(entry)
    local indx = self.pos % self.maxlen + 1

    self.entries = self.entries + 1
    if self.entries > self.maxlen then
        self.entries = self.maxlen
    end
    self.buffer[indx] = entry
    self.pos = indx
end

-- Access from start of circular buffer
function RingBuffer:Get(index)

    if index > self.maxlen or index > self.entries or index < 1 then
        return nil
    end

    local pos = (self.pos-self.entries) + index 
    if pos < 1 then
        pos = pos + self.entries
    end

    return self.buffer[pos]
end

function RingBuffer:GetBuffer()
    local t = {}
    for i=1, self.entries do
        t[#t+1] = self:GetElementAt(i)
    end
    return t
end

function RingBuffer:Resize(newsize)
    if type(newsize) ~= "number" or newsize < 1 then
        newsize = 1
    end

    -- not dealing with making the buffer smaller
    local nb = self:GetBuffer()

    self.buffer = nb
    self.maxlen = newsize
    self.entries = #nb
    self.pos = #nb

end

-----------------------------------------------------------------
-- Class LinkedList (singly linked)
-- Get elements using the iterator

LinkedList = Class(function(self)
    self._head = nil
    self._tail = nil
end)

function LinkedList:Append(v)
    local elem = {data=v}
    if self._head == nil and self._tail == nil then
        self._head = elem
        self._tail = elem
    else
        elem._prev = self._tail
        self._tail._next = elem
        self._tail = elem
    end

    return v
end

function LinkedList:Remove(v)
    local current = self._head
    while current ~= nil do
        if current.data == v then
            if current._prev ~= nil then
                current._prev._next = current._next
            else
                self._head = current._next
            end

            if current._next ~= nil then
                current._next._prev = current._prev
            else
                self._tail = current._prev
            end
            return true
        end

        current = current._next
    end

    return false
end

function LinkedList:Head()
    return self._head and self._head.data or nil
end

function LinkedList:Tail()
    return self._tail and self._tail.data or nil
end

function LinkedList:Clear()
    self._head = nil
    self._tail = nil
end

function LinkedList:Count()
    local count = 0
    local it = self:Iterator()
    while it:Next() ~= nil do
        count = count + 1
    end
    return count
end

function LinkedList:Iterator()
    return {
        _list = self,
        _current = nil,
        Current = function(it)
            return it._current and it._current.data or nil
        end,
        RemoveCurrent = function(it)
            -- use to snip out the current element during iteration

            if it._current._prev == nil and it._current._next == nil then
                -- empty the list!
                it._list:Clear()
                return
            end

            local count = it._list:Count()

            if it._current._prev ~= nil then
                it._current._prev._next = it._current._next
            else
                assert(it._list._head == it._current)
                it._list._head = it._current._next
            end

            if it._current._next ~= nil then
                it._current._next._prev = it._current._prev
            else
                assert(it._list._tail == it._current)
                it._list._tail = it._current._prev
            end

            assert(count-1 == it._list:Count())

            -- NOTE! "current" is now not part of the list, but its _next and _prev still work for iterating off of it.
        end,
        Next = function(it)
            if it._current == nil then
                it._current = it._list._head
            else
                it._current = it._current._next
            end
            return it:Current()
        end,
    }
end


function table.setfield(Table,Name,Value)

    -- Table (table, optional); default is _G
    -- Name (string); name of the variable--e.g. A.B.C ensures the tables A
    --   and A.B and sets A.B.C to <Value>.
    --   Using single dots at the end inserts the value in the last position
    --   of the array--e.g. A. ensures table A and sets A[table.getn(A)]
    --   to <Value>.  Multiple dots are interpreted as a string--e.g. A..B.
    --   ensures the table A..B.
    -- Value (any)
    -- Compatible with Lua 5.0 and 5.1

    if type(Table) ~= 'table' then
        Table,Name,Value = _G,Table,Name
    end

    local Concat,Key = false,''

    string.gsub(Name,'([^%.]+)(%.*)',
                    function(Word,Delimiter)
                        if Delimiter == '.' then
                            if Concat then
                                Word = Key .. Word
                                Concat,Key = false,''
                            end
                            if Table == _G then -- using strict.lua have to declare global before using it
                                global(Word)
                            end
                            if type(Table[Word]) ~= 'table' then
                                Table[Word] = {}
                            end
                            Table = Table[Word]
                        else
                            Key = Key .. Word .. Delimiter
                            Concat = true
                        end
                    end
                    )

    if Key == '' then
        Table[#Table+1] = Value
    else
        Table[Key] = Value
    end

end


function table.getfield(Table,Name)
    -- Access a value in a table using a string
    -- table.getfield(A,"A.b.c.foo.bar")

    if type(Table) ~= 'table' then
        Table,Name = _G,Table
    end

    for w in string.gfind(Name, "[%w_]+") do
        Table = Table[w]
        if Table == nil then
            return nil
        end
    end
    return Table
end

function table.findfield(Table,Name)
    local indx = ""

    for i,v in pairs(Table) do
        if i == Name then
            return i
        end
        if type(v) == "table" then
            indx = table.findfield(v,Name)
            if indx then
                return i .. "." .. indx
            end
        end
    end
    return nil
end

function table.findpath(Table,Names,indx)
    local path = ""
    indx = indx or 1
    if type(Names) == "string" then
        Names = {Names}
    end

    for i,v in pairs(Table) do
        if i == Names[indx] then
            if indx == #Names then
                return i
            elseif type(v) == "table" then
                path = table.findpath(v,Names,indx+1)
                if path then
                    return i .. "." .. path
                else
                    return nil
                end
            end
        end
        if type(v) == "table" then
            path = table.findpath(v,Names,indx)
            if path then
                return i .. "." .. path
            end
        end
    end
    return nil
end

function TrackMem()
	collectgarbage()
	collectgarbage("stop")
	TheSim:SetMemoryTracking(true)
end

function DumpMem()
	TheSim:DumpMemoryStats()
	mem_report()
	collectgarbage("restart")
	TheSim:SetMemoryTracking(false)
end

function checkbit(x, b)
    return x % (b + b) >= b
end

-- Width is the total width of the region we are interested in, in radians.
-- Returns true if testPos is within .5*width of forward on either side
-- Forward is a vector, position and testPos are both locations, all are represented as Vector3s
function IsWithinAngle(position, forward, width, testPos)

	-- Get vector from position to testpos (testVec)
	local testVec = testPos - position

	-- Test angle from forward to testVec (testAngle)
	testVec = testVec:GetNormalized()
	forward = forward:GetNormalized()
	local testAngle = math.acos(testVec:Dot(forward))

	-- Return true if testAngle is <= +/- .5*width
	if math.abs(testAngle) <= .5*math.abs(width) then 
		return true
	else 
		return false
	end
end


local Chars = {}
for Loop = 0, 255 do
   Chars[Loop+1] = string.char(Loop)
end
local String = table.concat(Chars)

local Built = {['.'] = Chars}

local AddLookup = function(CharSet)
   local Substitute = string.gsub(String, '[^'..CharSet..']', '')
   local Lookup = {}
   for Loop = 1, string.len(Substitute) do
       Lookup[Loop] = string.sub(Substitute, Loop, Loop)
   end
   Built[CharSet] = Lookup

   return Lookup
end

function string.random(Length, CharSet)
   -- Length (number)
   -- CharSet (string, optional); e.g. %l%d for lower case letters and digits

   local CharSet = CharSet or '.'

   if CharSet == '' then
      return ''
   else
      local Result = {}
      local Lookup = Built[CharSet] or AddLookup(CharSet)
      local Range = table.getn(Lookup)

      for Loop = 1,Length do
         Result[Loop] = Lookup[math.random(1, Range)]
      end

      return table.concat(Result)
   end
end

--utf8substr(str, start, end)
--start: 1-based start position (can be negative to count from end)
--end: 1-based end position (optional, can be negative to count from end)
--returns a new string
if APP_VERSION ~= "MAPGEN" then
    string.utf8char = utf8char
    string.utf8sub = utf8substr
    string.utf8len = utf8strlen
    string.utf8upper = utf8strtoupper
    string.utf8lower = utf8strtolower
end

-- Returns the 0 - 255 color of a hex code
function HexToRGB(hex)
    hex = hex:gsub("#","")
    return tonumber("0x"..hex:sub(1,2)), tonumber("0x"..hex:sub(3,4)), tonumber("0x"..hex:sub(5,6))
end

-- Returns the 0.0 - 1.0 color from r, g, b parameters
function RGBToPercentColor(r, g, b)
    return r/255, g/255, b/255
end

-- Returns the 0.0 - 1.0 color from a hex parameter
function HexToPercentColor(hex)
    return RGBToPercentColor(HexToRGB(hex))
end

function CalcDiminishingReturns(current, basedelta)
    local dampen = 3 * basedelta / (current + 3 * basedelta)
    local dcharge = dampen * basedelta * .5 * (1 + math.random() * dampen)
    return current + dcharge
end

function Dist2dSq(p1, p2) 
	local dx = p1.x - p2.x
	local dy = p1.y - p2.y
	return dx*dx + dy*dy
end

function DistPointToSegmentXYSq(p, v1, v2) 
	local l2 = Dist2dSq(v1, v2)
	if (l2 == 0) then
		return Dist2dSq(p, v1)
	end
	local t = ((p.x - v1.x) * (v2.x - v1.x) + (p.y - v1.y) * (v2.y - v1.y)) / l2
	if (t < 0) then
		return Dist2dSq(p, v1)
	end
	if (t > 1) then
		return Dist2dSq(p, v2)
	end
	return Dist2dSq(p, {x = v1.x + t * (v2.x - v1.x), y =v1.y + t * (v2.y - v1.y)});
end


-- helpers for orderedPairs
function __genOrderedIndex( t )
    local orderedIndex = {}
    for key in pairs(t) do
        table.insert( orderedIndex, key )
    end
    table.sort( orderedIndex )
    return orderedIndex
end

function orderedNext(t, state)
    -- Equivalent of the next function, but returns the keys in the alphabetic
    -- order. We use a temporary ordered key table that is stored in the
    -- table being iterated.

    local key = nil
    --print("orderedNext: state = "..tostring(state) )
    if state == nil then
        -- the first time, generate the index
        t.__orderedIndex = __genOrderedIndex( t )
        key = t.__orderedIndex[1]
    else
        -- fetch the next value
        for i = 1,table.getn(t.__orderedIndex) do
            if t.__orderedIndex[i] == state then
                key = t.__orderedIndex[i+1]
            end
        end
    end

    if key then
        return key, t[key]
    end

    -- no more value to return, cleanup
    t.__orderedIndex = nil
    return
end

-- iterate over a list in sorted order
function orderedPairs(t)
    -- Equivalent of the pairs() function on tables. Allows to iterate
    -- in order
    return orderedNext, t, nil
end
