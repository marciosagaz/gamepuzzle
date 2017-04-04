local game = require "engine"


local function log(map, cost, level, visited, novisited)
  print( 'map', map, 'cost', cost, 'level', level, 'visited', visited, 'novisited', novisited)
end
local timestart = os.time()
local result = game.start(log)
print('time:',os.time()-timestart)
print(result.msg)
local steps = {}
if result.success then
  local parentId = result.node.state.id
  repeat
    table.insert(steps, 1, (string.gsub(string.gsub(parentId,("(%d%d%d)"):rep(3),"|%1|\n|%2|\n|%3|\n"),'9',' ')) )
    parentId = result.steps[parentId].parentId
  until not parentId
end

for _, content in ipairs(steps) do
  print("_____",_)
  print(content)
  print("Enter to next move.")
  io.read()
end