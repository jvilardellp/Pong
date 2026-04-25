// 1 - IMPORTACIONES
const std = @import("std");
const rl = @import("raylib");

// 2. CONSTANTES Y CONFIGURACIÓN
// Definir: Ancho/Alto de pantalla, velocidad de la bola, velocidad de paletas,
// colores, tamaños de las paletas, etc. (Evita "números mágicos").
const screenWidth = 800;
const screenHeight = 600;
const black = rl.Color.black;
const white = rl.Color.white;
const sizeFontNet = 30;

// 3. ESTRUCTURAS DE DATOS (Modelos)
// Definir los 'objetos' del juego:
// - Estructura Paddle (posición, dimensiones, velocidad)
// - Estructura Ball (posición, velocidad, radio)
// - Estructura Game State (puntuación, estado de pausa, objetos de arriba)

// 4. LÓGICA DE NEGOCIO (Funciones de utilidad)
// Funciones puras que no dibujan, solo calculan:
// - update Paddle(paddle, input_key)
// - update Ball(ball, paddle de la máquina, paddle del jugador)
// - check Collisions(ball, paddle de la máquina, paddle del jugador)
// - reset Ball(ball)

// 5. LÓGICA DE RENDER (Funciones de dibujo)
// Funciones que usan RayLib para pintar en pantalla:
// - draw Game(state)
// - draw Score(state)

pub fn main() !void {
    // Inicialización ventana
    rl.initWindow(screenWidth, screenHeight, "Pong Game");
    defer rl.closeWindow();

    // Inicialización del estado del juego (configuración Estado del juego)
    rl.setTargetFPS(60);

    while (!rl.windowShouldClose()) {
        rl.beginDrawing();
        rl.endDrawing();

        // 1. Entrada de usuario (Input)

        // 2. Actualización de física (Update)

        // 3. Dibujado (Draw)
        rl.clearBackground(black);

        // TODO: Eliminar las lineas de referencia una vez terminado el juego.
        rl.drawLine(screenWidth / 2, 0, screenWidth / 2, screenHeight, rl.Color.red);
        rl.drawLine(screenWidth / 4, 0, screenWidth / 4, screenHeight, rl.Color.red);
        rl.drawLine((screenWidth / 4) * 3, 0, (screenWidth / 4) * 3, screenHeight, rl.Color.red);
        rl.drawLine(0, screenHeight / 2, screenWidth, screenHeight / 2, rl.Color.red);

        // Dibujar red
        for (0..screenHeight / (sizeFontNet * 2)) |i| {
            const y: i32 = @intCast(i * 60);
            rl.drawText("|", screenWidth / 2, y, sizeFontNet, white);
        }
    }
}
