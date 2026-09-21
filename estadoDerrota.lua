EstadoDerrota = {}

function EstadoDerrota.cargar()

end

function EstadoDerrota.actualizar(dt)

end

function EstadoDerrota.dibujar()

    love.graphics.clear(0.2, 0.05, 0.05)

    love.graphics.setColor(1, 0.3, 0.3)

    love.graphics.printf(
        "GAME OVER",
        0,
        220,
        800,
        "center"
    )

    love.graphics.setColor(1, 1, 1)

    love.graphics.printf(
        "Te quedaste sin vidas",
        0,
        270,
        800,
        "center"
    )

    love.graphics.printf(
        "Presiona R para volver a jugar",
        0,
        320,
        800,
        "center"
    )

end

function EstadoDerrota.teclaPresionada(tecla)

    if tecla == "r" then

        Juego.cambiarEstado(EstadoJuego)

    end

end

return EstadoDerrota
