class Effect {
  float len = random(balls[total].size, balls[total].size*2);
  float a = random(PI);
  float aVel = random(0, PI/10);
  float aAcc = 5/(this.len*this.len);

  float x = balls[total].shadeX + cos(a)*this.len;
  float y = balls[total].shadeY + sin(a)*this.len;

  float speed = 0.5;
  float size = random(3, balls[total].size/4);

  float r = random(100, 170);

  void update() {
    this.aVel += this.aAcc;
    this.a += this.aVel;
    this.len -= this.speed;
    this.x = balls[total].shadeX + cos(a)*this.len;
    this.y = balls[total].shadeY + sin(a)*this.len;
  }

  void show() {
    fill(this.r, 15, 5);
    ellipse(this.x, this.y, this.size, this.size);
  }
}