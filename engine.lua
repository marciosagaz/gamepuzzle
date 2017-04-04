local Buffer = require "buffer"
local Manager = (require "puzzle"):new()

local function createNodeInitial()
  local state=Manager:getInitial()
  return { state=state, cost=Manager:calculateState(state) }
end

local function createNodeFinal()
  local state=Manager:getFinal()
  return { state=state, cost=Manager:calculateState(state) }
end

local function rule(first,second)
  return first.cost < second.cost
end

local function expandFrontier(frontier, node, visited)
  local states = Buffer:new(Manager:findStates(node.state, visited))
  if states:isEmpty() then return end
  repeat
    local state = states:remove()
    frontier:insertByRule({ state=state, cost=Manager:calculateState(state) }, rule)
  until states:isEmpty()
end

local function run(log)
  local seed = createNodeInitial()
  local frontier = Buffer:new():insert(seed)
  local target = createNodeFinal()
  local visited = {[seed.state.id]={}}
  local node, count
  count = 0
  while(true) do
    if count == 181441 then return "181441" end
    if frontier:isEmpty() then
     local ret = {
        success=false,
        msg="Falhou em buscar a resposta!"
      }
      return ret
    end
    node = frontier:remove()
    log(node.state.id, node.cost, node.state.level, count, #frontier.list);
    if node.state == target.state then
      local ret = {
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