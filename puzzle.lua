---@module List
local Util = require "util"
local Config = require "configuration"
local View = require "puzzle_view"

local math = math;

local behavior = {
		__eq = function (state1,state2)
			return state1.match[state2.id]
		end
}

local heuristic = function (self,state)
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

local State = {}

function State:new()
	local instance = {}
	local initialId = table.concat(Config.INITIAL,',')
	local finalId = table.concat(Config.FINAL,',')
	self.__index = State
	setmetatable(instance, self)
	instance.initial = Util.createBehavior({
		map=Config.INITIAL,
		level=0,
		id=initialId,
		match={[initialId]=true},
	},behavior)
	instance.final = Util.createBehavior({
		map=Config.FINAL,
		level=0,
		id=finalId,
		match={[finalId]=true}
	},behavior)
	instance.size = Config.SIZE
	instance.coordinate = Util.getCartesianPlane(Config.SIZE)
	instance.routes = Util.getRoutesOfCartesianPlane(Config.SIZE,instance.coordinate)
	instance.emptySpace = Config.SIZE*Config.SIZE
	instance.view = View:new(Config.SIZE)
	return instance
end

function State:getInitial()
	return self.initial
end

function State:getFinal()
	return self.final
end

function State:findStates(state, filter)
	local oldPositionOfEmptySpace = Util.findContent(state.map,self.emptySpace)
	local routes = self.routes[oldPositionOfEmptySpace]
	local states = {}
	local unpack = table.unpack or unpack
	for _, newPositionOfEmptySpace in ipairs(routes) do
		local newState = Util.createBehavior({
			map={unpack(state.map)},
			level=(state.level+1),
			id=0,
			match={}
		},behavior)
		newState.map[newPositionOfEmptySpace] = state.map[oldPositionOfEmptySpace]
		newState.map[oldPositionOfEmptySpace] = state.map[newPositionOfEmptySpace]
		if not filter[table.concat(newState.map,',')] then
			newState.id = table.concat(newState.map,',')
			newState.match[newState.id]=true
			states[#states+1] = newState
			filter[newState.id] = {parentId=state.id}
		end
	end
	return states
end


function State:calculateState(state)
	return state.level + heuristic(self,state)
	-- return heuristic(self,state)
	-- return state.level/self.size + heuristic(self,state)
end

return State