require("extern/class")
require("colors")
require("common")

menu = class()

function menu:init()
	self.base = love.graphics.newCanvas(400, 700)
	self.select = nil
	self.btns = {}
	self.titles = {}
end

function menu:renderbase()
	love.graphics.setCanvas(self.base)
	love.graphics.clear()

	love.graphics.setColor(255, 255, 255)

	for i, v in pairs(self.titles) do
		love.graphics.draw(v[1], v[2], v[3])

		love.graphics.setNewFont(v[7])
		love.graphics.print(v[4], v[5], v[6])
	end

	for i, v in pairs(self.btns) do
		love.graphics.draw(v[1], v[2], v[3])

		love.graphics.setNewFont(v[7])
		love.graphics.print(v[4], v[5], v[6])
	end

	if self.select ~= nil then
		love.graphics.setColor(255, 255, 255)
		love.graphics.setLineWidth(3)
		love.graphics.rectangle('line', self.btns[self.select][2], self.btns[self.select][3], 200, 50)
	end

	love.graphics.setCanvas()
end

function menu:renderstart()
	self.select = 0
	self.btns = {}
	self.titles = {}

	gametitle = love.graphics.newCanvas(200, 50)
	love.graphics.setCanvas(gametitle)
	self.titles[0] = {gametitle, 100, 150, "Pipes\n and\nPipes\n and\nPipes", 160, 50, 30}
	love.graphics.setCanvas()

	startbtn = love.graphics.newCanvas(200, 50)
	love.graphics.setCanvas(startbtn)
	love.graphics.setColor(150, 0, 175)
	love.graphics.rectangle('fill', 0, 0, 200, 50)
	self.btns[0] = {startbtn, 100, 250, "start", 175, 265, 20, 1}
	love.graphics.setCanvas()

	exitbtn = love.graphics.newCanvas(200, 50)
	love.graphics.setCanvas(exitbtn)
	love.graphics.setColor(150, 0, 175)
	love.graphics.rectangle('fill', 0, 0, 200, 50)
	self.btns[1] = {exitbtn, 100, 325, "exit", 180, 340, 20, 2}
	love.graphics.setCanvas()

	self:renderbase()

end

function menu:renderpause()
	self.select = 0
	self.btns = {}
	self.titles = {}

	pausetitle = love.graphics.newCanvas(200, 50)
	love.graphics.setCanvas(pausetitle)
	self.titles[0] = {pausetitle, 100, 100, "Pause", 155, 110, 30}
	love.graphics.setCanvas()

	resumebtn = love.graphics.newCanvas(200, 50)
	love.graphics.setCanvas(resumebtn)
	love.graphics.setColor(150, 0, 175)
	love.graphics.rectangle('fill', 0, 0, 200, 50)
	self.btns[0] = {resumebtn, 100, 200, "resume", 160, 215, 20, 1}
	love.graphics.setCanvas()

	exitbtn = love.graphics.newCanvas(200, 50)
	love.graphics.setCanvas(exitbtn)
	love.graphics.setColor(150, 0, 175)
	love.graphics.rectangle('fill', 0, 0, 200, 50)
	self.btns[1] = {exitbtn, 100, 275, "exit", 180, 290, 20, 2}
	love.graphics.setCanvas()

	self:renderbase()
end

function menu:rendergameover()
	self.select = 0
	self.btns = {}
	self.titles = {}

	gameovertitle = love.graphics.newCanvas(200, 50)
	love.graphics.setCanvas(gameovertitle)
	self.titles[0] = {gameovertitle, 100, 200, "Game Over", 115, 210, 30}
	love.graphics.setCanvas()

	playagainbtn = love.graphics.newCanvas(200, 50)
	love.graphics.setCanvas(playagainbtn)
	love.graphics.setColor(150, 0, 175)
	love.graphics.rectangle('fill', 0, 0, 200, 50)
	self.btns[0] = {playagainbtn, 100, 300, "play again", 150, 315, 20, 3}
	love.graphics.setCanvas()

	mainmenubtn = love.graphics.newCanvas(200, 50)
	love.graphics.setCanvas(mainmenubtn)
	love.graphics.setColor(150, 0, 175)
	love.graphics.rectangle('fill', 0, 0, 200, 50)
	self.btns[1] = {mainmenubtn, 100, 375, "exit", 180, 390, 20, 2}
	love.graphics.setCanvas()

	self:renderbase()
end

function menu:rendervictory()
	self.select = 0
	self.btns = {}
	self.titles = {}

	gameovertitle = love.graphics.newCanvas(200, 50)
	love.graphics.setCanvas(gameovertitle)
	self.titles[0] = {gameovertitle, 100, 200, "You Won!", 133, 210, 30}
	love.graphics.setCanvas()

	playagainbtn = love.graphics.newCanvas(200, 50)
	love.graphics.setCanvas(playagainbtn)
	love.graphics.setColor(150, 0, 175)
	love.graphics.rectangle('fill', 0, 0, 200, 50)
	self.btns[0] = {playagainbtn, 100, 300, "play again", 150, 315, 20, 3}
	love.graphics.setCanvas()

	mainmenubtn = love.graphics.newCanvas(200, 50)
	love.graphics.setCanvas(mainmenubtn)
	love.graphics.setColor(150, 0, 175)
	love.graphics.rectangle('fill', 0, 0, 200, 50)
	self.btns[1] = {mainmenubtn, 100, 375, "exit", 180, 390, 20, 2}
	love.graphics.setCanvas()

	self:renderbase()
end

function menu:movesel(direction)
	state = 0
	if direction == "down" then
		love.graphics.setCanvas(self.btns[self.select][1])
		love.graphics.setColor(150, 0, 175)
		love.graphics.rectangle('fill', 0, 0, 200, 50)
		love.graphics.setCanvas()
		if self.select < #self.btns then
			self.select = self.select + 1
		end
		self:renderbase()
	elseif direction == "up" then
		love.graphics.setCanvas(self.btns[self.select][1])
		love.graphics.setColor(150, 0, 175)
		love.graphics.rectangle('fill', 0, 0, 200, 50)
		love.graphics.setCanvas()
		if self.select > 0 then
			self.select = self.select - 1
		end
		self:renderbase()
	elseif direction == "return" then
			state = self.btns[self.select][8]
	end

	return state
end
