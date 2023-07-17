//Draws 2D info 
void renderHUD()
{
  push();
  camera();
  hint(DISABLE_DEPTH_TEST);
  fill(0);
  textSize(15);
  textAlign(LEFT,CENTER);
  text("Frame Rate: " + frameRate,width/2,-height/10);
  textAlign(CENTER);
  
  
  noStroke();
  fill(0);
  rect(width/2,height/2,25,2);
  rect(width/2,height/2,2,25);
  hint(ENABLE_DEPTH_TEST);
  pop();
}
