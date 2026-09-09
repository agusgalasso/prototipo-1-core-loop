```lua
jugador = {
    x = 100,
    y = 400,
    ancho = 40,
    alto = 50,
    velocidad = 250,
    velocidadY = 0,
    salto = -450,
    enSuelo = false,
    vidas = 3
}

enemigo = {
    x = 500,
    y = 450,
    ancho = 40,
    alto = 40,
    velocidad = 120,
    direccion = 1
}

plataforma = {
    x = 0,
    y = 500,
    ancho = 800,
    alto = 50
}

meta = {
    x = 700,
    y = 450,
    ancho = 50,
    alto = 50
}

estadoJuego = "jugando"

tiempoDaño = 0

sonidoSalto = nil
sonidoDaño = nil
sonidoVictoria = nil

function love.load()

    love.window.setMode(800, 600)

    if love.filesystem.getInfo("sonidos/salto.wav") then
        sonidoSalto = love.audio.newSource("sonidos/salto.wav", "static")
    end

    if love.filesystem.getInfo("sonidos/daño.wav") then
        sonidoDaño = love.audio.newSource("sonidos/daño.wav", "static")
    end

    if love.filesystem.getInfo("sonidos/victoria.wav") then
        sonidoVictoria = love.audio.newSource("sonidos/victoria.wav", "static")
    end
end

function love.update(dt)

    if estadoJuego ~= "jugando" then
        return
    end

    if love.keyboard.isDown("right") or love.keyboard.isDown("d") then
        jugador.x = jugador.x + jugador.velocidad * dt
    end

    if love.keyboard.isDown("left") or love.keyboard.isDown("a") then
        jugador.x = jugador.x - jugador.velocidad * dt
    end

    jugador.velocidadY = jugador.velocidadY + 900 * dt

    jugador.y = jugador.y + jugador.velocidadY * dt

    if jugador.y + jugador.alto >= plataforma.y then

        jugador.y = plataforma.y - jugador.alto

        jugador.velocidadY = 0

        jugador.enSuelo = true

    else

        jugador.enSuelo = false

    end

    enemigo.x = enemigo.x + enemigo.velocidad * enemigo.direccion * dt

    if enemigo.x + enemigo.ancho >= 800 then
        enemigo.direccion = -1
    end

    if enemigo.x <= 0 then
        enemigo.direccion = 1
    end

    if colisionan(jugador, enemigo) then

        jugador.vidas = jugador.vidas - 1

        tiempoDaño = 0.5

        if sonidoDaño ~= nil then
            sonidoDaño:stop()
            sonidoDaño:play()
        end

        jugador.x = 100
        jugador.y = 400

        if jugador.vidas <= 0 then
            estadoJuego = "derrota"
        end
    end

    if colisionan(jugador, meta) then

        estadoJuego = "victoria"

        if sonidoVictoria ~= nil then
            sonidoVictoria:play()
        end
    end

    if tiempoDaño > 0 then
        tiempoDaño = tiempoDaño - dt
    end

    if jugador.x < 0 then
        jugador.x = 0
    end

    if jugador.x + jugador.ancho > 800 then
        jugador.x = 800 - jugador.ancho
    end

end

function love.draw()

    love.graphics.clear(0.1, 0.15, 0.25)

    love.graphics.setColor(0.3, 0.7, 0.3)

    love.graphics.rectangle(
        "fill",
        plataforma.x,
        plataforma.y,
        plataforma.ancho,
        plataforma.alto
    )

    love.graphics.setColor(1, 0.8, 0.1)

    love.graphics.rectangle(
        "fill",
        meta.x,
        meta.y,
        meta.ancho,
        meta.alto
    )

    love.graphics.setColor(1, 1, 1)

    love.graphics.print(
        "META",
        meta.x + 5,
        meta.y + 15
    )

    love.graphics.setColor(0.9, 0.2, 0.2)

    love.graphics.rectangle(
        "fill",
        enemigo.x,
        enemigo.y,
        enemigo.ancho,
        enemigo.alto
    )

    if tiempoDaño > 0 then

        love.graphics.setColor(1, 1, 1)

    else

        love.graphics.setColor(0.2, 0.5, 1)

    end

    love.graphics.rectangle(
        "fill",
        jugador.x,
        jugador.y,
        jugador.ancho,
        jugador.alto
    )

    love.graphics.setColor(1, 1, 1)

    love.graphics.print(
        "Vidas: " .. jugador.vidas,
        20,
        20
    )

    love.graphics.print(
        "Mover: A/D o Flechas | Saltar: ESPACIO",
        20,
        45
    )

    if estadoJuego == "victoria" then

        love.graphics.setColor(1, 1, 1)

        love.graphics.printf(
            "¡GANASTE!",
            0,
            250,
            800,
            "center"
        )

        love.graphics.printf(
            "Presiona R para volver a jugar",
            0,
            290,
            800,
            "center"
        )

    end

    if estadoJuego == "derrota" then

        love.graphics.setColor(1, 1, 1)

        love.graphics.printf(
            "¡PERDISTE!",
            0,
            250,
            800,
            "center"
        )

        love.graphics.printf(
            "Presiona R para volver a jugar",
            0,
            290,
            800,
            "center"
        )

    end

end

function love.keypressed(tecla)

    if tecla == "space" and jugador.enSuelo and estadoJuego == "jugando" then

        jugador.velocidadY = jugador.salto

        if sonidoSalto ~= nil then
            sonidoSalto:stop()
            sonidoSalto:play()
        end

    end

    if tecla == "r" then

        reiniciarJuego()

    end

end

function colisionan(a, b)

    return a.x < b.x + b.ancho and
           a.x + a.ancho > b.x and
           a.y < b.y + b.alto and
           a.y + a.alto > b.y

end

function reiniciarJuego()

    jugador.x = 100
    jugador.y = 400
    jugador.velocidadY = 0
    jugador.vidas = 3

    enemigo.x = 500
    enemigo.direccion = 1

    estadoJuego = "jugando"

    tiempoDaño = 0

end
```
