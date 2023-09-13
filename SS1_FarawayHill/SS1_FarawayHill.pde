/* Faraway Hill by Sen Demina
I'm choosing the theme of a calm space on some imaginary hill. 
Some ideas I would like to add to the sketch is changing the time of day 
and interacting with the apples. */

size(1080, 720);
background(210, 240, 250);

noStroke();

//clouds
fill(250, 250, 255);
ellipse(300, 200, 200, 200);
ellipse(500, 300, 400, 400);
ellipse(300, 500, 300, 300);
ellipse(800, 500, 500, 500);
triangle(500, 300, 540, 340, -20, 50);


//==============   HOUSE   ===============
//house
//lit
fill(250, 240, 200);
triangle(700, 300, 600, 500, 800, 500);
//in shadow
fill(150, 150, 190);
quad(700, 300, 600, 500, 620, 500, 720, 300);

//door
fill(110, 150, 150);
strokeWeight(10);
stroke(190, 120, 120);
ellipse(710, 390, 30, 50);

//roof
//lit
stroke(230, 100, 100);
strokeWeight(10);
line(700, 300, 600, 500);
line(700, 300, 800, 500);
//in shadow
fill(150, 70, 100);
quad(700, 300, 900, 300, 970, 400, 750, 400);
noStroke();

//chimney
//in shadow
fill(150, 150, 190);
rect(790, 280, 20, 50);
//lit
fill(250, 240, 200);
rect(790, 280, 15, 20);
stroke(190, 120, 120);
line(785, 280, 810, 280);

//smoke
stroke(250, 250, 255);
noFill();
strokeWeight(5);
ellipse(800, 250, 30, 30);
strokeWeight(7);
ellipse(780, 200, 40, 40);
strokeWeight(10);
ellipse(810, 150, 50, 50);
strokeWeight(15);
ellipse(750, 100, 80, 80);
noStroke();

//=============    HILLS    =================
//back hill 
fill(180, 220, 150);
triangle(0, 500, width, 350, width, height);

//tree shadow
fill(50, 120, 150);
triangle(900, 500, 950, 480, 1200, 550);

//tree trunk
//in shadow
fill(120, 90, 120);
triangle (900, 500, 950, 480, 970, 200);
//lit
fill(200, 150, 50);
triangle (900, 500, 930, 480, 970, 200);

//tree crown
//in shadow
fill(50, 120, 150);
ellipse(950, 200, 200, 200);
ellipse(975, 300, 200, 100);
//lit
fill(180, 220, 150);
ellipse(930, 180, 200, 200);
ellipse(955, 280, 200, 100);

//apples
fill(230, 100, 100);
ellipse(900, 200, 30, 30);
ellipse(960, 250, 30, 30);
ellipse(970, 180, 30, 30);

//front hill
fill(50, 120, 150);
triangle(0, 400, 0, height, width, height);


////frame
//strokeWeight(50);
//stroke(250, 230, 200);
//noFill();
//rect(0, 0, width, height);
