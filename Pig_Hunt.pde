import com.jogamp.newt.opengl.GLWindow;

GLWindow r;
boolean[] keys;
boolean mouseLock;
PVector oldMouse;
int offsetX = 0;
int offsetY = 0;
Player player;
World world;
boolean loading = true;

void setup()
{
  fullScreen(P3D);
  shapeMode(CENTER);
  rectMode(CENTER);
  textAlign(CENTER, CENTER);
  imageMode(CENTER);
  frameRate(60);
  textSize(128);
  perspective(PI/2.5, float(width)/height, .01, width * width);

  r=(GLWindow)surface.getNative();
  keys = new boolean[256];
  oldMouse = new PVector(mouseX, mouseY);
  lockMouse();

  thread("loadEverything");
}

void draw()
{
  //Loading screen
  if (loading)
  {
    background(0);
    text("Danielian Softworks®", width/2, height * .01);
    fill(255);
    for(float i = 0; i < TWO_PI; i+= PI/6)
      circle(width/2 + sin(-frameCount * .05 + i) * 100, height/2 + cos(-frameCount * .05 + i) * 100, 15);
  } 
  
  //Game
  else
  {
    background(#16819D);
    lights();
    directionalLight(196,123,76,.75,1,.75);

    player.move();
    world.render();
    renderHUD();
  }
}

//Loads in diff thread
void loadEverything()
{
  loadShape("rock.obj");
  loadShape("pig.obj");
  player = new Player();
  world = new World();
  loading = false;
}
