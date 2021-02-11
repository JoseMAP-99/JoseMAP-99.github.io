
var pingPong, knockBall, gameOver;

var sizeX;

var sizeY;

var supXPala, supYPala, infXPala, infYPala, jump, sizePala;

var tableX, tableY, border, rounds;

var cx, cy, incY, incX, radius, fastBall, randDir;

// false para parado, true para ejecutando
var running, pauseGame, upWin;

// Variables centrado del marcador superior
var middleX;

var middleYSup;

// Variables centrado del marcador inferior
var middleYInf;

var scoreSup, scoreInf;

function setup() {
    initializeFields(); 
    createCanvas(sizeX, sizeY);
   
    // Tablero
    border = 20;
    tableX = sizeX - (2 * border);
    tableY = sizeY - (2 * border);

    //Sonido
    pingPong = loadSound("sounds/ping-pong.mp3");
    gameOver = loadSound("sounds/game-over.mp3");
    knockBall = loadSound("sounds/knock-ball.mp3");
}

function resetScore() {
    scoreSup = 0;
    scoreInf = 0;
}

function selectPlayer() {
    // Bola
    cx = int(random(border + radius, sizeX - border - radius));
    if (!upWin) {
        // infXPala + sizePala/2;
        cy = infYPala - radius;
        incY = -fastBall;
    } else {
        // supXPala + sizePala/2;
        cy = supYPala + 10 + radius;
        incY = fastBall;
    }
    incX = randDir * fastBall;
    randDir = -1 * randDir;
}

function resetGame() {
    // Palas
    sizePala = 80;
    supXPala = (sizeX / 2) - (sizePala / 2);
    supYPala = border;
    infXPala = (sizeX / 2) - (sizePala / 2);
    infYPala = tableY + 10;
    // Velocidad de palas
    jump = 20;
    radius = 10;
    fastBall = 3;
    selectPlayer();
}

function drawBoard() {
    // Fondo de juego
    background(223, 184, 125);
    textSize(12);
    // Texto de ayuda
    text("Presione R para reiniciar, P para pausar o iniciar", (sizeX / 2) - 130, border / 2 + 5);
    // Fondo de mesa
    fill(125, 171, 223);
    // Color de trazado de mesa
    stroke(255);
    // Forma de mesa
    rect(border, border, tableX, tableY);
    // Trazado de mesa
    line(sizeX / 2, border, sizeX / 2, sizeY - 20);
    // Color de trazado de separación de mesa
    fill(125, 223, 125);
    // Trazado de separación de mesa
    rect(border, (sizeY / 2) - 5, tableX, 10);
}

function drawPala() {
    // Color de pala
    fill(255, 0, 0);
    // Pala superior
    rect(supXPala, supYPala, sizePala, 10);
    // Pala inferior
    rect(infXPala, infYPala, sizePala, 10);
}

function drawBall() {
    fill(255);
    circle(cx, cy, radius * 2);
}

function drawScore() {
    fill(255);
    textSize(60);
    text(scoreSup, middleX - 30, middleYSup + 30);
    text(scoreInf, middleX - 30, middleYInf + 30);
    text("P1", (sizeX - middleX) - 30, middleYSup + 30);
    text("P2", (sizeX - middleX) - 30, middleYInf + 30);
}

function draw() {
    if (pauseGame) {
        textSize(40);
        fill(255, 0, 0);
        text("PAUSA", (sizeX / 2) - 64, (sizeY / 2) + 14);
        return;
    }
    if (!running) {
        var roundsNumber = prompt("¿Cuántas rondas desea?", "5"); 
        if (roundsNumber == null) return;
        if (!roundsNumber.match("\\d+")) return; 
        rounds = parseInt(roundsNumber);
        if (rounds <= 0) return;
        resetGame();
        resetScore();
        running = true;
    }

    if (running) {
        drawBoard();
        drawPala();
        drawBall();
        drawScore();
        cy += incY;
        cx += incX;
        if (cy - radius <= supYPala + 10 && cx >= supXPala && cx <= supXPala + sizePala || cy + radius >= infYPala && cx >= infXPala && cx <= infXPala + sizePala) {
            incY = -incY;
            pingPong.play();
        } else if (cx + radius >= sizeX - border || cx - radius <= border) {
            incX = -incX;
            knockBall.play();
        } else if (cx + radius >= supXPala && cx - radius <= supXPala + sizePala && cy - radius <= supYPala + 10 || cx + radius >= infXPala && cx - radius <= infXPala + sizePala && cy + radius >= infYPala) {
            incX = -incX;
            incY = -incY;
            pingPong.play();
        } else if (cy < border || cy > sizeY - border) {
            if (cy < border) {
                scoreInf++;
                upWin = true;
            } else {
                scoreSup++;
                upWin = false;
            }
            gameOver.play();	    
            if (scoreSup == rounds || scoreInf == rounds) {
                var message;
                if (scoreSup == rounds) {
                    message = "Ha ganado el jugador 1";
                } else {
                    message = "Ha ganado el jugador 2";
                }
                alert(message);
                running = false;
                return;
            }
            resetGame();
            drawBoard();
            drawPala();
            drawBall();  
            drawScore();          
            pauseGame = true;
        }
    }
}

function keyPressed() {
    if (__keyIsCoded()) {
        if (keyCode == LEFT_ARROW) {
            if (infXPala > border)
                infXPala -= jump;
        } else if (keyCode == RIGHT_ARROW) {
            if (infXPala + sizePala < sizeX - border)
                infXPala += jump;
        }
    } else {
        if (key == 'A' || key == 'a') {
            if (supXPala > border)
                supXPala -= jump;
        } else if (key == 'D' || key == 'd') {
            if (supXPala + sizePala < sizeX - border)
                supXPala += jump;
        } else if (key == 'R' || key == 'r') {
            pauseGame = false;
            resetGame();
        } else if (key == 'P' || key == 'p') {
            pauseGame = !pauseGame;
        }
    }
}

function initializeFields() {
    pingPong = null;
    knockBall = null;
    gameOver = null;
    sizeX = 400;
    sizeY = 500;
    supXPala = 0;
    supYPala = 0;
    infXPala = 0;
    infYPala = 0;
    jump = 0;
    sizePala = 0;
    tableX = 0;
    tableY = 0;
    border = 0;
    rounds = 0;
    cx = 0;
    cy = 0;
    incY = 0;
    incX = 0;
    radius = 0;
    fastBall = 0;
    randDir = -1;
    running = false;
    pauseGame = false;
    upWin = false;
    middleX = (sizeX / 2) + (sizeX / 2) / 2;
    middleYSup = (sizeY / 2) - (sizeY / 2) / 2;
    middleYInf = (sizeY / 2) + (sizeY / 2) / 2;
    scoreSup = 0;
    scoreInf = 0;
}

function __keyIsCoded() {
    return keyCode == BACKSPACE || keyCode == DELETE || keyCode == ENTER || keyCode == RETURN || keyCode == TAB || keyCode == ESCAPE || keyCode == SHIFT || keyCode == CONTROL || keyCode == OPTION || keyCode == ALT || keyCode == UP_ARROW || keyCode == DOWN_ARROW || keyCode == LEFT_ARROW || keyCode == RIGHT_ARROW;
}

