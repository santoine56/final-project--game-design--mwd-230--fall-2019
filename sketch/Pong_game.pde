//source code made by Tanay Singhal(https://www.youtube.com/playlist?list=PLf5zPS-STiK8JoDStTZFnYsjoJ61Ssa4I)
//modified and adapted by Senait Antoine
//initializes variables
int x, y, ellipse_width, ellipse_height, speedX, speedY;
int paddleX_Left, paddleY_Left, paddleW, paddleH, paddleLSpeed, paddleRSpeed, paddleX_Right, paddleY_Right;
boolean upLeft, downLeft, upRight, downRight;
//stores color values for left paddle and right paddle 
color colorLeft = color(4, 89, 0);
color colorRight = color(0, 0, 232);
//intializes scores for the player and opponent
int scoreLeft = 0;
int scoreRight = 0;

int winScore = 3;

void setup() {
 size(600, 600);

 x = width / 2;
 y = height / 2;
 ellipse_width = 30;
 ellipse_height = 30;
 speedX = 3;
 speedY = 2;

 textSize(20);
 textAlign(CENTER, CENTER);

 rectMode(CENTER);
 //player's paddle (Left side)
 paddleX_Left = 50;
 paddleY_Left = height / 2;
 paddleW = 15;
 paddleH = 100;
 paddleLSpeed = 5;

 //opponent's paddle (Right side)
 paddleX_Right = width - 50;
 paddleY_Right = height / 2;
 paddleW = 15;
 paddleH = 100;
 paddleRSpeed = 2;
}

void draw() {
 background(0);
 //modifiers for ball of poison
 drawEllipse();
 moveEllipse();
 ricochetEllipse();
 //modifiers for paddle
 drawPaddles();
 movePaddle();
 restrictPaddle();
 contactPaddle();
 //modifier for score count and game over simulation
 scores();
 gameOver();
}
void drawPaddles() {
 //draws left paddle
 fill(0, 255, 0);
 rect(paddleX_Left, paddleY_Left, paddleW, paddleH);
 //draws right paddle
 fill(20, 30, 205);
 rect(paddleX_Right, paddleY_Right, paddleW, paddleH);
}

void movePaddle() {
 if (upLeft) {
  paddleY_Left = paddleY_Left - paddleLSpeed;
 }
 if (downLeft) {
  paddleY_Left = paddleY_Left + paddleLSpeed;
 }
 //creates the illusion of a CPU experience
 if (upLeft) {
  paddleY_Right = paddleY_Right + paddleRSpeed;
 }
 if (downLeft) {
  paddleY_Right = paddleY_Right - paddleRSpeed;
 }
}
//prevents paddle from going beyond the canvas
void restrictPaddle() {
 if (paddleY_Left - paddleH / 2 < 0) {
  paddleY_Left = paddleY_Left + paddleLSpeed;
 }
 if (paddleY_Left + paddleH / 2 > height) {
  paddleY_Left = paddleY_Left - paddleLSpeed;
 }
 if (paddleY_Right - paddleH / 2 < 0) {
  paddleY_Right = paddleY_Right + paddleRSpeed;
 }
 if (paddleY_Right + paddleH / 2 > height) {
  paddleY_Right = paddleY_Right - paddleRSpeed;
 }
}

void contactPaddle() {
 //code for making the ellipse bounce off paddles
 //left collision
 if (x - ellipse_width / 2 < paddleX_Left + paddleW / 2 && y - ellipse_height / 2 < paddleY_Left + paddleH / 2 && y + ellipse_height / 2 > paddleY_Left - paddleH / 2) {
  if (speedX < 0) {
   speedX = -speedX;
  }
 }
 //right collision
 else if (x + ellipse_width / 2 > paddleX_Right - paddleW / 2 && y - ellipse_height / 2 < paddleY_Right + paddleH / 2 && y + ellipse_height / 2 > paddleY_Right - paddleH / 2) {
  if (speedX > 0) {
   speedX = -speedX;
  }
 }
}
void drawEllipse() {
 fill(100, 0, 155);
 ellipse(x, y, ellipse_width, ellipse_height);
}

void moveEllipse() {
 x = x + speedX;
 y = y + speedY;
}

void ricochetEllipse() {
 //enables the ellipse to bounce off walls and calculates score if ellipse hits the wall
 if (x > width - ellipse_width / 2) {
  setup();
  speedX = -speedX;
  scoreLeft = scoreLeft + 1;
 } else if (x < 0 + ellipse_width / 2) {
  setup();
  scoreRight = scoreRight + 1;
 }

 if (y > height - ellipse_height / 2) {
  speedY = -speedY;
 } else if (y < 0 + ellipse_height / 2) {
  speedY = -speedY;
 }
}

void scores() {
 fill(255);
 text(scoreLeft, 100, 50);
 text(scoreRight, width - 100, 50);
}

void gameOver() {
 if (scoreLeft == winScore) {
  gameOverScreen("Maryjane wins!", colorLeft);
 }
 if (scoreRight == winScore) {
  gameOverScreen("Prince Venomax wins!", colorRight);
 }
}

void gameOverScreen(String text, color c) {
 //stops ball from moving
 speedX = 0;
 speedY = 0;
 //stops paddles from moving
 paddleLSpeed = 0;
 paddleRSpeed = 0;

 fill(255, 0, 0);
 text("GAME OVER", width / 2, height / 3 - 40);
 fill(0, 0, 255);
 text("Please press 2 to play level 2, press 3 for level 3 ", width / 2, height / 3 + 40);
 fill(c);
 text(text, width / 2, height / 3);

 if (key == '2') {
  scoreRight = 0;
  scoreLeft = 0;
  speedX = 4;
  speedY = 3;
  winScore = 4;
 }
 if (key == '3') {
  scoreRight = 0;
  scoreLeft = 0;
  speedX = 5;
  speedY = 6;
  winScore = 5;
 }
}

void keyPressed() {
 if (key == CODED) {
  if (keyCode == UP) {
   upLeft = true;
  }
  if (key == CODED) {
   if (keyCode == DOWN) {
    downLeft = true;
   }
  }
 }
}
//code for checking if 'up' or 'down' keys have been released
void keyReleased() {
 if (key == CODED) {
  if (keyCode == UP) {
   upLeft = false;
  }
  if (key == CODED) {
   if (keyCode == DOWN) {
    downLeft = false;
   }
  }
 }
}
