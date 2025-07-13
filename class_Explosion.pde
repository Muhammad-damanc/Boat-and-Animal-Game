class Explosion
{
  int x, y;
  PImage exp;
  
  Explosion(int x, int y)
  {
    this.x = x;
    this.y = y;
    exp = loadImage("explosion.png");
    exp.resize(100,100);
  }
  
    void render()//draws the player
  { 
    image(exp, x, y);
  }
}
