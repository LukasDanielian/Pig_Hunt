class World
{
  HashMap<String, Chunk> chunks;
  int[] DEPTH_DISP = {-1, -1, -1, 0, 0, 0, 1, 1, 1};
  int[] HORIZ_DISP = {-1, 0, 1, -1, 0, 1, -1, 0, 1};

  public World()
  {
    chunks = new HashMap<String, Chunk>();
    updateChunks();
  }

  //renders 9 chunks including current and all adjecent chunks
  void render()
  {
    for (int i = 0; i < DEPTH_DISP.length; i++)
    {
      Chunk chunk = chunks.get(cordString(player.chunkX + HORIZ_DISP[i], player.chunkZ + DEPTH_DISP[i]));
      chunk.render();
    }

    //Sun
    push();
    translate(player.pos.x - width, -width * 2, player.pos.z - width);
    noLights();
    noStroke();
    fill(#FFEA00);
    rotateX(HALF_PI);
    circle(0, 0, width/4);
    lights();
    pop();
  }

  //resets center chunk and adds new chunks if needed
  void updateChunks()
  {
    synchronized(chunks)
    {
      for (int i = 0; i < DEPTH_DISP.length; i++)
      {
        Chunk chunk = chunks.get(cordString(player.chunkX + HORIZ_DISP[i], player.chunkZ + DEPTH_DISP[i]));

        //brand new chunk
        if (chunk == null)
        {
          chunk = new Chunk(player.chunkX + HORIZ_DISP[i], player.chunkZ + DEPTH_DISP[i]);
          chunks.put(cordString(player.chunkX + HORIZ_DISP[i], player.chunkZ + DEPTH_DISP[i]), chunk);
        }
      }
    }

    thread("loadNextChunks");
  }

  //returns current chunk of player
  Chunk getCurrentChunk()
  {
    return chunks.get(cordString(player.chunkX, player.chunkZ));
  }

  //formats into string for hash map
  String cordString(int x, int z)
  {
    return x + "x" + z;
  }
}
