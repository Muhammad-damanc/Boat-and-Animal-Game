class Boat
{
  int x;
  int y;
  int stepX = 5;
  int stepY = 5;
  PImage img1, img2, img3, img4, currentImage;


  Boat(int x, int y)//constructor
  {
    this.x = x;
    this.y = y;
    //Loads images
    img1 = loadImage("Boat.png");
    img2 = loadImage("Boat2.png");
    img3 = loadImage("Boat3.png");
    img4 = loadImage("Boat4.png");

    //Resizes images
    img1.resize(50, 50);
    img2.resize(50, 50);
    img3.resize(50, 50);
    img4.resize(50, 50);

    currentImage = img1;
  }

  void render()//draws the player
  {
    imageMode(CENTER); //draw all PImage from centre
    image(currentImage, x, y);
    displayDebug();
  }

  void displayDebug()
  {
    fill(0);  //debugging : display position
    text("x:"+x + "y:"+y, x - 20, y - 30);
  }

  void move(char direction)
  {
    if (direction== 'U' && y>= stepY)
    {
      currentImage = img1;
    } else if (direction == 'D' && y<= height - stepY)
    {
      currentImage = img3;
    } else if (direction == 'L' && x >= stepX)
    {
      currentImage = img4;
    } else if (direction == 'R' && x <= width - stepX)
    {
      currentImage = img2;
    }
  }


  boolean crash(Animals animal)//Checks whether it's Troe or False that a collision with an animal has occured
  {
    float distance = dist(this.x, this.y, animal.x, animal.y);
    return distance < (currentImage.width/2 + animal.images[0].width/2);
  }
}
