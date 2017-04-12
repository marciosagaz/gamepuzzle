
local Control = (require "puzzle"):new()

local function run()
  Control:start()
  local frontier, position, node = Control:getFrontier(), 1
  while(true) do
    -- if position == 181441 then return "181441" end
    if frontier:isEmpty() then
      return Control:setTargetFail()
    end
    node = frontier:remove()
    Control:register(node, position);
    if Control:isTarget(node) then
      return Control:setTargetSuccess(node, position)
    end
    Control:expandFrontier(node)
    position = position + 1
  end
end

return { start=run }