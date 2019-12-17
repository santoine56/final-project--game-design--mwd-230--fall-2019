//declarations
int x, y, ellipse_width, ellipse_height, speedX, speedY;
int paddleX_Left, paddleY_Left, paddleL_Width, paddleL_Height, paddleL_Speed;
int paddleX_Right, paddleY_Right, paddleR_Width, paddleR_Height, paddleR_Speed;
boolean left_Up, left_Down;
void setup() {
    size(500, 500);
    
    x = width / 2;
    y = height / 2;
    ellipse_width = 30;
    ellipse_height = 30;
    speedX = 2;
    speedY = 1;

    rectMode(CENTER);
    //player's paddle (Left side)
    paddleX_Left = 50;
    paddleY_Left = height / 2;
    paddleL_Width = 15;
    paddleL_Height = 100;
    paddleL_Speed = 5;
    //opponent's paddle (Right side)
    paddleX_Right = width - 50;
    paddleY_Right = height / 2;
    paddleR_Width = 15;
    paddleR_Height = 100;
    paddleR_Speed = 5;
}

void draw() {
    //modifiers for ball of poison
    drawEllipse();
    moveEllipse();
    ricochetEllipse();
    //modifiers for paddle
    drawPaddle();
    movePaddle();
    restrictPaddle();
    contactPaddle();
    //modifier for score count and game over simulation
    scores();
    gameOver();
}

void drawPaddle() {
    fill(0, 255, 0);
    rect(paddleX_Left, paddleY_Left, paddleL_Width, paddleL_Height);
    fill(20, 30, 205);
    rect(paddleX_Right, paddleY_Right, paddleR_Width, paddleR_Height);
}

void movePaddle() {
    if (left_Up) {
        paddleY_Left = paddleY_Left - paddleL_Speed;
    }
    if (left_Down) {
        paddleY_Left = paddleY_Left + paddleL_Speed;
    }
}
//prevents paddle from going beyond the canvas.
void restrictPaddle() {
    if (paddleY_Left - paddleL_Height / 2 < 0) {
        paddleY_Left = paddleY_Left + paddleL_Speed;
    }
    if (paddleY_Left + paddleL_Height / 2 > height) {
        paddleY_Left = paddleY_Left - paddleL_Speed;
    }
     if (paddleY_Right - paddleR_Height / 2 < 0) {
        paddleY_Right = paddleY_Right + paddleL_Speed;
    }
    if (paddleY_Right + paddleR_Height / 2 > height) {
        paddleY_Right = paddleY_Right - paddleL_Speed;
    }
}
void contactPaddle() {
  //code for making the ellipse bounce off paddles
  if (x - paddleL_Width/2 < paddleX_Left + paddleL_Width/2 && paddleY_Left - height/2 < paddleY_Left + paddleL_Height/2 && paddleY_Left + height/2 > paddleY_Left - paddleL_Height/2) {
    speedX = -speedX;
  }
  if (x - paddleR_Width/2 < paddleX_Right + paddleR_Width/2 && paddleY_Right - height/2 < paddleY_Right + paddleR_Height/2 && paddleY_Right + height/2 > paddleY_Right - paddleR_Height/2) {
    speedX = -speedX;
  }
  
}
void drawEllipse() {
    //code for drawing the ellipse
    background(0);
    fill(0, 0, 255);
    ellipse(x, y, ellipse_width, ellipse_height);
}

void moveEllipse() {
    //code for the ellipse to move around
    x = x + speedX;
    y = y + speedY;
}

void ricochetEllipse() {
    //enables the ellipse to bounce off walls 
    if (x > width - ellipse_width / 2) {
        speedX = -speedX;
    } else if (x < 0 + ellipse_width / 2) {
        speedX = -speedX;
    }

    if (y > height - ellipse_height / 2) {
        speedY = -speedY;
    } else if (y < 0 + ellipse_height / 2) {
        speedY = -speedY;
    }
}
//code for checking if 'up' or 'down' keys have been pressed
void keyPressed() {
    if (key == CODED) {
        if (keyCode == UP) {
            left_Up = true;
        }
        if (key == CODED) {
            if (keyCode == DOWN) {
                left_Down = true;
            }
        }
    }
}
//code for checking if 'up' or 'down' keys have been released
void keyReleased() {
    if (key == CODED) {
        if (keyCode == UP) {
            left_Up= false;
        }
        if (key == CODED) {
            if (keyCode == DOWN) {
                left_Down = false;
            }
        }
    }
}
