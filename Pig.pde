class Pig implements Object
{
  PShape pig;
  PVector pos, pointing;
  Chunk chunk;
  float speed;

  Pig(float x, float z, Chunk chunk)
  {
    this.chunk = chunk;
    pig = loadShape("pig.obj");
    pig.scale(25);
    pig.setFill(color(#B261A3));
    pig.translate(25, -20, -10);
    pig.rotateX(PI);
    pos = new PVector(x + random(-width/4, width/4), 0, z + random(-width/4, width/4));
    pointing = new PVector(0, 1).normalize();
    speed = random(2,7);
  }

  //Renders pig into chunk
  void render()
  {
    push();
    translate(pos.x, pos.y, pos.z);
    rotateY(pointing.heading() - HALF_PI);
    shape(pig);
    pop();

    //Movement random based on noise at location
    pointing.rotate(map(noise(pos.x * .015, pos.z * .015), 0, 1, -PI/25, PI/25));
    pos.x += pointing.x * speed;
    pos.z -= pointing.y * speed;
    pos.y = map(noise(((chunk.noiseScl * (chunk.terrain.length/2)) + ((pos.x/chunk.scl) * chunk.noiseScl)), ((chunk.noiseScl * (chunk.terrain.length/2)) + ((pos.z/chunk.scl) * chunk.noiseScl))), 0, 1, -400, 400) -40;
    checkBounds();
  }

  //Checks if pig tries to move into a different chunk
  void checkBounds()
  {
    Chunk nextChunk = null;

    //Gets next chunk
    if (pos.x < chunk.x - width/2)
      nextChunk = world.chunks.get(((chunk.x/width)-1) + "x" + chunk.z/width);
    else if (pos.x > chunk.x + width/2)
      nextChunk = world.chunks.get(((chunk.x/width)+1) + "x" + chunk.z/width);
    else if (pos.z < chunk.z - width/2)
      nextChunk = world.chunks.get(chunk.x/width + "x" + ((chunk.z/width)-1));
    else if (pos.z > chunk.z + width/2)
      nextChunk = world.chunks.get(chunk.x/width + "x" + ((chunk.z/width)+1));
    else
      return;
   
    //Bounce if chunk not already discovered
    if (nextChunk == null)
    {
      pointing.rotate(PI);
      pos.x += pointing.x * speed;
      pos.z -= pointing.y * speed;
    }
    
    //Change control to other chunk if already discovered 
    else
    {
      chunk.objects.remove(this);
      nextChunk.objects.add(this);
      chunk = nextChunk;
    }
  }

  PVector getPos()
  {
    return pos;
  }

  float getSize()
  {
    return pig.width;
  }

  int getColor()
  {
    return #B261A3;
  }
}
