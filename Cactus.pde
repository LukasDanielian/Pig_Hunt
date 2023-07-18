class Cactus implements Object
{
  PVector pos,rot;
  PShape cactus;
  Chunk chunk;
  
  Cactus(float x, float z, Chunk chunk)
  { 
    this.chunk = chunk;
    pos = new PVector(random(x - width/2,x + width/2),0,random(z - width/2, z + width/2));
    cactus = loadShape("cactus.obj");
    cactus.rotateX(PI/2);
    cactus.translate(30,200,0);
    pos.y = this.chunk.terrain[(int)map(pos.z,this.chunk.z - width/2, this.chunk.z + width/2,0,this.chunk.terrain.length-1)][(int)map(pos.x,this.chunk.x - width/2, this.chunk.x + width/2,0,this.chunk.terrain.length-1)] - 50;
  }
  
  //Renders single cactus into chunk
  void render()
  {
    push();
    translate(pos.x,pos.y,pos.z);
    shape(cactus);
    pop();
  }
  
  PVector getPos()
  {
    return pos;
  }
  
  float getSize()
  {
    return cactus.width;
  }
  
  int getColor()
  {
    return #0F2C06;
  }
}
