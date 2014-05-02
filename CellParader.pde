
/*
CellParader
Copyright (c) 2014 Nicholas Alcus
It comes without any warranty, to the extent permitted by applicable law.

Draws various 'cell' agents.

Built with processing.
*/

PImage textures[] = new PImage[3];

void setup() {
  size (400, 400, P3D);
  noStroke();
  textures[0]=loadImage("white_ellipse_128px.png");
  textures[1]=loadImage("white_ellipse_128px_alpha128.png");
  textures[2]=loadImage("white_ellipse_128px_stroke_5px.png");
}

void draw() {
  background(32);
  drawCell(100,100,100,60, color(255,255,0));
  drawCell(300,300,75,120, color(255,0,255));
  drawCell(100,300,150,30, color(0,255,255));
  drawCell(300,100,80,75, color(255,0,0));
  
}

void stamp(float x, float y, float size, 
  PImage tex)
{
  float offset = size * 0.5; 
  pushMatrix();
  translate(x, y);
  beginShape();
  texture(tex);
  vertex(-offset, -offset, 0, 0, 0);
  vertex(offset, -offset, 0, textures[2].width, 0);
  vertex(offset, offset, 0, textures[2].width, textures[2].height);
  vertex(-offset, offset, 0, 0, textures[2].height);
  endShape();
  popMatrix();
}

void drawCell(float x, float y,float size, float BPM, color inner_color) {
  PVector position = new PVector(x,y);
  float period = 60000.0 / BPM;
  float amplitude = 0.5;
  float pulse = amplitude * cos(TWO_PI * (float)millis() / period);
  // heart
  tint(255,255,0);
  stamp(position.x, position.y, size*pulse, textures[1]);
  // thin inner layer
  tint(inner_color);
  stamp(position.x, position.y, size*0.75, textures[1]);
  // thin colored layer
  noTint();
  stamp(position.x, position.y, size, textures[1]);
  // stroke outline
  stamp(position.x, position.y, size, textures[2]);
  // shine  
  stamp(position.x-15,position.y-15,size*0.25,textures[0]);
}
