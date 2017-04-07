local Buffer = require "buffer"
local Control = (require "puzzle"):new()
local View = Control.view

local function createNodeInitial()
  local state=Control:getInitial()
  return { state=state, cost=Control:calculateState(state) }
end

local function createNodeFinal()
  local state=Control:getFinal()
  return { state=state, cost=Control:calculateState(state) }
end

local function rule(first,second)
  return first.cost < second.cost
end

local function expandFrontier(frontier, node, visited)
  local states = Buffer:new(Control:findStates(node.state, visited))
  if states:isEmpty() then return end
  repeat
    local state = states:remove()
    frontier:insertByRule({ state=state, cost=Control:calculateState(state) }, rule)
  until states:isEmpty()
end

local function run()
  local seed = createNodeInitial()
  local frontier = Buffer:new():insert(seed)
  local target = createNodeFinal()
  local visited = {[seed.state.id]={}}
  local node, count
  count = 0
  while(true) do
    -- if count == 181441 then return "181441" end
    if frontier:isEmpty() then
     local ret = {
        success=false,
        msg="Falhou em buscar a resposta!"
      }
      return ret
    end
    node = frontier:remove()
    View.log(node.state.id, node.cost, node.state.level, count, #frontier.list);
    if node.state == target.state then
      local ret = {
        view = View,
        success=true,
        msg="Sucesso em buscar a resposta! " .. count,
        node=node,
        steps=visited
      }
      return ret
    end
    expandFrontier(frontier,node,visited)
    count = count + 1
  end
end

return { start=run }