platform = {}
player = {}
gfx = love.graphics

function love.load()
	platform.width = gfx.getWidth()
	platform.height = gfx.getHeight()

	platform.x = 0
	platform.y = platform.height / 2

	player.x = gfx.getWidth() / 2
	player.y = gfx.getHeight() / 2

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
end

function love.draw()

  gfx.push()
  gfx.translate(-player.x+(platform.width/2), -player.y+(platform.height/2))
  -- draw map here
  
  gfx.setColor(1, 1, 1)
  gfx.rectangle('fill', platform.x, platform.y, platform.width, platform.height)

  gfx.draw(player.img, player.x, player.y, 0, 1, 1, 0, 32)

  gfx.pop()
  -- draw gui here
  gfx.print("Score: 0",20,20)

end
