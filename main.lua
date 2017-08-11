local gameState,
      intro,
      world,
      player

function love.load()
  local anim8 = require 'libs/anim8/anim8'
  local bump = require 'libs/bump/bump'
  local sti = require 'libs/sti/sti'

  require 'constants'
  require 'intro'
  require 'world'
  require 'player'

  gameState = GAME_INTRO
  intro = Intro()
  world = World(sti, bump)
  player = Player(world, anim8)
end

function love.update(dt)
  if gameState == GAME_RUNNING then
    world.update(dt)
    player.update(dt)
  end
end

function love.draw()
  if gameState == GAME_INTRO then
    intro.draw()
  else
    world.draw()
    player.draw()
  end
end

function love.keypressed(key, scancode, isrepeat)
  if gameState == GAME_INTRO then
    if key == 'space' then
      gameState = GAME_RUNNING
    end
  elseif gameState == GAME_RUNNING then
    if key == 'escape' then
      gameState = GAME_INTRO
    end
  end
end
