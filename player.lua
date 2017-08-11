function Player(world, anim8)
  local self = {}
        self.x = love.graphics.getWidth()/2
        self.y = love.graphics.getHeight()/2
        self.width = 32
        self.height = 32
        self.speed = 120
        self.action = 'stand'
        self.direction = 'down'
        self.yOffset = self.height-6

  -- Load sprite sheet
  local spriteSheet = love.graphics.newImage('assets/sprites/clotharmor.png')
  local grid = anim8.newGrid(self.width, self.height, spriteSheet:getWidth(), spriteSheet:getHeight())

  -- Create our various player animations
  local animations = {
    stand_up = anim8.newAnimation(grid(3,5), 100),
    stand_right = anim8.newAnimation(grid(3,2), 100),
    stand_down = anim8.newAnimation(grid(3,8), 100),
    stand_left = anim8.newAnimation(grid(3,2), 100):flipH(),
    walk_up = anim8.newAnimation(grid('1-4',5), 0.1),
    walk_right = anim8.newAnimation(grid('1-4',2), 0.1),
    walk_down = anim8.newAnimation(grid('1-4',8), 0.1),
    walk_left = anim8.newAnimation(grid('1-4',2), 0.1):flipH()
  }

  -- Add the player to the world
  world.bumpWorld:add(self, self.x, self.y, self.width, self.height - self.yOffset)

  -- Get the current sprite animation
  local getAnimation = function()
    return animations[self.action .. '_' .. self.direction]
  end

  -- Draw player sprite
  self.draw = function()
    love.graphics.setColor(255, 255, 255)
    getAnimation():draw(spriteSheet, self.x, self.y)
  end

  -- Handle updating the player sprite
  self.update = function(dt)
    self.action = 'stand'

    local dx, dy = 0, 0

    if love.keyboard.isDown('down') and self.y < love.graphics.getHeight() - self.height then
      self.action = 'walk'
      self.direction = 'down'
      dy = self.speed * dt
    elseif love.keyboard.isDown('up') and self.y > 0 then
      self.action = 'walk'
      self.direction = 'up'
      dy = -self.speed * dt
    end

    if love.keyboard.isDown('left') and self.x > 0 then
      self.action = 'walk'
      self.direction = 'left'
      dx = -self.speed * dt
    elseif love.keyboard.isDown('right') and self.x < love.graphics.getWidth() - self.width then
      self.action = 'walk'
      self.direction = 'right'
      dx = self.speed * dt
    end

    -- Attempt to move sprite
    self.x, self.y = world.bumpWorld:move(self, self.x + dx, self.y + dy + self.yOffset)
    self.y = self.y - self.yOffset

    -- Perform sprite animation
    getAnimation():update(dt)
  end

  return self
end
