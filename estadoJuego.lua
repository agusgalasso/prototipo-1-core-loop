EstadoJuego = {}

EstadoJuego.jugador = nil
EstadoJuego.enemigos = {}
EstadoJuego.proyectiles = {}
EstadoJuego.particulas = {}

EstadoJuego.eliminados = 0

EstadoJuego.tiempoGeneracion = 0
EstadoJuego.intervaloGeneracion = 1.5

EstadoJuego.tiempoPartida = 0

function EstadoJuego.cargar()

    EstadoJuego.jugador = Jugador:Nuevo()

    EstadoJuego.enemigos = {}
    EstadoJuego.proyectiles = {}
    EstadoJuego.particulas = {}

    EstadoJuego.eliminados = 0

    EstadoJuego.tiempoGeneracion = 0
    EstadoJuego.intervaloGeneracion = 1.5

    EstadoJuego.tiempoPartida = 0

end

function EstadoJuego.actualizar(dt)

    EstadoJuego.tiempoPartida =
        EstadoJuego.tiempoPartida + dt

    EstadoJuego.jugador:Actualizar(dt)

    EstadoJuego.generarEnemigo(dt)

    EstadoJuego.actualizarProyectiles(dt)

    EstadoJuego.actualizarEnemigos(dt)

    EstadoJuego.actualizarParticulas(dt)

    EstadoJuego.comprobarColisiones()

    EstadoJuego.actualizarDificultad()

    if EstadoJuego.jugador.vidas <= 0 then

        Juego.cambiarEstado(EstadoDerrota)

    end

    if EstadoJuego.eliminados >= 15 then

        Juego.cambiarEstado(EstadoVictoria)

    end

end

function EstadoJuego.generarEnemigo(dt)

    EstadoJuego.tiempoGeneracion =
        EstadoJuego.tiempoGeneracion + dt

    if EstadoJuego.tiempoGeneracion <
       EstadoJuego.intervaloGeneracion then

        return

    end

    EstadoJuego.tiempoGeneracion = 0

    local lado = math.random(1, 4)

    local x
    local y

    if lado == 1 then

        x = math.random(0, 760)
        y = 70

    elseif lado == 2 then

        x = math.random(0, 760)
        y = 560

    elseif lado == 3 then

        x = 0
        y = math.random(70, 560)

    else

        x = 760
        y = math.random(70, 560)

    end

    local numeroTipo = math.random(1, 10)

    local tipo

    if numeroTipo <= 6 then

        tipo = "normal"

    elseif numeroTipo <= 9 then

        tipo = "rapido"

    else

        tipo = "tanque"

    end

    local enemigo = Enemigo:Nuevo(
        x,
        y,
        tipo
    )

    table.insert(
        EstadoJuego.enemigos,
        enemigo
    )

end

function EstadoJuego.actualizarDificultad()

    if EstadoJuego.eliminados >= 5 then

        EstadoJuego.intervaloGeneracion = 1.2

    end

    if EstadoJuego.eliminados >= 10 then

        EstadoJuego.intervaloGeneracion = 0.9

    end

end

function EstadoJuego.actualizarProyectiles(dt)

    for i = #EstadoJuego.proyectiles, 1, -1 do

        local proyectil =
            EstadoJuego.proyectiles[i]

        proyectil:Actualizar(dt)

        if not proyectil.activo then

            table.remove(
                EstadoJuego.proyectiles,
                i
            )

        end

    end

end

function EstadoJuego.actualizarEnemigos(dt)

    for i = 1, #EstadoJuego.enemigos do

        local enemigo =
            EstadoJuego.enemigos[i]

        if enemigo.vivo then

            enemigo:Actualizar(
                EstadoJuego.jugador.x,
                EstadoJuego.jugador.y,
                dt
            )

        end

    end

end

function EstadoJuego.actualizarParticulas(dt)

    for i = #EstadoJuego.particulas, 1, -1 do

        local particula =
            EstadoJuego.particulas[i]

        particula:Actualizar(dt)

        if not particula.activa then

            table.remove(
                EstadoJuego.particulas,
                i
            )

        end

    end

end

function EstadoJuego.comprobarColisiones()

    for i = #EstadoJuego.enemigos, 1, -1 do

        local enemigo =
            EstadoJuego.enemigos[i]

        if enemigo.vivo then

            if enemigo:ColisionaCon(
                EstadoJuego.jugador
            ) then

                local recibioDano =
                    EstadoJuego.jugador:RecibirDano()

                if recibioDano then

                    enemigo.vivo = false

                    EstadoJuego.crearParticulas(
                        enemigo.x,
                        enemigo.y
                    )

                end

            end

        end

    end

    for i = #EstadoJuego.proyectiles, 1, -1 do

        local proyectil =
            EstadoJuego.proyectiles[i]

        if proyectil.activo then

            for j = #EstadoJuego.enemigos, 1, -1 do

                local enemigo =
                    EstadoJuego.enemigos[j]

                if enemigo.vivo then

                    if proyectil:ColisionaCon(enemigo) then

                        proyectil.activo = false

                        local destruido =
                            enemigo:RecibirDano()

                        if destruido then

                            EstadoJuego.eliminados =
                                EstadoJuego.eliminados + 1

                            EstadoJuego.crearParticulas(
                                enemigo.x,
                                enemigo.y
                            )

                            table.remove(
                                EstadoJuego.enemigos,
                                j
                            )

                        end

                        break

                    end

                end

            end

        end

    end

end

function EstadoJuego.crearParticulas(x, y)

    for i = 1, 8 do

        local particula =
            Particula:Nuevo(x, y)

        table.insert(
            EstadoJuego.particulas,
            particula
        )

    end

end

function EstadoJuego.dibujar()

    love.graphics.clear(0.05, 0.05, 0.12)

    love.graphics.setColor(0.12, 0.12, 0.2)

    love.graphics.rectangle(
        "fill",
        0,
        60,
        800,
        540
    )

    EstadoJuego.jugador:Dibujar()

    for i = 1, #EstadoJuego.enemigos do

        EstadoJuego.enemigos[i]:Dibujar()

    end

    for i = 1, #EstadoJuego.proyectiles do

        EstadoJuego.proyectiles[i]:Dibujar()

    end

    for i = 1, #EstadoJuego.particulas do

        EstadoJuego.particulas[i]:Dibujar()

    end

    love.graphics.setColor(1, 1, 1)

    love.graphics.print(
        "Vidas: " ..
        EstadoJuego.jugador.vidas,
        20,
        20
    )

    love.graphics.print(
        "Enemigos: " ..
        EstadoJuego.eliminados ..
        " / 15",
        180,
        20
    )

    love.graphics.print(
        "WASD/Flechas: mover | ESPACIO: disparar",
        400,
        20
    )

end

function EstadoJuego.teclaPresionada(tecla)

    if tecla == "space" then

        local proyectil =
            Proyectil:Nuevo(
                EstadoJuego.jugador.x +
                EstadoJuego.jugador.ancho / 2 - 4,

                EstadoJuego.jugador.y
            )

        table.insert(
            EstadoJuego.proyectiles,
            proyectil
        )

    end

end

function EstadoJuego.teclaLiberada(tecla)

end

return EstadoJuego
