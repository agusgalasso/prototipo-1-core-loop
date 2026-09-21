Particula = {}

Particula.__index = Particula

function Particula:Nuevo(x, y)

    local o = setmetatable({}, Particula)

    o.x = x
    o.y = y

    o.velocidadX = math.random(-100, 100)
    o.velocidadY = math.random(-100, 100)

    o.tiempo = 0.5

    o.tamaño = math.random(3, 7)

    o.activa = true

    return o

end

function Particula:Actualizar(dt)

    self.x = self.x + (self.velocidadX * dt)
    self.y = self.y + (self.velocidadY * dt)

    self.tiempo = self.tiempo - dt

    if self.tiempo <= 0 then
        self.activa = false
    end

end

function Particula:Dibujar()

    love.graphics.setColor(1, 0.8, 0.1)

    love.graphics.rectangle(
        "fill",
        self.x,
        self.y,
        self.tamaño,
        self.tamaño
    )

end

return Particula
