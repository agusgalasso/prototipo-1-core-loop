Enemigo = {}

Enemigo.__index = Enemigo

function Enemigo:Nuevo(x, y, tipo)

    local o = setmetatable({}, Enemigo)

    o.x = x
    o.y = y

    o.ancho = 35
    o.alto = 35

    o.tipo = tipo

    o.vivo = true

    if tipo == "normal" then

        o.velocidad = 70
        o.vida = 1

    elseif tipo == "rapido" then

        o.velocidad = 140
        o.vida = 1

    elseif tipo == "tanque" then

        o.velocidad = 45
        o.vida = 3
        o.ancho = 50
        o.alto = 50

    end

    return o

end

function Enemigo:Actualizar(x, y, dt)

    local distanciaX = math.abs(self.x - x)
    local distanciaY = math.abs(self.y - y)

    if distanciaX > distanciaY then

        if self.x < x then
            self.x = self.x + (self.velocidad * dt)
        elseif self.x > x then
            self.x = self.x - (self.velocidad * dt)
        end

    else

        if self.y < y then
            self.y = self.y + (self.velocidad * dt)
        elseif self.y > y then
            self.y = self.y - (self.velocidad * dt)
        end

    end

end

function Enemigo:RecibirDaño()

    self.vida = self.vida - 1

    if self.vida <= 0 then
        self.vivo = false
        return true
    end

    return false

end

function Enemigo:ColisionaCon(jugador)

    return self.x < jugador.x + jugador.ancho and
           jugador.x < self.x + self.ancho and
           self.y < jugador.y + jugador.alto and
           jugador.y < self.y + self.alto

end

function Enemigo:Dibujar()

    if self.tipo == "normal" then

        love.graphics.setColor(1, 0.2, 0.2)

    elseif self.tipo == "rapido" then

        love.graphics.setColor(1, 0.6, 0.1)

    elseif self.tipo == "tanque" then

        love.graphics.setColor(0.7, 0.2, 0.8)

    end

    love.graphics.rectangle(
        "fill",
        self.x,
        self.y,
        self.ancho,
        self.alto
    )

end