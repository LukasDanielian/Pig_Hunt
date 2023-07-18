class Tower implements Object
{
  PVector pos,rot;
  PShape tower;
  Chunk chunk;
  
  Tower(float x, float z, Chunk chunk)
  { 
    this.chunk = chunk;
    pos = new PVector(random(x - width/2,x + width/2),0,random(z - width/2, z + width/2));
    rot = new PVector(random(-PI,PI),random(-PI,PI),random(-PI,PI));
    tower = loadShape("tower.obj");
    tower.rotateX(PI);
    tower.translate(2,5,0);
    tower.scale(100);
    pos.y = this.chunk.terrain[(int)map(pos.z,this.chunk.z - width/2, this.chunk.z + width/2,0,this.chunk.terrain.length-1)][(int)map(pos.x,this.chunk.x - width/2, this.chunk.x + width/2,0,this.chunk.terrain.length-1)];
  }
  
  //Renders single tower into chunk
  void render()
  {
    push();
    translate(pos.x,pos.y,pos.z);
    noStroke();
    fill(#989795);
    box(2,1000,2);
    shape(tower);
    
    //renders floating E to show button
    textSize(10);
    fill(0);
    for(float i = 0; i < TWO_PI; i+= HALF_PI)
    {
      push();
      translate(sin(i + frameCount * .01) * 15,-75,cos(i + frameCount * .01) * 15);
      rotateY(-player.yaw + HALF_PI);
      text("E",0,0);
      pop();
    }
    pop();
  }
  
  PVector getPos()
  {
    return pos;
  }
  
  float getSize()
  {
    return 0;
  }
  
  int getColor()
  {
    return #362707;
  }
}
