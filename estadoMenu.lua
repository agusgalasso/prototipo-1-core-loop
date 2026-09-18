EstadoMenu = {}

function EstadoMenu.cargar()

end

function EstadoMenu.actualizar(dt)

end

function EstadoMenu.dibujar()

    love.graphics.clear(0.05, 0.05, 0.12)

    love.graphics.setColor(1, 1, 1)

    love.graphics.printf(
        "JUEGO PROCEDURAL",
        0,
        180,
        800,
        "center"
    )

    love.graphics.printf(
        "Elimina 15 enemigos para ganar",
        0,
        230,
        800,
        "center"
    )

    love.graphics.printf(
        "Flechas o WASD para moverte",
        0,
        270,
        800,
        "center"
    )

    love.graphics.printf(
        "ESPACIO para disparar",
        0,
        300,
        800,
        "center"
    )

    love.graphics.printf(
        "Presiona ENTER para comenzar",
        0,
        360,
        800,
        "center"
    )

end

function EstadoMenu.teclaPresionada(tecla)

    if tecla == "return" then
        Juego.cambiarEstado(EstadoJuego)
    end

end