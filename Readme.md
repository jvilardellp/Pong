```markdown
# 🏓 Proyecto: Pong Clone (Zig + Raylib)

Este documento detalla las etapas de desarrollo para la creación de un clon de Pong utilizando el lenguaje **Zig** y la librería 
**Raylib**.

## 🎯 Objetivo del Proyecto
Crear una versión funcional, modular y eficiente del clásico juego Pong, enfocándose en el aprendizaje de la gestión de memoria en 
Zig y el bucle de juego (game loop) con Raylib.

---

## 🚀 Plan de Desarrollo

### 🏁 Etapa 1: El Lienzo (Setup & Window)
*   [X] **Configuración del Entorno:** Configurar `build.zig` para enlazar correctamente Raylib.
*   [X] **Inicialización de la Ventana:** Crear el `main.zig` con la estructura básica.

*   [X] **El Bucle de Vida:** Implementar el Game Loop principal (`WindowShouldClose`).
*   **Hito:** Una ventana negra de resolución fija que se abre y se cierra sin errores.

### 🎭 Etapa 2: Los Actores (Entities & Rendering)
*   [X] **Definición de Modelos:** Crear los `structs` para `Paddle` y `Ball`.
*   [X] **Renderizado Estático:** Dibujar las paletas (rectángulos) y la bola (círculo o cuadrado) en posiciones fijas.
*   [X] **Gestión de Constantes:** Centralizar tamaños, colores y velocidades en un bloque de constantes.
*   **Hito:** Ver los elementos del juego en pantalla, aunque no se muevan.

### 🏃 Etapa 3: El Movimiento (Input & Update)
*   [X] **Sistema de Input:** Implementar la lectura de teclado (`IsKeyDown`) para las paletas.
*   [X] **Lógica de Actualización:** Crear funciones que actualicen la posición `y` de las paletas según el input.
*   [ ] **Movimiento de la Bola:** Implementar la lógica de velocidad constante para la bola en cada frame.
*   **Hito:** Poder controlar las paletas con el teclado y ver la bola desplazarse.

### ⚖️ Etapa 4: La Física (Collisions)
*   [ ] **Rebote de Paredes:** Implementar la detección de colisiones con los bordes superior e inferior.
*   [ ] **Colisión con Paletas:** Implementar la lógica de rebote cuando la bola toca los rectángulos de las paletas.
*   [ ] **Inversión de Vector:** Asegurar que la dirección de la bola cambie correctamente tras un impacto.
*   **Hito:** La bola rebota de forma infinita dentro del área de juego sin salirse de los bordes.

### 🏆 Etapa 5: El Reglamento (Game Logic & Score)
*   [ ] **Detección de Goles:** Implementar la lógica de "fuera de límites" (izquierda/derecha).
*   [ ] **Sistema de Puntuación:** Crear una variable de estado para llevar el marcador de ambos jugadores.
*   [ ] **Reset de Juego:** Función para reposicionar la bola en el centro tras un punto.
*   [ ] **Interfaz de Usuario (UI):** Dibujar el texto del marcador en la parte superior de la pantalla.
*   **Hito:** Un juego completo donde se pueden ganar y perder puntos.

### ✨ Etapa 6: El Pulido (Polish & Audio)
*   [ ] **Efectos de Sonido:** Integrar sonidos simples (bip) para colisiones y anotaciones.
*   [ ] **Estética Visual:** Añadir la línea divisoria central y mejorar los colores.
*   [ ] **Game Over State:** Añadir una pantalla de fin de juego o reinicio rápido.
*   **Hito:** Un juego con "jugosidad" (juice) y experiencia de usuario terminada.

---

## 🛠️ Stack Tecnológico
*   **Lenguaje:** [Zig](https://ziglang.org/)
*   **Librería Gráfica:** [Raylib](https://www.raylib.com/)
*   **Build System:** Zig Build System (`build.zig`)
```
