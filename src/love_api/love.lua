local bus = {}

function love.draw()
  bus.draw()
end

--- Callback function triggered when window receives or loses focus.
function love.focus(focus)
end

--- Called when a joystick button is pressed.
function love.joystickpressed()
end

--- Called when a joystick button is released.
function love.joystickreleased()
end

--- Callback function triggered when a key is pressed.
function love.keypressed(key, unicode)
  print(bus.move)
  bus.mouse(bus.move)
end

--- Callback function triggered when a key is released.
function love.keyreleased(key, unicode)
end

--- This function is called exactly once at the beginning of the game.
function love.load()
end

--- Callback function triggered when a mouse button is pressed.
function love.mousepressed(x, y, button)
end

---	Callback function triggered when a mouse button is released.
function love.mousereleased(x, y, button)
end

---	Callback function triggered when the game is closed.
function love.quit()
end

--- Callback function used to update the state of the game every frame.
function love.update(dt)

end

return bus