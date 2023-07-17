class Weapon
{
  float dist, zMover;
  boolean attacking;

  //Renders weapon onto screen
  void render(PVector pos)
  {
    push();
    translate(pos.x, pos.y, pos.z);
    rotateY(-player.yaw + HALF_PI);
    rotateX(player.pitch);
    translate(5,5,dist);
    fill(#391B0F);
    box(1, 1, 50);
    translate(0,0,-25);
    rotateX(-HALF_PI);
    rotateY(HALF_PI);
    fill(#A0A0A0);
    triangle(-1,0,1,0,0,25);
    pop();
    
    dist += zMover;
    zMover++;
    
    if(dist > 0)
    {
      dist = 0;
      attacking = false;
    }
  }
  
  //Starts stabbing animation
  void swing()
  {
    if(!attacking)
    {
      zMover = -7.5;
      attacking = true;
      world.getCurrentChunk().checkHit();
    }
  }
}
