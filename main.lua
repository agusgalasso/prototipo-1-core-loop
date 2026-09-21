Jugador = require("Jugador")
Enemigo = require("Enemigo")
Proyectil = require("Proyectil")
Particula = require("Particula")

EstadoMenu = require("Estados.EstadoMenu")
EstadoJuego = require("Estados.EstadoJuego")
EstadoVictoria = require("Estados.EstadoVictoria")
EstadoDerrota = require("Estados.EstadoDerrota")

Juego = {
    estado = nil
}

function love.load()

    love.window.setMode(800, 600)
    love.window.setTitle("CORE LOOP")

    Juego.cambiarEstado(EstadoMenu)

end

function Juego.cambiarEstado(nuevoEstado)

    Juego.estado = nuevoEstado

    if Juego.estado.cargar ~= nil then
        Juego.estado.cargar()
    end

end

function love.update(dt)

    if Juego.estado ~= nil and Juego.estado.actualizar ~= nil then
        Juego.estado.actualizar(dt)
    end

end

function love.draw()

    if Juego.estado ~= nil and Juego.estado.dibujar ~= nil then
        Juego.estado.dibujar()
    end

end

function love.keypressed(tecla)

    if Juego.estado ~= nil and Juego.estado.teclaPresionada ~= nil then
        Juego.estado.teclaPresionada(tecla)
    end

end

function love.keyreleased(tecla)

    if Juego.estado ~= nil and Juego.estado.teclaLiberada ~= nil then
        Juego.estado.teclaLiberada(tecla)
    end

end
