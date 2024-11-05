gfx=love.graphics

function love.load()
  player = {}
  platforms = {
      {x = 100, y = 500, width = 200, height = 20},
      {x = 400, y = 400, width = 200, height = 20},
      {x = 700, y = 300, width = 200, height = 20},
  }
  collectibles = {
    {x = 150, y = 450, width = 20, height = 20, collected = false},
    {x = 450, y = 300, width = 20, height = 20, collected = false},
  }
  window = {
      width = gfx.getWidth(),
      height = gfx.getHeight()
  }
  spikes = {
      {x = 300, y = 500, width = 50, height = 10},
  }

      player.x = gfx.getWidth() / 2
      player.y = gfx.getHeight() / 2
      player.width = 30
      player.height = 30

      player.speed = 200

      player.img = gfx.newImage('purple.png')

      player.ground = player.y
      
      player.y_velocity = 0

      player.jump_height = -300
      player.gravity = -500
end

function love.update(dt)
      if love.keyboard.isDown('right') then
	    if player.x < (gfx.getWidth() - player.img:getWidth()) then
		    player.x = player.x + (player.speed * dt)
	    end
      elseif love.keyboard.isDown('left') then
	    if player.x > 0 then 
		    player.x = player.x - (player.speed * dt)
	    end
      end

      if love.keyboard.isDown('space') then
	    if player.y_velocity == 0 then
		    player.y_velocity = player.jump_height
	    end
      end

      if player.y_velocity ~= 0 then
	player.y = player.y + player.y_velocity * dt
	player.y_velocity = player.y_velocity - player.gravity * dt
      end

      if player.y > player.ground then
        player.y_velocity = 0
	player.y = player.ground
      end

    for _, collectible in ipairs(collectibles) do
	  if not collectible.collected and 
	     player.x < collectible.x + collectible.width and 
	     player.x + player.width > collectible.x and 
	     player.y < collectible.y + collectible.height and 
	     player.y + player.height > collectible.y then
	      collectible.collected = true
	  end
      end

   for _, spike in ipairs(spikes) do
        if player.x < spike.x + spike.width and 
           player.x + player.width > spike.x and 
           player.y < spike.y + spike.height and 
           player.y + player.height > spike.y then
            -- Reset player position or handle game over
            player.x = 50
            player.y = 450
        end
    end
end

function love.draw()

      gfx.push()
      gfx.translate(-player.x+(window.width/2), -player.y+(window.height/2))
      -- draw map here
      
      gfx.setColor(1, 1, 1)
      for _, platform in ipairs(platforms) do
	gfx.rectangle("fill", platform.x, platform.y, platform.width, platform.height)
      end

      gfx.draw(player.img, player.x, player.y, 0, 1, 1, 0, 32)

      for _, collectible in ipairs(collectibles) do
        if not collectible.collected then
            love.graphics.rectangle("fill", collectible.x, collectible.y, collectible.width, collectible.height)
        end
      end


      gfx.setColor(0, 1, 0)
     for _, spike in ipairs(spikes) do
	  love.graphics.rectangle("fill", spike.x, spike.y, spike.width, spike.height)
      end

      gfx.pop()
      -- draw gui here
      gfx.print("Score: 0",20,20)

end
