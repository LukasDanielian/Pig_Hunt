//Loads in diff thread
void loadEverything()
{
  loadShape("rock.obj");
  loadShape("pig.obj");
  loadShape("cactus.obj");
  loadShape("tower.obj");
  player = new Player();
  world = new World();
}

//Loads all next possible chunks in thread to avoid lag
void loadNextChunks()
{
  int[] DEPTH_DISP = {0, 1, 2, 2, 2, 2, 2, 1, 0, -1, -2, -2, -2, -2, -2, -1};
  int[] HORIZ_DISP = {-2, -2, -2, -1, 0, 1, 2, 2, 2, 2, 2, 1, 0, -1, -2, -2};

  for (int i = 0; i < DEPTH_DISP.length; i++)
  {
    Chunk chunk = world.chunks.get(world.cordString(player.chunkX + HORIZ_DISP[i], player.chunkZ + DEPTH_DISP[i]));

    //brand new chunk
    if (chunk == null)
    {
      chunk = new Chunk(player.chunkX + HORIZ_DISP[i], player.chunkZ + DEPTH_DISP[i]);
      
      synchronized(player)
      {
        world.chunks.put(world.cordString(player.chunkX + HORIZ_DISP[i], player.chunkZ + DEPTH_DISP[i]), chunk);
      }
    }
  }
  
  loading = false;
}
