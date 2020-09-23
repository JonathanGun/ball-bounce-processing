class Ball {
  float x = mouseX;
  float y = mouseY;
  float size = 25;
  float mass = 2500;

  float xVel = (width/2-this.x)/5;
  float xAcc = 0;
  float yVel = -this.y/10;
  float yAcc = 1.5;
  float a = (float)Math.atan(this.y-mouseY / this.x-mouseX);

  float ground = 50;
  float groundy = height-this.ground-this.size/2;

  float loss = map(this.size, 30, 100, 0.15, 0.3);

  float shadeX = 0;
  float shadeY = 0;

  float r = 375 - this.size * 5;

  void update() {
    this.yVel += yAcc;
    if (this.yVel <= this.yAcc && this.yVel > 0 && this.y >= this.groundy) {
      this.yVel = 0;
      this.y = this.groundy;
      if (this.xVel > 0) {
        this.xVel -= 0.005 * this.size;
      } else if (this.xVel > 0.1 && this.xVel < 0.1) {
        this.xVel = 0;
      } else {
        this.xVel += 0.005 * this.size;
      }
    }

    if (this.y > this.groundy && this.yVel > 0) {
      this.yVel *= -0.9;
    } else if (this.y - this.size/2 < 0 && this.yVel < 0) {
      this.yVel *= -1;
    }

    if ((this.x + this.size/2 > width && this.xVel > 0) || (this.x - this.size/2 < 0 && this.xVel < 0)) {
      this.xVel = -(1-this.loss) * this.xVel;
    }

    this.y += yVel;
    this.x += xVel;

    this.yVel *= 0.99;
  }

  void launch(){
    this.xVel = (this.x - mouseX)/6 + this.size * cos(a);
    this.yVel = (this.y - mouseY)/4;
    this.mass = this.size * 100;
    totaleffect = 0;
    total++;
  }
  
  void checkCollision(Ball other){
    boolean collide = (this.size/2 + other.size/2) > dist(this.x, this.y, other.x, other.y);
    if (collide){
      if (this.y < other.y && collide){
        this.y = this.y - other.size/2;
      } else if(this.y > other.y && collide) {
        other.y = other.y - this.size/2;
      }
      
      float tempX = 0;
      float tempY = 0;
      float tempX2 = 0;
      float tempY2 = 0;
      
      tempX += this.xVel;
      tempY += this.yVel;
      tempX2 += other.xVel;
      tempY2 += other.yVel;
      
      float deg = (float)Math.atan(this.y-other.y / this.x-other.x);
      
      float num1 = (this.mass-other.mass)/(this.mass+other.mass);
      float num2 = 2*other.mass/(this.mass+other.mass);
      float num3 = 2*this.mass/(this.mass+other.mass);
      
      this.xVel = num1 * tempX + num2 * tempX2 ;
      other.xVel = num3 * tempX - num1 * tempX2 ;
      
      this.yVel = num1 * tempY + num2 * tempY2 ;
      other.yVel = num3 * tempY - num1 * tempY2 ;
      
    }    
  }

  void show() {
    fill(this.r, 200, 0);
    ellipse(this.x, this.y, this.size, this.size);
  }
}