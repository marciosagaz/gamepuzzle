local Screen = {}

function Screen:new(size)
	local instance = {}
	self.__index = Screen
	setmetatable(instance, self)
  instance.size = size
  return instance
end

function Screen:draw(map)
  local output = {}
  local count = 0
  for match in map:gmatch("([%d%.%+%-]+),?") do
    output[#output + 1] = '|' .. ((self.size > 3 and (tonumber(match) < 10) and '0'..match) or match)
    count = count + 1
    output[#output + 1] = ((count % self.size) == 0  and '|\n') or ''
  end
  print(table.concat(output))
  print(' _____\n' .. string.gsub(table.concat(output),tostring(self.size*self.size),'  ')..' ¨¨¨¨¨')
end

function Screen.log(map, cost, level, visited, novisited)
  print( 'map', map, 'cost', cost, 'level', level, 'visited', visited, 'novisited', novisited)
end

return Screen