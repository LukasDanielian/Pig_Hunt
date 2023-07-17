class Rock implements Object
{
  PVector pos,rot;
  PShape rock;
  Chunk chunk;
  
  Rock(float x, float z, Chunk chunk)
  { 
    this.chunk = chunk;
    pos = new PVector(random(x - width/2,x + width/2),0,random(z - width/2, z + width/2));
    rot = new PVector(random(-PI,PI),random(-PI,PI),random(-PI,PI));
    rock = loadShape("rock.obj");
    rock.translate(30,70,-20);
    rock.scale(random(1,5));
    pos.y = this.chunk.terrain[(int)map(pos.z,this.chunk.z - width/2, this.chunk.z + width/2,0,this.chunk.terrain.length-1)][(int)map(pos.x,this.chunk.x - width/2, this.chunk.x + width/2,0,this.chunk.terrain.length-1)];
  }
  
  //Renders single rock into chunk
  void render()
  {
    push();
    translate(pos.x,pos.y,pos.z);
    rotateX(rot.x);
    rotateY(rot.x);
    rotateZ(rot.x);
    shape(rock);
    pop();
  }
  
  PVector getPos()
  {
    return pos;
  }
  
  float getSize()
  {
    return rock.width;
  }
  
  int getColor()
  {
    return 120;
  }
}
