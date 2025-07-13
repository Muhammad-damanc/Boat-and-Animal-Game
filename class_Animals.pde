abstract class Animals
{
  int x, y, stepX = 5, stepY = 5;
  int imageCounter = 0;
  PImage [] images;//Values stored within Variables

  Animals(int x, int y, int numberofImages, String nameofImage, int imageWidth, int imageHeight)//Constructor
  {
    this.x = x;
    this.y = y;
    images = new PImage[numberofImages];
    for (int i = 0; i < numberofImages; i++)//Loads images for the animation
    {
      images[i] = loadImage(nameofImage + (i+1) + ".png");
      images[i].resize(imageWidth, imageHeight);
    }
  }

  void update()
  {
    move();
    render();
  }

  void move()
  {
    x -= random(2, 5);//move left
    // if animal goes off screen, reset the x to width
    if (x < 0-images[0].width) {
      x = width;
    }
  }

  void render()
  {
    imageMode(CENTER); //draw all PImage from centre
    int imageNumber = imageCounter/10 % images.length;
    image( images [imageNumber], x, y);
    imageCounter++;
    if (imageCounter > 20)
      displayDebug();
  }

  void displayDebug()
  {
    fill(0);  //debugging : display position
    int textX = x-images[0].width/2;
    int textY = y-images[0].height/2;
    text("x:"+x + "y:"+y, textX, textY);
  }
}
