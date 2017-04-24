local bus = require 'love_api.love'

local Screen = {}

function Screen:new(size)
	local instance = {}
	self.__index = Screen
	setmetatable(instance, self)
  instance.size = size
  bus.draw = function () instance:doit() end
  bus.mouse = function (i) instance:iterate(i) end
  self.tab = ""
  return instance
end

function Screen:draw(map)
  local output = {}
  local count = 0
  local size = self.size
  local dsize = size*size
  local tonumber = tonumber
  local big = size > 3
  for match in map:gmatch("([%d%.%+%-]+),?") do
    output[#output + 1] = '|' .. ((big and (tonumber(match) < 10) and '0'..match) or match)
    count = count + 1
    output[#output + 1] = ((count % size) == 0  and '|\n') or ''
  end
  local layout = table.concat(output)
  local repValue = (layout:len() / size) - 1
  -- print(("_"):rep(repValue) .. '\n' .. string.gsub(layout,
  --   tostring(dsize),big and '  ' or ' ') .. ("¨"):rep(repValue))
  self.tab = (("_"):rep(repValue) .. '\n' .. string.gsub(layout,
    tostring(dsize),big and 'XX' or 'X') .. ("¨"):rep(repValue))
end

function Screen:show(result)
  local steps = {}
  if result.success then
    local parentId = result.node.state.id
    repeat
      table.insert(steps,1,parentId)
      parentId = result.steps[parentId].parentId
    until not parentId
  else
    print(result.msg)
    return
  end

  print(result.time)
  print(result.msg .. #steps - 1 .. ' passos')
  print("Na fronteira durante a execução! " .. result.frontier .. ' Nodos')
  -- for move, content in ipairs(steps) do
    -- print('move',move-1)
    -- self:draw(content)
    -- print("Enter to next move.")
    -- io.read()
  -- end
  self.steps = steps
  self.func = ipairs(steps)
  self:iterate(0)
end

function Screen.log(map, cost, level, visited, novisited)
  print( 'map', map, 'cost', cost, 'level', level, 'visited', visited, 'novisited', novisited)
end

function Screen:iterate(i)
  print('Screen:iterate(i)')
  love.graphics.setColor(0, 255, 0, 255)
  local move, content = self.func(self.steps,i)
    love.graphics.print(move,5,10)
    self:draw(content)
    love.graphics.print("Enter to next move.",50,10)
    -- io.read()
    bus.move = move
    return move
end

function Screen:doit()
  love.graphics.setColor(0, 255, 0, 255)
  love.graphics.print(self.tab,10,10)
end

return Screen