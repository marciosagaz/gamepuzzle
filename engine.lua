
local Control = (require "puzzle"):new()

local function run()
  Control:start()
  while(true) do
    if Control:isFinal() then
      return Control:setToFinal()
    end
    Control:next()
    Control:register();
    if Control:isTarget() then
      return Control:setToTarget()
    end
    Control:expandFrontier()
  end
end
return { start=run }