class Chunk
{
  int x, z;
  float noiseX, noiseZ, noiseScl;
  int scl, size;
  float[][] terrain;
  ArrayList<Object> objects;
  ArrayList<Effect> effects;

  Chunk(int x, int z)
  {
    size = width;
    scl = 30;
    noiseScl = .015;
    terrain = new float[(size/scl) + 1][(size/scl) + 1];
    noiseX = x * (noiseScl * (terrain.length-1));
    noiseZ = z * (noiseScl * (terrain.length-1));
    this.x = x * width;
    this.z = z * width;
    objects = new ArrayList<Object>();
    effects = new ArrayList<Effect>();

    //Sets terrain for chunk
    for (int row = 0; row < terrain.length; row++)
    {
      noiseX = x * (noiseScl * (terrain.length-1));
      for (int col = 0; col < terrain.length; col++)
      {
        terrain[row][col] = map(noise(noiseX, noiseZ), 0, 1, -400, 400);
        noiseX += noiseScl;
      }
      noiseZ += noiseScl;
    }

    //Add items randomly
    objects.add(new Rock(this.x, this.z, this));
    objects.add(new Pig(this.x, this.z, this));
    
    if((int)random(0,5) == 0)
      objects.add(new Cactus(this.x,this.z,this));
      
    if(int(random(0,10)) == 0)
      objects.add(new Tower(this.x,this.z,this));
  }

  //Draws everything in chunk
  void render()
  {
    //render objects
    for (int i = 0; i < objects.size(); i++)
      objects.get(i).render();

    //render effects
    for (int i = 0; i < effects.size(); i++)
    {
      Effect effect = effects.get(i);
      effect.render();

      if (effect.shouldRemove())
      {
        effects.remove(i);
        i--;
      }
    }

    //Render ground terrain
    shapeMode(NORMAL);
    push();
    translate(x - size/2, 0, z - size/2);
    for (int row = 0; row < terrain.length-1; row++)
    {
      beginShape(TRIANGLE_STRIP);
      for (int col = 0; col < terrain.length; col++)
      {
        fill(map(terrain[row][col], -200, 200, 255, 50));
        noStroke();
        vertex(col*scl, terrain[row][col], row*scl);
        vertex(col*scl, terrain[row+1][col], (row+1)*scl);
      }
      endShape();
    }
    pop();
    shapeMode(CENTER);
  }

  //Checks if object is hit by player
  void checkHit()
  {
    for (int i = 0; i < objects.size(); i++)
    {
      Object object = objects.get(i);
      PVector pos = object.getPos();

      //hitscan and distance used
      if (dist(pos.x, pos.y, pos.z, player.pos.x, player.pos.y, player.pos.z) <= 100 + object.getSize() && calculateCollision(new PVector(player.pos.x, player.pos.y, player.pos.z), player.view, new PVector(pos.x, pos.y, pos.z), object.getSize()))
      {
        //add effects
        for(int j = 0; j < 25; j++)
          effects.add(new Effect(pos,object.getColor()));
          
        objects.remove(i);
        i--;
      }
    }
  }
}
