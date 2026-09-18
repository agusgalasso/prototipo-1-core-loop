Jugador = {}

Jugador.__index = Jugador

function Jugador:Nuevo()

    local o = setmetatable({}, Jugador)

    o.x = 380
    o.y = 280

    o.ancho = 40
    o.alto = 40

    o.velocidad = 250

    o.vidas = 3

    o.invulnerable = false
    o.tiempoInvulnerable = 0

    return o

end

function Jugador:Actualizar(dt)

    if love.keyboard.isDown("left") or love.keyboard.isDown("a") then
        self.x = self.x - (self.velocidad * dt)
    end

    if love.keyboard.isDown("right") or love.keyboard.isDown("d") then
        self.x = self.x + (self.velocidad * dt)
    end

    if love.keyboard.isDown("up") or love.keyboard.isDown("w") then
        self.y = self.y - (self.velocidad * dt)
    end

    if love.keyboard.isDown("down") or love.keyboard.isDown("s") then
        self.y = self.y + (self.velocidad * dt)
    end

    if self.x < 0 then
        self.x = 0
    end

    if self.x + self.ancho > 800 then
        self.x = 800 - self.ancho
    end

    if self.y < 70 then
        self.y = 70
    end

    if self.y + self.alto > 600 then
        self.y = 600 - self.alto
    end

    if self.invulnerable then

        self.tiempoInvulnerable =
            self.tiempoInvulnerable - dt

        if self.tiempoInvulnerable <= 0 then
            self.invulnerable = false
        end

    end

end

function Jugador:RecibirDaño()

    if self.invulnerable then
        return false
    end

    self.vidas = self.vidas - 1

    self.invulnerable = true
    self.tiempoInvulnerable = 1.5

    return true

end

function Jugador:Dibujar()

    if self.invulnerable then

        if math.floor(self.tiempoInvulnerable * 10) % 2 == 0 then
            love.graphics.setColor(1, 1, 1)
        else
            love.graphics.setColor(0.2, 0.5, 1)
        end

    else

        love.graphics.setColor(0.2, 0.5, 1)

    end

    love.graphics.rectangle(
        "fill",
        self.x,
        self.y,
        self.ancho,
        self.alto
    )

end