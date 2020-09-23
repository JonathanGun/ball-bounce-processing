import java.lang.Math;

Ball[] balls = new Ball[100];
Effect [] effects = new Effect[200];

int total = 0;
int totaleffect = 0;

void setup() {
  fullScreen();
  noStroke();
}

void mousePressed() {
  if (total<balls.length) {
    balls[total] = new Ball();
  }
}

void draw() {
  background(100, 100, 255);

  float ground = 50;
  fill(100);
  rect(0, height-ground, width, ground);

  if (mousePressed == true) {
    if (totaleffect < 200) {
      balls[total].size += 10/(balls[total].size);
      if (frameCount % 6 == 0) {
        effects[totaleffect] = new Effect();
        totaleffect++;
      }

      fill(balls[total].r, 140, 20);
      balls[total].shadeX = balls[total].x + (balls[total].x - mouseX)*0.3;
      balls[total].shadeY = balls[total].y + (balls[total].y - mouseY)*0.3;
      ellipse(balls[total].shadeX, balls[total].shadeY, balls[total].size, balls[total].size);

      fill(90, 120, 0);
      ellipse(balls[total].x, balls[total].y, 35, 35);

      stroke(255);
      line(mouseX, mouseY, balls[total].x, balls[total].y);
      noStroke();

      for (int i = 0; i < totaleffect; i++) {
        if (effects[i].len < effects[i].size) {
          effects[i] = new Effect();
        }
        effects[i].update();
        effects[i].show();
      }
    } else {
      balls[total].launch();
    }
  }


  for (int i = 0; i < total; i++) {
    balls[i].update();
    for (int j = 1;j < total; j++) {
      balls[i].checkCollision(balls[j]);
    }
    balls[i].show();
  }
}

void mouseReleased() {
  balls[total].launch();
}
