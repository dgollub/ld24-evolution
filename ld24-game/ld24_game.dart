#import('dart:html');

var canvas;
var cw;
var ch;
var x = 0;
var y = 0;
var dx = 4;
var dy = 0;

void main() {
  canvas = query("#canvas");
  cw = canvas.width;
  ch = canvas.height;

  var context = canvas.getContext("2d");
  //drawSign(context);
  clearScreen(context);
  drawDragon(context);
  drawSign(context);
}

void clearScreen(context) {
  print("clearScreen");
  context.fillStyle = "white";
  context.clearRect(0, 0, cw, ch);
}

void drawDragon(context) {
  print("drawDragon");
  context.lineWidth = 1;
  //context.lineJoin = "round";
  context.fillStyle = "black";
  context.strokeStyle = "black";
  context.stroke();
  x = cw-120;
  y = ch-42;
  drawDragonRec(context, 9, 0);
}


void drawDragonRec(context, level, turn) {
  print("drawDragonRec $level");

  if (level <= 0) {
    context.beginPath();
    context.moveTo(x, y);
    context.lineTo(x+dx, y+dy);
    x += dx;
    y += dy;
    context.closePath();
    context.strokeStyle = "black";
    context.stroke();
    return;
  }


  drawDragonRec(context, level-1, 0);
  var tmp = dx;
  if (turn == 0) {
    dx = dy;
    dy = -tmp;
  } else {
    dx = -dy;
    dy = tmp;
  }
  drawDragonRec(context, level-1, 1);

}

void drawSign(context) {
  print("drawSign");

  var canvasWidth = 200;
  var canvasHeight = 267;
  var width = 125;
  var height = 105;
  var padding = 25;
  var lineWidth = 8;
  var innerBorder = 5;
  var primaryColor = "#ffc821";
  var secondaryColor = "#faf100";
  var tertiaryColor = "#dcaa09";

  // Create a triangluar path
  context.beginPath();
  context.moveTo(padding + width/2, padding);
  context.lineTo(padding + width, height + padding);
  context.lineTo(padding, height + padding);
  context.closePath();

  // Create fill gradient
  var gradient = context.createLinearGradient(0,0,0,height);
  gradient.addColorStop(0, primaryColor);
  gradient.addColorStop(1, secondaryColor);

  // Add a shadow around the object
  context.shadowBlur = 10;
  context.shadowColor = "black";

  // Stroke the outer outline
  context.lineWidth = lineWidth * 2;
  context.lineJoin = "round";
  context.strokeStyle = gradient;
  context.stroke();

  // Turn off the shadow, or all future fills will have shadows
  context.shadowColor = "transparent";

  // Fill the path
  context.fillStyle = gradient;
  context.fill();

  // Add a horizon reflection with a gradient to transparent
  gradient=context.createLinearGradient(0,padding,0,padding+height);
  gradient.addColorStop(0, "transparent");
  gradient.addColorStop(0.5, "transparent");
  gradient.addColorStop(0.5, tertiaryColor);
  gradient.addColorStop(1, secondaryColor);

  context.fillStyle = gradient;
  context.fill();

  // Stroke the inner outline
  context.lineWidth = lineWidth;
  context.lineJoin = "round";
  context.strokeStyle = "#333";
  context.stroke();

  // Draw the text exclamation point
  context.textAlign = "center";
  context.textBaseline = "middle";
  context.font = "bold 60px 'Times New Roman', Times, serif";
  context.fillStyle = "#333";
  try{
  context.fillText("!", padding + width/2, padding + height/1.5);
  }catch(ex){}
}

