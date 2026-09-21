EstadoVictoria = {}

function EstadoVictoria.cargar()

end

function EstadoVictoria.actualizar(dt)

end

function EstadoVictoria.dibujar()

    love.graphics.clear(0.05, 0.2, 0.08)

    love.graphics.setColor(0.3, 1, 0.3)

    love.graphics.printf(
        "¡VICTORIA!",
        0,
        220,
        800,
        "center"
    )

    love.graphics.setColor(1, 1, 1)

    love.graphics.printf(
        "Eliminaste 15 enemigos",
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

function EstadoVictoria.teclaPresionada(tecla)

    if tecla == "r" then

        Juego.cambiarEstado(EstadoJuego)

    end

end

return EstadoVictoria
