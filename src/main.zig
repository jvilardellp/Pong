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
const sizeFontScore = 60;
const paddleWidth = 10;
const paddleHeight = 60;

// 3. ESTRUCTURAS DE DATOS (Modelos)
// Definir los 'objetos' del juego:
// - Estructura Paddle (posición, dimensiones, velocidad)
// - Estructura Ball (posición, velocidad, radio)
// - Estructura Game State (puntuación, estado de pausa, objetos de arriba)
const GameState = struct {
    // Reservamos 2 bytes: el carácter y el terminador nulo \0.
    // El tipo [2:0]u8 significa "un slice que termina en cero".
    scoreBufferMachine: [2:0]u8 = .{ '0', 0 },
    scoreBufferPlayer: [2:0]u8 = .{ '0', 0 },

    pub fn getScoreStringMachine(self: *GameState) [:0]const u8 {
        // Retornamos el slice del buffer que es parte de la estructura
        return self.scoreBufferMachine[0..];
    }

    pub fn getScoreStringPlayer(self: *GameState) [:0]const u8 {
        // Retornamos el slice del buffer que es parte de la estructura
        return self.scoreBufferPlayer[0..];
    }
};

const Paddle = struct {
    positionX: f32,
    positionY: f32,
    width: f32,
    height: f32,
    speed: f32,

    pub fn init(positionX: f32, positionY: f32, width: f32, height: f32) @This() {
        return .{
            .positionX = positionX,
            .positionY = positionY,
            .width = width,
            .height = height,
            .speed = 10.0,
        };
    }

    pub fn draw(self: @This()) void {
        rl.drawRectangle(
            @intFromFloat(self.positionX),
            @intFromFloat(self.positionY),
            @intFromFloat(self.width),
            @intFromFloat(self.height),
            white,
        );
    }
};

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
    var gameState = GameState{};
    var paddleMachine: Paddle = Paddle.init(
        @as(f32, @floatFromInt(50)),
        @as(f32, @floatFromInt(screenHeight)) / 2 - @as(f32, @floatFromInt(paddleHeight)) / 2,
        paddleWidth,
        paddleHeight,
    );
    var paddlePlayer: Paddle = Paddle.init(
        @as(f32, @floatFromInt(screenWidth - 60)),
        @as(f32, @floatFromInt(screenHeight)) / 2 - @as(f32, @floatFromInt(paddleHeight)) / 2,
        paddleWidth,
        paddleHeight,
    );

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

        // Dibujar puntuación máquina y jugador
        rl.drawText(
            gameState.getScoreStringMachine(),
            (screenWidth / 4) - (sizeFontScore / 4),
            30,
            sizeFontScore,
            white,
        );
        rl.drawText(
            gameState.getScoreStringPlayer(),
            (screenWidth / 4) * 3 - (sizeFontScore / 4),
            30,
            sizeFontScore,
            white,
        );

        // Dibujar paletas
        paddleMachine.draw();
        paddlePlayer.draw();
    }
}
