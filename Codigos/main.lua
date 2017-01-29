function love.load ()
	version = "0.1"
	love.graphics.setBackgroundColor(255, 255, 255, 255)
	love.window.setMode(400, 300, {resizable=false, vsync=false})
	love.window.setTitle("Canhao v" .. version)
	
	love.physics.setMeter(100)
	world = love.physics.newWorld(0, 0, true)	--Necessario para usar fisica
	canhao = {}	--Tabela canhao, onde ficam os atributos do canhao
	canhao.body = love.physics.newBody(world, 100, 100, "dynamic")	--Corpo do canhao, que possui as propriedades fisicas
	canhao.shape = love.physics.newRectangleShape(20, 20)	--Aparencia do canhao
	canhao.fixture = love.physics.newFixture(canhao.body, canhao.shape)	--Liga o corpo e a aparencia
	--Atributos para velocidade de avanco, rotacao do canhao e tiros
	canhao.velocidade = 50
	canhao.giro = 5
	canhao.tiro = {}
	canhao.tiro.body = love.physics.newBody(world, canhao.body:getX(), canhao.body:getY(), "dynamic")
	canhao.tiro.shape = love.physics.newCircleShape(5)
	canhao.fixture = love.physics.newFixture(canhao.tiro.body, canhao.tiro.shape)
end

function love.update(dt)
	world:update(dt)
	--Gira o canhao
	if love.keyboard.isDown("left") then
		canhao.body:setAngularVelocity(-canhao.giro)
	elseif love.keyboard.isDown("right") then
		canhao.body:setAngularVelocity(canhao.giro)
	else	--Se nenhuma tecla para girar e pressionada, para de girar
		canhao.body:setAngularVelocity(0)
	end
	--Anda com o canhao
	if love.keyboard.isDown("up") then
		canhao.body:setLinearVelocity(canhao.velocidade * math.cos(canhao.body:getAngle()), canhao.velocidade * math.sin(canhao.body:getAngle()))
	else	--Se nenhuma tecla para andar e pressionada, para de girar
		canhao.body:setLinearVelocity(0, 0)
	end
end

function love.draw()
	love.graphics.setColor(0, 0, 0)
	love.graphics.polygon("fill", canhao.body:getWorldPoints(canhao.shape:getPoints()))
	love.graphics.setColor(255, 0, 0)
	love.graphics.circle("fill", canhao.tiro.body:getX(), canhao.tiro.body:getY(), canhao.tiro.shape:getRadius())
end