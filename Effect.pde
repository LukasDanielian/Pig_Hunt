class Effect
{
  PVector pos,vel;
  int col;
  float size;
  
  Effect(PVector pos, int col)
  {
    this.pos = pos.copy();
    this.col = col;
    vel = new PVector(random(-2,2),random(-3,3),random(-2,2));
    size = random(5,15);
  }
  
  //Renders effect when item is destroyed
  void render()
  {
    push();
    translate(pos.x,pos.y,pos.z);
    fill(col);
    noStroke();
    rotateX(frameCount);
    rotateY(frameCount);
    rotateZ(frameCount);
    box(size,1,1);
    box(1,size,1);
    box(1,1,size);
    pop();
    
    pos.add(vel);
    size -= .5;
  }
  
  boolean shouldRemove()
  {
    return size <= 0;
  }
}
