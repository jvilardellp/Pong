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

const Ball = struct {
    centerX: f32,
    centerY: f32,
    radio: f32,

    pub fn init(centerX: f32, centerY: f32, radio: f32) @This() {
        return .{
            .centerX = centerX,
            .centerY = centerY,
            .radio = radio,
        };
    }

    pub fn draw(self: @This()) void {
        rl.drawCircle(
            @intFromFloat(self.centerX),
            @intFromFloat(self.centerY),
            self.radio,
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
    var ball: Ball = Ball.init(
        @as(f32, @floatFromInt(screenWidth - 65)),
        // @as(f32, @floatFromInt(screenWidth)) / 4 * 3,
        @as(f32, @floatFromInt(screenHeight)) / 2,
        10.0,
    );

    while (!rl.windowShouldClose()) {
        rl.beginDrawing();
        rl.endDrawing();

        // 1. Entrada de usuario (Input)

        // 2. Actualización de física (Update)
        // TODO: Verificar colisiones, prueba del sistema de colisiones con la paleta del jugador.
        // Modificar esta parte mas adelante para verificar colisiones con la paleta de la máquina
        // y con las paredes.
        const ballPosition = rl.Vector2{
            .x = ball.centerX,
            .y = ball.centerY,
        };
        const ballRadius = ball.radio;
        const paddlePlayerRect = rl.Rectangle{
            .x = paddlePlayer.positionX,
            .y = paddlePlayer.positionY,
            .width = paddlePlayer.width,
            .height = paddlePlayer.height,
        };

        if (rl.checkCollisionCircleRec(ballPosition, ballRadius, paddlePlayerRect)) {
            rl.drawText("Colisión con paleta del jugador", 10, screenHeight - 30, 20, white);
        } else {
            rl.drawText("No hay colisión", 10, screenHeight - 30, 20, white);
        }

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

        // Dibujar bola
        ball.draw();
    }
}
