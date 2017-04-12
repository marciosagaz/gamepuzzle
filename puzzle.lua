---@module List

-----------------------
--[ import modules ]
-----------------------

local Util = require "util"
local Config = require "configuration"
local Buffer = require "buffer"
local View = require "puzzle_view"
local math = math;
local State = {}

-----------------------
--[ private functions ]
-----------------------

local behavior = {
		__eq = function (state1,state2)
			return state1.match[state2.id]
		end
}

local function rule(first,second)
  return first.cost < second.cost
end

local function heuristic(self,state)
	local cost, coord = 0, self.coordinate
	if Config.HEURISTIC.MANHATTAN then
		local startmap, finalmap = state.map, self.final.map
		local abs = math.abs
		local s, f
		for index=1, self.size*self.size, 1 do
			s = coord[startmap[index]]
			f = coord[finalmap[index]]
			cost = cost + abs(s.x - f.x) + abs(s.y - f.y)
		end
	elseif Config.HEURISTIC.OUT_OF_PLACE then
		for index, content in pairs(state.map) do
			if self.final.map[index] ~= content then cost = cost + 1 end
		end
	end
	return cost
end

local function calculateState(self,state)
	return state.level + heuristic(self,state)
end

local function createNewState(state, id, match)
	local unpack = table.unpack or unpack
	return Util.createBehavior({
			map={unpack(state.map)},
			level=(state.level+1),
			id= id or 0,
			match= match or {}
		},behavior)
end


-----------------------
--[ public functions ]
-----------------------

function State:new()
	local instance = {}
	local initialId = table.concat(Config.INITIAL,',')
	local finalId = table.concat(Config.FINAL,',')
	self.__index = State
	setmetatable(instance, self)
	instance.initial = createNewState({map=Config.INITIAL, level=-1}, initialId, {[initialId]=true})
	instance.final = createNewState({map=Config.FINAL, level=-1}, finalId, {[finalId]=true})
	instance.size = Config.SIZE
	instance.coordinate = Util.getCartesianPlane(Config.SIZE)
	instance.routes = Util.getRoutesOfCartesianPlane(Config.SIZE,instance.coordinate)
	instance.emptySpace = Config.SIZE*Config.SIZE
	instance.view = View:new(Config.SIZE)
	instance.visited = {}
	instance.frontier = Buffer:new()
	return instance
end

function State:start()
	self.timestart = os.time()
	local seed = { state=self.initial, cost=calculateState(self,self.initial) }
	self.frontier:insert(seed)
  self.visited[seed.state.id] = {}
	self.target = { state=self.final, cost=calculateState(self,self.final) }
end

function State:getFrontier()
  return self.frontier
end

function State:expandFrontier(node)
  local state = node.state;
	local oldPositionOfEmptySpace = Util.findContent(state.map,self.emptySpace)
	local routes = self.routes[oldPositionOfEmptySpace]
	for _, newPositionOfEmptySpace in ipairs(routes) do
	  local newState = createNewState(state)
		newState.map[newPositionOfEmptySpace] = state.map[oldPositionOfEmptySpace]
		newState.map[oldPositionOfEmptySpace] = state.map[newPositionOfEmptySpace]
		local id = table.concat(newState.map,',')
		if not self.visited[id] then
			newState.id = id
			newState.match[newState.id]=true
			self.visited[newState.id] = {parentId=state.id}
			self.frontier:insertByRule({ state=newState, cost=calculateState(self,newState) }, rule)
		end
	end
end

function State:register(node, position)
	self.view.log(node.state.id, node.cost, node.state.level, position, #self.frontier.list)
end

function State:isTarget(node)
	return node.state == self.target.state
end

function State:setTargetSuccess(node,position)
	self.view:show({
		success=true,
		msg="Sucesso em buscar a resposta! ",
		node=node,
		steps=self.visited,
		frontier=position+#self.frontier.list,
		time='time: ' .. os.time()-self.timestart
	})
end

function State:setTargetFail()
  self.view:show({
		success=false,
		msg="Falhou em buscar a resposta! Fronteira está vazia!"
  })
end

return State