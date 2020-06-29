bullets = {}

start = Time.time
gforcemult = 1
timer = 0

Arena.ResizeImmediate(350, 350)
Player.MoveTo(0,0,false)

xposcurrent = -Arena.width/2
xposgoal = -Arena.width/2

function lerp(a,b,t)
	return (1-t)*a + t*b
end

function makeBullet(x, y, goalx)
	local b = CreateProjectile("pellet", x, y)
	b.SetVar("goalX",goalx)
	b.SetVar("startX",x)
	b.SetVar("createTime",curr)
	b.SetVar("basex",goalx)
	b.SetVar("basey",y)
	table.insert(bullets, b)
end

function SpawnNew()
	xposgoal = (Arena.width/2) - (Arena.width * curr)
	while xposcurrent < xposgoal do
		for i= -Arena.height/2*0.8,Arena.height/2*0.8,Arena.height/2*0.4 do
			makeBullet(-Arena.width/2,i,xposcurrent)
		end
		xposcurrent = xposcurrent + 8
	end
end


timetomove = 2.0
function MoveDown()
	for i,b in pairs(bullets) do
		local created = b.GetVar("createTime")
		local goalX = b.GetVar("goalX")
		local startX = b.GetVar("startX")
		local diff = (curr - created)/timetomove
		if (diff) <= 1 then
		
			local t = 1 - (1-diff)*(1-diff)
			b.MoveTo(lerp(startX, goalX,t),b.y)
		end
	end
end

LERPTIME = 0.8
function Sine(x,y,t)
	if (t < LERPTIME) then
		local lerptime = t/LERPTIME
		local results = Sine(x,y,LERPTIME)
		return {lerp(0,results[1],lerptime),lerp(0,results[2],lerptime)}
	else
		t = t - LERPTIME
		return {20*math.sin(t*0.5*math.pi-(x*math.pi/300)),40*math.sin(t*0.5*math.pi-(x*math.pi/300))}
	end
end

function Wave(offsetFunction)
	for i,b in pairs(bullets) do
		local x = b.GetVar("basex")
		local y = b.GetVar("basey")
		local result = offsetFunction(x,y,curr-wavestart)
		b.MoveTo(x+result[1],y+result[2])
	end
end


wavestart = 3
function Update()
	curr = Time.time - start
	if curr < 1 then
		SpawnNew()
	end
	if curr < 3 then
		MoveDown()
	end
	if curr > wavestart then
		Wave(Sine)
	end
end
 
function OnHit(bullet)
	Player.Hurt(2,0.2)
	Audio.PlaySound('hit')
end