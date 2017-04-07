-- links:
-- https://heuristicswiki.wikispaces.com/N+-+Puzzle
-- http://theory.stanford.edu/~amitp/GameProgramming/Heuristics.html
-- https://en.wikipedia.org/wiki/15_puzzle
-- https://web.archive.org/web/20160119232730/http://juropollo.xe0.ru/stp_results_mxn_a123_en.htm#anti3x3stm


local game = require "engine"

local timestart = os.time()
local result = game.start()
print('time:',os.time()-timestart)
print(result.msg)

local steps = {}
if result.success then
  local parentId = result.node.state.id
  repeat
    table.insert(steps,1,parentId)
    parentId = result.steps[parentId].parentId
  until not parentId
end

for move, content in ipairs(steps) do
  print('move',move)
  result.view:draw(content)
  print("Enter to next move.")
  io.read()
end