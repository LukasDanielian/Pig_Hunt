//Calculates the Ray sphere collision
boolean calculateCollision(PVector rayOrigin, PVector rayDirection, PVector sphereCenter, float sphereRadius)
{
  PVector sphereToRay = PVector.sub(sphereCenter, rayOrigin);
  float projection = PVector.dot(sphereToRay, rayDirection) / PVector.dot(rayDirection, rayDirection);
  PVector closestPointOnRay = PVector.add(rayOrigin, PVector.mult(rayDirection, projection));
  float distance = PVector.dist(closestPointOnRay, sphereCenter);
  return distance < sphereRadius;
}
