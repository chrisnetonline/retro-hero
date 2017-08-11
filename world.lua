function World(sti, bump)
  local self = {}

  -- Create the world
  self.bumpWorld = bump.newWorld(16)

  -- Load a map exported to Lua from Tiled
  local map = sti('assets/maps/map01.lua', { 'bump' })

  -- Prepare collision objects
  map:bump_init(self.bumpWorld)

  self.draw = function()
    love.graphics.setColor(255, 255, 255)
    map:draw()

    if COLLISION_DEBUG == true then
      love.graphics.setColor(255, 0, 0)
      map:bump_draw(self.bumpWorld)
    end
  end

  self.update = function(dt)
    map:update()
  end

  return self
end
