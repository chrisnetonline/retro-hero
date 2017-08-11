function Intro()
  local self = {}

  self.draw = function()
    love.graphics.setFont(FONT_TITLE)
    love.graphics.printf('Retro Hero!', 0, 200, love.graphics.getWidth(), 'center')

    love.graphics.setFont(FONT_SUBTITLE)
    love.graphics.printf('Press space bar to begin!', 0, 300, love.graphics.getWidth(), 'center')
  end

  return self
end
