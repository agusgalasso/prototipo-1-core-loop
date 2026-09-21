Proyectil = {}

Proyectil.__index = Proyectil

function Proyectil:Nuevo(x, y)

    local o = setmetatable({}, Proyectil)

    o.x = x
    o.y = y

    o.ancho = 8
    o.alto = 16

    o.velocidad = 450

    o.activo = true

    return o

end

function Proyectil:Actualizar(dt)

    self.y = self.y - (self.velocidad * dt)

    if self.y + self.alto < 0 then
        self.activo = false
    end

end

function Proyectil:ColisionaCon(enemigo)

    return self.x < enemigo.x + enemigo.ancho and
           enemigo.x < self.x + self.ancho and
           self.y < enemigo.y + enemigo.alto and
           enemigo.y < self.y + self.alto

end

function Proyectil:Dibujar()

    love.graphics.setColor(1, 1, 0)

    love.graphics.rectangle(
        "fill",
        self.x,
        self.y,
        self.ancho,
        self.alto
    )

end

return Proyectil
