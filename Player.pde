class Player
{
  float yaw, pitch, speed, yMover;
  PVector pos, lastPos, view;
  int chunkX, chunkZ;
  boolean jumping;
  Weapon weapon;

  public Player()
  {
    pos = new PVector(0, 0, 0);
    yaw = HALF_PI;
    speed = .05;
    weapon = new Weapon();
  }

  //Moves players position and view
  void move()
  {
    if (!focused && mouseLock)
      unlockMouse();

    //Bound
    if (mouseLock)
    {
      yaw += (mouseX-offsetX-width/2.0)*.001;
      pitch += (mouseY-offsetY-height/2.0)*.001;
      r.setPointerVisible(false);
      r.warpPointer(width/2, height/2);
      r.confinePointer(true);
    }

    //Not bound
    else
    {
      r.confinePointer(false);
      r.setPointerVisible(true);
    }

    offsetX=offsetY=0;
    pitch = constrain(pitch, -HALF_PI + 0.0001, HALF_PI- .0001);
    lastPos = pos.copy();
    view = new PVector(cos(yaw) * cos(pitch), -sin(pitch), sin(yaw) * cos(pitch)).mult(-width * .1);
    camera(pos.x, pos.y, pos.z, pos.x + view.x, pos.y + view.y, pos.z + view.z, 0, 1, 0);
    weapon.render(pos);
    buttons();
    checkBounds();
    Chunk chunk = world.getCurrentChunk();

    //jumping
    if (jumping)
    {
      pos.y += yMover;
      yMover++;

      if (pos.y > map(noise(((chunk.noiseScl * (chunk.terrain.length/2)) + ((pos.x/chunk.scl) * chunk.noiseScl)), ((chunk.noiseScl * (chunk.terrain.length/2)) + ((pos.z/chunk.scl) * chunk.noiseScl))), 0, 1, -400, 400) -75)
      {
        pos.y = map(noise(((chunk.noiseScl * (chunk.terrain.length/2)) + ((pos.x/chunk.scl) * chunk.noiseScl)), ((chunk.noiseScl * (chunk.terrain.length/2)) + ((pos.z/chunk.scl) * chunk.noiseScl))), 0, 1, -400, 400) -75;
        yMover = 0;
        jumping = false;
      }
    } 
    
    //walking
    else
      pos.y = map(noise(((chunk.noiseScl * (chunk.terrain.length/2)) + ((pos.x/chunk.scl) * chunk.noiseScl)), ((chunk.noiseScl * (chunk.terrain.length/2)) + ((pos.z/chunk.scl) * chunk.noiseScl))), 0, 1, -400, 400) -75;
  }

  //Checks if bottons were clicked
  void buttons()
  {
    if (keyPressed)
    {
      if (keyDown('W'))
      {
        pos.x += view.x * speed;
        pos.z += view.z * speed;
      }
      if (keyDown('S'))
      {
        pos.x -= view.x * speed;
        pos.z -= view.z * speed;
      }
      if (keyDown('A'))
      {
        pos.x -= cos(yaw - PI/2) * cos(pitch) * 10;
        pos.z -= sin(yaw - PI/2) * cos(pitch) * 10;
      }
      if (keyDown('D'))
      {
        pos.x += cos(yaw - PI/2) * cos(pitch) * 10;
        pos.z += sin(yaw - PI/2) * cos(pitch) * 10;
      }
      if (keyDown(' '))
      {
        jump();
      }
    }
  }

  //Checks if player enters new chunk
  void checkBounds()
  {
    Chunk chunk = world.getCurrentChunk();

    if (pos.x < chunk.x - width/2)
      chunkX--;
    else if (pos.x > chunk.x + width/2)
      chunkX++;
    else if (pos.z < chunk.z - width/2)
      chunkZ--;
    else if (pos.z > chunk.z + width/2)
      chunkZ++;
    else
      return;

    world.updateChunks();
  }

  void attack()
  {
    weapon.swing();
  }

  void jump()
  {
    if (!jumping)
    {
      jumping = true;
      yMover = -12.5;
    }
  }
}
