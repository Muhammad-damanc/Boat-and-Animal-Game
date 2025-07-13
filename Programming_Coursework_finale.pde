// Gloabl variables - objects of the classes
ArrayList<Animals> animalList;
enum Screen {
  MENU,
  GAMEPLAY,
  GAMEOVER
}
Boat player;
Explosion explosion;
int explosionTimer = 0;
int spawner = 0;
int timer = 0;
int currentscore = 0;
int highscore = 0;
String highscoreFile = "highscore.txt";
Screen currentScreen = Screen.MENU;
PImage backGround; //background variables
int bgX = 0;

void setup()//Initalise animals and player
{
  size(800, 500);
  backGround = loadImage("sea.jpg");
  backGround.resize(width, height);
 
  player = new Boat(width/2, height/2);
  animalList = new ArrayList<Animals>();

  // adds the aditional animals into the game
  animalList.add(new Crocodile(200, 200));
  animalList.add(new Shark(300, 200));
  animalList.add(new Crocodile(500, 250));
  animalList.add(new Shark(700, 100));
  highscore = loadHighScore();
}

int loadHighScore()
{
  String[] lines = loadStrings(highscoreFile);
  if (lines != null && lines.length > 0)
  {
    return int(lines[0]);
  }
  return 0;
}


void draw()// draws the animals and player
{
  if (currentScreen == Screen.MENU)
  {
    showSplashScreen();
  } else if (currentScreen == Screen.GAMEPLAY)
  {
    gameplay();
  } else if (currentScreen == Screen.GAMEOVER)
  {
    gameOver();
  }
}

void showSplashScreen()
{
  background(255, 0, 0);
  fill(0);
  textSize(50);
  text("Boat Game", 300, 250);
  text("Press any key to start", 200, 400);
}

void gameplay()
{
   scrollBackground();
  player.render();//gets player on the screen
  for (int i = 0; i < animalList.size(); i++)//iterates through the list of animals
  {
    Animals animal = animalList.get(i);//gets the current animal
    animal.update();//renders and moves the animal

    if (player.crash(animal))//condition set for if the animal crashes
    {
      explosion = new Explosion(animal.x, animal.y);
      explosionTimer = 30;
      explosion.render();
      animalList.remove(i);//removes animal from the list
      currentScreen = Screen.GAMEOVER;
      i--;
      break;
    }
  }

  if (explosion != null && explosionTimer > 0)//renders the explosion if active
  {
    explosion.render();
    explosionTimer--;
    if (explosionTimer == 0)
    {
      explosion = null;// removes explosion when the timer ends
      currentScreen = Screen.GAMEOVER;
    }
  }

  timer++;
  if (timer % 60 == 0)
  {
    currentscore++;//current score goes up as time goes up
  }

  displayScore();

  spawner++;//increments the spawner timer
  if (spawner >= 300)
  {
    spawner = 0;
    add();//spawns a new animal
  }

  if (currentscore > highscore)//checks if the currentscore is higher than the higherscore
  {
    highscore = currentscore;
    saveHighScore();
  }
}

void gameOver()
{
  background(255, 255, 0);
  fill(255, 0, 0);
  textSize(50);
  text("Game Over", 300, 250);
  text("Press any key to retry", 200, 400);
}


void displayScore()//displays both the current score and high score
{
  fill(255);
  textSize(20);
  text("Score: " + currentscore, 10, 30);
  text("High Score: " + highscore, 10, 60);
}


void add()//adds new animals
{
  if (random(1) < 0.5)
  {
    animalList.add(new Crocodile((int)random(width), (int) random(height)));//adds new crocodile at a random position
    animalList.add(new Shark((int)random(width), (int) random(height)));//adds new shark at a random position
  }
}

void keyPressed()//runs once the key is pressed
{
  if (currentScreen == Screen.MENU || currentScreen == Screen.GAMEOVER)
  {
    currentScreen = Screen.GAMEPLAY;
    currentscore = 0;
    animalList.clear();
    spawner = 0;
    add();
  }

  if (key == 'Q')
  {
    saveHighScore();
    exit();
  }

  if (keyCode==UP)//if key presses is up the boat faces upwards
  {
    player.move('U');
  } else if (keyCode==DOWN)// if keypressed is down the boat faces downwards
  {
    player.move('D');
  } else if (keyCode==LEFT)// if keypressed is left the boat faces the left handside
  {
    player.move('L');
  } else if (keyCode==RIGHT)//if keypressed is right theboat faces the right handside
  {
    player.move('R');
  }
  for (Animals animal : animalList)
  {
    if (keyCode == UP)//if the up key is pressed the crocodile goes downwards
    {
      animal.y = animal.y + animal.stepY;
    } else if (keyCode == DOWN)//if the down key is pressed crocodile goes upwards
    {
      animal.y = animal.y - animal.stepY;
    } else if (keyCode == LEFT)//if the left key is pressed the crocodile moves to the right
    {
      animal.x = animal.x + animal.stepX;
    } else if (keyCode == RIGHT)//if the left key is pressed the crocodile moves to the left
    {
      animal.x = animal.x - animal.stepX;
    }

    if  (animal instanceof Shark)
    {
      Shark shark = (Shark) animal;
      if (keyCode == UP)// if the key pressed is up than the shark goes up
      {
        shark.key('U');
      } else if (keyCode == DOWN)// if key pressed is down than the shark goes down
      {
        shark.key('D');
      } else if (keyCode == LEFT)//if keypressed is left than the shark moves left
      {
        shark.key('L');
      } else if (keyCode == RIGHT)//if key pressed is right than the shark moves right
      {
        shark.key('R');
      }
    }
  }
}

void saveHighScore()//Saves the high score
{
  String[] lines = { str(highscore) };
  saveStrings(highscoreFile, lines);
}

void scrollBackground()
{
  imageMode(CORNER); //draw background from top left
  image(backGround, bgX, 0); //draw background twice
  image(backGround, bgX+backGround.width, 0);
  bgX -=4; //move background 4 pixels to left
  if (bgX == -backGround.width) {
    bgX=0; //wrap background
  }
}
