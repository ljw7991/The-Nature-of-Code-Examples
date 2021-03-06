// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Attraction

// A class for a draggable attractive body in our world

class Attractor {
  float mass;    // Mass, tied to size
  float G;       // Gravitational Constant
  PVector pos;   // position
  boolean dragging = false; // Is the object being dragged?
  boolean rollover = false; // Is the mouse over the ellipse?
  PVector drag;  // holds the offset for when object is clicked on

  Attractor(PVector l_,float m_, float g_) {
    pos = l_.get();
    mass = m_;
    G = g_;
    drag = new PVector(0.0,0.0);
  }

  void go() {
    render();
    drag();
  }

  PVector attract(Crawler c) {
    PVector dir = PVector.sub(pos,c.pos);        // Calculate direction of force
    float d = dir.mag();                              // Distance between objects
    d = constrain(d,5.0,25.0);                        // Limiting the distance to eliminate "extreme" results for very close or very far objects
    dir.normalize();                                  // Normalize vector (distance doesn't matter here, we just want this vector for direction)
    float force = (G * mass * c.mass) / (d * d); // Calculate gravitional force magnitude
    dir.mult(force);                                  // Get force vector --> magnitude * direction
    return dir;
  }

  // Method to display
  void render() {
    ellipseMode(CENTER);
    stroke(0,100);
    if (dragging) fill (50);
    else if (rollover) fill(100);
    else fill(175,50);
    ellipse(pos.x,pos.y,mass*2,mass*2);
  }

  // The methods below are for mouse interaction
  void clicked(int mx, int my) {
    float d = dist(mx,my,pos.x,pos.y);
    if (d < mass) {
      dragging = true;
      drag.x = pos.x-mx;
      drag.y = pos.y-my;
    }
  }

  void rollover(int mx, int my) {
    float d = dist(mx,my,pos.x,pos.y);
    if (d < mass) {
      rollover = true;
    } else {
      rollover = false;
    }
  }

  void stopDragging() {
    dragging = false;
  }
  
 

  void drag() {
    if (dragging) {
      pos.x = mouseX + drag.x;
      pos.y = mouseY + drag.y;
    }
  }

}