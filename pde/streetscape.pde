
// STREETSCAPE 
// A ProcessingJS/Canvas code-generated streetscape by Gary Smith (https://www.genartive.com)
// For educational purposes only: please do not redistribute for profit unmodified.

int calcWidth=250; // theoretical canvas width to use for calculations
int calcHeight=250; // theoretical canvas height to use for calculations

// initialize some global variables
float[] buildingEdges = {};
int numStreetBoxes=0;
int numPeople=0;

// initialize fonts
PFont fontCourier = loadFont("Courier New");
PFont fontArial = loadFont("Arial");

// define possible phrases for long and short signs
string[] allSigns = {"PHARMACY","FARMACIA","LUCKY 88","McNabb's","DISCOUNT","COFFEE","CURRY","LUCIANO'S","LOCOCO","FASHn","MERCADO","BURGER","ITALIANO","café","ROSE & LILY","TAPAS","BARRIO","STUBB'S","TABERNA","BOOKS","GYROS","RECORDS","HOT^SPOT","BAKERY","BOuLA","DIM SUM","NOODLE CO.","TAVERNA", "XCHANGE", "BUENOS", "BUTCHER","FINE FOODS","GROCERY","AL ASADOR","SUSHI","ICHIBAN","-o-","[=]","---"};
string[] shortSigns = {"café","Café","BBQ","TAPAS","-o-","[=]","==","GO!","EAT","CARNE","TACOS","BAR","ROTI","hOt","MEAT","SUSHI","BOOKS","DELI"};

// Initialize the canvas and draw the artwork elements
void setup() {

  // clear the background
  background(0,0,0,0); // clear
  fill(0,0,0,0); 

  // there is no animating loop, just a static image
  noLoop(); 

  size(640,640);

  smooth(); // smooth rendering

  textAlign(CENTER,CENTER); // position text to be centered on x,y coords

  strokeJoin(SQUARE);

  colorMode(HSB, 360, 100, 100); // set colour mode to HSB (Hue/Saturation/Brightness)

  background(0,0,100); // white  

  int hue1 = random(1,360); // main colour
  int hue2 = colorSplitComplementLeft(hue1); // left split complement to main colour
  int hue3 = colorSplitComplementRight(hue1); // right split complement to main colour

  // draw street
  fill(0,0,random(20,40),200);
  scaleRect( 0, calcHeight*0.85, calcWidth, calcHeight*0.21);
  drawTexture( 'o', calcWidth*0.0240, 0.0028, 0, calcHeight*0.85, calcWidth, calcHeight*0.21, hue1, random(5,10), random(10,25), random(25,35), random(45,65), 360);
  drawTexture( '-', calcWidth*0.01200, 0.004, 0, calcHeight*0.85, calcWidth, calcHeight*0.21, hue1, 0, 0, 0, 0, 220);

  // draw street line
  drawStreetLines( 0, calcHeight*0.90, calcWidth, calcHeight*0.21);

  // draw curb
  drawTexture('=', calcWidth*0.01700, 0.004, 0, calcHeight*0.79, calcWidth, calcHeight*0.008, hue1, 0, random(10,15), random(80,85), random(95,100), 360 );
  drawCurbLine();
  drawTexture( '=', calcWidth*0.0120, 0.002, 0, calcHeight*0.847, calcWidth, calcHeight*0.005, hue1, 0, 0, 0, 0, 360);

  // draw sidewalk  
  drawSideWalkLines(0, calcHeight*0.835, calcWidth, calcHeight*0.012);

  drawTexture( '*', calcWidth*0.0100, 0.003, 0, calcHeight*0.70, calcWidth, calcHeight*0.129, hue1, 0, 3, 95, 90, 360);
  drawTexture( '-', calcWidth*0.0050, 0.003, 0, calcHeight*0.70, calcWidth, calcHeight*0.129, hue2, 0, 3, 55, 77, 360);
  drawTexture( '-', calcWidth*0.0050, 0.003, 0, calcHeight*0.70, calcWidth, calcHeight*0.129, hue2, 0, 3, 55, 77, 360);

  // draw sky
  drawSky(hue1);

  // draw treeline just for some shadows behind the buildings
  drawTreeline( 0, calcHeight*0.792, calcWidth,calcHeight*0.52, color(hue1,30,30,320),calcWidth*0.004);
  drawTreeline( 0, calcHeight*0.792, calcWidth,calcHeight*0.42, color(hue1,25,20,320),calcWidth*0.005);
  drawTreeline( 0, calcHeight*0.791, calcWidth,calcHeight*0.22, color(hue1,10,10,180),calcWidth*0.005);

  // draw the row of buildings
  drawStreet(0, calcHeight*0.80, calcWidth, calcHeight*0.50, hue1, hue2, hue3);

  drawTreesAndPoles(hue1, hue2, hue3);

  // draw a ragged white frame around outwork
  drawPictureFrame();

  // add signature
  noStroke();
  fill(0,0,100,155);
  scaleRect(calcWidth*0.903, calcHeight*0.940, calcWidth*0.062, calcHeight*0.030);
  PFont fontA = loadFont("Courier New");
  textFont(fontCourier, scalePixelsX(calcWidth*0.032)); 
  fill(0,0,0,360);
  text("GES",scalePixelsX(calcWidth*0.932), scalePixelsY(calcHeight*0.955));

}

// Draw a textured sky across the top half of the artwork
//  - hue - color hue to use for sky
void drawSky(int hue) {
  fill(color(0,0,100,360));
  scaleRect(0, 0, calcWidth, calcHeight*0.666);
  drawTexture('#', calcWidth*0.02, 0.02, 0, 0, calcWidth, calcHeight*0.666, hue, random(0,6), random(40,60), random(96,100), random(85,92), 360);
}

// Draw randomly distributed trees, electricy poles/wires, newspaper boxes across the street
// Not all artworks have all of these elements
//  - hue1 - First color hue to use for elements
//  - hue2 - Second color hue to use for elements
//  - hue3 - Third color hue to use for elements
void drawTreesAndPoles(int hue1, int hue2, int hue3) {
  float furniture=random(0,100);
  if (furniture>75) { // tree left, pole right
    drawTree(calcWidth*random(0.24,0.39), calcHeight*0.825, calcWidth*random(0.017,0.019), hue1, hue2, hue3);
    drawPole(calcWidth*random(0.60,0.75), calcHeight*0.826, hue1, hue2, hue3);
  } else if (furniture>50) { // pole left, tree right
    drawTree(calcWidth*random(0.60,0.75), calcHeight*0.825, calcWidth*random(0.017,0.019), hue1, hue2, hue3);
    drawPole(calcWidth*random(0.24,0.39), calcHeight*0.826, hue1, hue2, hue3);
  } else if (furniture>25) { // tree only
    if (random(0,100)>50) { // left
      drawTree(calcWidth*random(0.24,0.39), calcHeight*0.825, calcWidth*random(0.017,0.019), hue1, hue2, hue3);
      if (random(0,100)>50) { // sometimes add boxes on the other side
        drawStreetBox(calcWidth*random(0.60,0.75), calcHeight*0.825, hue1, hue2, hue3);
      }
    } else { // right
      drawTree(calcWidth*random(0.60,0.75), calcHeight*0.825, calcWidth*random(0.017,0.019), hue1, hue2, hue3);
      if (random(0,100)>50) { // sometimes add boxes on the other side
        drawStreetBox(calcWidth*random(0.23,0.39), calcHeight*0.826, hue1, hue2, hue3);
      }
    }
  } else { // pole only
    if (random(0,100)>50) { // left
      drawPole(calcWidth*random(0.23,0.39), calcHeight*0.826, hue1, hue2, hue3);
    } else {
      drawPole(calcWidth*random(0.60,0.75), calcHeight*0.826, hue1, hue2, hue3);
    }
  }
}

// Draw a horizontal line to indicate the front edge of the sidewalk/curb
void drawCurbLine() {
  stroke(color(0,0,0,320));  
  scaleStrokeWeight(calcWidth*0.0012);
  scaleLine(0, calcHeight*0.835, calcWidth, calcHeight*0.835);   
}

// Draw sidewalk perspective lines
// These are spread evening across the image and connect to a "vanishing point" to create perspective
//  - x1 - horizontal x position of the sidewalk lines area
//  - y1 - vertical y position of the sidewalk lines area
//  - w - width of the sidewalk lines area
//  - h - height of the sidewalk lines area
void drawSideWalkLines(float x1, float y1, float w, float h) {
    float cx=int(w/2); // center of sidewalk
    float vx=int(calcWidth*0.5); // vanishing point x
    float vy=int(calcHeight*0.6666); // vanishing point y
    float numSections=random(7,10);
    int sw=int(w/numSections); // width of each section

    stroke(color(0,12,12,150));  
    scaleStrokeWeight(calcWidth*0.0011);

    // wobble the center slightly so the perspective isn't too perfectly centered
    cx*=random(0.9,1.1);

    // draw center line
    scaleLine(cx,y1,cx,y1+h);
    scaleLine(cx,y1,vx,vy);

    // loop to draw lines working outward equadistant from center
    for (int x=0; x<calcWidth; x+=sw) {
      scaleLine(cx+x,y1,cx+x,y1+h);
      scaleLine(cx+x,y1,vx,vy);
      scaleLine(cx-x,y1,cx-x,y1+h);
      scaleLine(cx-x,y1,vx,vy);      
    }
}

// Draw buildings across the width of the street
//  - x1 - horizontal x position of street area
//  - y1 - vertical y position of street area
//  - w - width of street area
//  - maxHeight - maxiumum height of any building
//  - hue1 - First color hue to use for elements
//  - hue2 - Second color hue to use for elements
//  - hue3 - Third color hue to use for elements
void drawStreet(float x1, float y1, float w, float maxHeight, int hue1, int hue2, int hue3) {
    float x = x1-calcWidth*random(0,0.2); // start buildings some random amount out the left of the view
    float buildingHeight;
    float buildingWidth;
    while (x<calcWidth) {
      buildingHeight=maxHeight*random(0.6, 1.0);
      buildingWidth=calcWidth*random(0.25, 0.45);
      drawBuilding(x,y1-buildingHeight,buildingWidth,buildingHeight, hue1, hue2, hue3);
      x+=buildingWidth+calcWidth*random(0.0,0.020);
    }

}

// Draw a single building and decorate it with windows, doors, signs, and other elements
//  - x1 - horizontal x position of building
//  - y1 - vertical y position of building
//  - w - width of building
//  - h - height of the building
//  - hue1 - First color hue to use for elements
//  - hue2 - Second color hue to use for elements
//  - hue3 - Third color hue to use for elements
void drawBuilding(float x1, float y1, float w, float h, int hue1, int hue2, int hue3) {
  
  // track building left edges so that later we can avoid drawing trees/poles on top of them
  append(buildingEdges,x1);

  // floor height for all buildings
  float floorHeight=calcHeight*0.08*random(0.97,1.03);

  // draw the building base shape
  hue=hue2;
  if (random(0,100)>50) hue=hue3;
  fill(hue,random(5,20),random(50,80),360);
  stroke(0,0,0,360);
  scaleStrokeWeight(calcWidth*0.0012);
  scaleRect(x1, y1, w, h);
  drawBrickPattern(calcWidth*0.020, 0.001, x1, y1, w, h, hue, random(5,25),random(50,90),360);
  int brickHue=hue;

  // sometimes, draw the ground floor a different pattern
  if (random(0,100)>60) {
    if (random(0,100)>50) {
      int altHue = hue3;
    } else {
      int altHue=hue2;
    }
    fill(altHue,random(2,15),random(44,77),360);
    stroke(0,0,0,360);
    scaleStrokeWeight(calcWidth*0.0012);
    scaleStrokeWeight(calcWidth*0.0012);
    scaleRect(x1, y1+h-floorHeight*1.25, w, floorHeight*1.25);  
    drawBrickPattern(calcWidth*0.020, 0.001, x1, y1+h-floorHeight*1.25, w, floorHeight*1.25, altHue, random(5,25),random(50,90),360);
  } 

  // draw outline around the building
  stroke(hue,20,10,160);
  scaleStrokeWeight(calcWidth*0.0016);
  noFill();
  scaleRect(x1, y1, w, h);

  // draw a thicker line along the bottom of the building
  stroke(hue,10,10,260)
  scaleStrokeWeight(calcWidth*0.0020);
  scaleLine(x1,y1+h, x1+w,y1+h);

  // draw some edges on the sides of the building
  round edgeW=w*random(0.018,0.033);
  stroke(hue,20,10,random(150,260));
  scaleRect(x1+edgeW, y1, w-edgeW*2, h);

  // draw a flat roof on the building
  stroke(0,0,0,360);
  hue=hue2;
  if (random(0,100)>50) hue=hue3;
  fill(hue,random(15,30),random(50,80),310);
  scaleRect(x1,y1,w,calcHeight*random(0.006,0.012));
  float roofTop=y1;

  // sometimes, draw a second layer of roof on the building
  if (random(0,100)>75) {
    scaleRect(x1,y1-calcHeight*0.008,w,calcHeight*random(0.006,0.012));
    roofTop=y1-calcHeight*0.008;
  }

  // sometimes draw aerials on the roof
  if (random(0,100)>50) {
    drawRoofAerial(x1, w, roofTop, hue1);  
  }
  if (random(0,100)>50) {
    drawRoofAerial(x1, w, roofTop, hue1);  
  }  

  // sometimes draw a utility box on top of the roof
  if (random(0,100)>30) {
    drawRoofBox(x1, w, roofTop, hue3);
  }

  // draw a shadow underneath the roofline
  fill(hue,0,20,340);
  scaleRect(x1,y1+calcHeight*0.005,w,calcHeight*random(0.006,0.003));

  // sometimes, draw dentals under the roof
  if (random(0,100)>50) {
    textSize(scalePixelsX(calcWidth*0.20));
    fill(hue,10,15,random(220,260));
    noStroke();
    for (float dentX=x1+edgeW; dentX<x1+w-edgeW*1.5; dentX+=calcWidth*0.016) {
      scaleRect(dentX,y1+calcHeight*0.008,calcWidth*0.008,calcHeight*0.008);
    }
  }

  // determine window grid
  int numCols=10;
  float colW=0;
  while (colW<calcWidth*0.10) {
    colW=w/numCols;
    numCols--;
  }

  // choose a random col for a door
  int doorCol=round(random(1, numCols+1));

  // sometimes add vertical bars to windows
  float vertbar=0;
  if (random(0,100)>30) {
    if (random(0,100)>50) {
      vertbar=1;
    } else {
      vertbar=2;
    }
  }  

  // sometimes add horizontal bars to windows
  float horizbar=0;
  if (random(0,100)>30) {
    if (random(0,100)>50) {
      horizbar=1;
    } else {
      horizbar=2;
    }
  } 

  // sometimes add a sill to the bottom of all windows
  float sillHeight=0;
  if (random(0,100)>40) {
    sillHeight=h*random(0.020,0.023);
    color sillColor = color(brickHue,random(5,20),random(70,100),250);
  }

  // loop to draw windows
  stroke(0,0,0,360);
  fill(0,0,0,260);
  scaleStrokeWeight(calcWidth*0.0016);
  int currFloor=1;
  for (float y=y1+h-floorHeight; y>y1+floorHeight/2; y-=floorHeight) {
    int currCol=1;
    for (float x=x1+colW*0.665; x<x1+w; x+=colW) {
      
      // determine height depending on if a window or a door
      if (currFloor==1 && currCol==doorCol) { // specs for doors
        bool isDoor=true;
        float thisH=floorHeight;
        float colWidth=colW;        
      } else if (currFloor==1) { // specs for taller ground floor windows
        bool isDoor=false;
        float thisH=floorHeight*random(0.88,0.94);    
        float colWidth=colW;          
      } else { // specs for upper floor windows
        bool isDoor=false;
        float thisH=floorHeight/2;
        float colWidth=colW;        
      }
      
      float winLeft=x-colWidth/3;
      float winTop=y;
      float winWidth=colWidth/3;
      float winHeight=thisH;   

      // draw frames and glass within doors and windows
      void rightEdge=winLeft+winWidth;
      void buildingEdge=x1+w-colWidth;      
      
      // call separate function to draw doors
      if (isDoor) {
        int hasStep=0;
        if (random(0,100)>20) {
          hasStep=round(random(1,2));
        }
        drawWindowDoorBase(winLeft, winTop, winWidth, winHeight, colWidth, floorHeight); 
        drawDoor(winLeft, winTop, winWidth, winHeight, hue1, hue2, hue3, calcWidth, floorHeight, colWidth, hasStep);
        if (rightEdge<=buildingEdge && random(0,100)>40) {
          drawDoor(winLeft+winWidth, winTop, winWidth, winHeight, hue1, hue2, hue3, calcWidth, floorHeight, colWidth, hasStep);
        }

       // otherwise, draw window
       } else {

        // make ground-floor windows wider
        if (currFloor==1) {
          winWidth*=2;
          winLeft-=winWidth/2.5;
          if (winLeft<x-colWidth/3) {
            winLeft=x-colWidth/3;
          } 
          if (rightEdge>buildingEdge) {
            winWidth/=2.5;
          }
        }

        // fill in background of the window
        drawWindowDoorBase(winLeft, winTop, winWidth, winHeight, colWidth, floorHeight);      
        
        // add reflective coloring to the window
        drawTexture('@', calcWidth*0.015, 0.0016, winLeft+(colWidth*0.09), winTop+(floorHeight*0.10), winWidth-(colWidth*0.16), winHeight-(floorHeight*0.22), hue1, random(0,5), random(10,30), random(85,90), random(90,100), random(150,170));
        if (random(0,100)>60) {
          drawTexture('o', calcWidth*0.03, 0.0016, winLeft+(colWidth*0.09), winTop+(floorHeight*0.10), winWidth-(colWidth*0.16), winHeight-(floorHeight*0.22), hue1, random(0,0), random(5,20), random(45,50), random(60,75), random(25,90));      
        }
        if (random(0,100)>60) {
          drawTexture('@', calcWidth*0.015, 0.0016, winLeft+(colWidth*0.09), winTop+(floorHeight*0.10), winWidth-(colWidth*0.16), winHeight-(floorHeight*0.22), hue1, random(0,0), random(5,10), random(85,90), random(95,100), random(25,90));      
        }    

        if (currFloor==1) {
          drawWindowItems(winLeft, winTop, winWidth, winHeight, hue2, hue3);        
        }
    
        // sometimes add a window sill
        if (currFloor>1 && sillHeight) {
            scaleStrokeWeight(calcWidth*0.0012);
            stroke(0,0,10,250);
            fill(sillColor);
            scaleRect(winLeft, winTop+winHeight, winWidth, sillHeight);
        }   

      }

      // draw a clean outline around the window
      stroke(hue1,15,20,270);
      noFill();
      scaleStrokeWeight(calcWidth*0.002);
      scaleRect(winLeft, winTop, winWidth, winHeight);

      // stroke for window bars
      stroke(0,10,20,220);

      // if there are horizontal bars, add them
      if (currFloor>1 && horizbar==1) {
        scaleLine(winLeft, winTop+winHeight*0.5, x, winTop+winHeight*0.5); 
      } else if (currFloor>1 && horizbar==2) {
        scaleLine(winLeft, winTop+winHeight*0.33, x, winTop+winHeight*0.33); 
        scaleLine(winLeft, winTop+winHeight*0.66, x, winTop+winHeight*0.66);         
      }

      // if there are vertical bars, add them
      if (currFloor>1 && vertbar==2) {
        scaleLine(winLeft+winWidth*0.33, winTop, winLeft+winWidth*0.33, winTop+winHeight); 
        scaleLine(winLeft+winWidth*0.66, winTop, winLeft+winWidth*0.66, winTop+winHeight); 
      }     

      // draw a small shadow across the top of the window to help it look inset
      if (!isDoor) { // (doors get their own thicker shadow in the drawDoor function)
        fill(0,0,10,150);
        noStroke();
        scaleRect(winLeft, winTop, winWidth, winHeight*0.08);          
      }

      // sometimes, draw a person looking onto a ground-floor window
      if (!isDoor && currFloor==1 && numPeople==0 && random(0,100)>75) {
          drawPerson(winLeft+winWidth/2,calcHeight*0.80, hue1, hue2, hue3);  
          numPeople++;
      }

      // sometimes, draw a planter box next to a door or ground-floor window
      if (currFloor==1 && random(0,100)>80) {
        float boxWidth=calcWidth*random(0.015,0.025);
        if (random(0,100)>50) {
          drawPlanterBox(winLeft-boxWidth,calcHeight*0.80, boxWidth, hue1, hue2, hue3);
        } else {
          drawPlanterBox(winLeft+winWidth,calcHeight*0.80, boxWidth, hue1, hue2, hue3);          
        }
      }

      currCol++;
    }

    // add a little extra height to the ground floors to make room for signs/awnings
    if (currFloor==1) {
      y-=floorHeight*0.25; 
    }

    // draw signs/awnings above first floor
    if (currFloor==1 & random(0,100)>35) {
      drawSignage(x1, winTop, w, floorHeight, hue1, hue2, hue3);
    }

    currFloor++;
  }

}

// Draw the base below windows and doors
//  - winLeft - horizontal x position of base
//  - winTop - vertical y position of base
//  - winWidth - width of window
//  - winHeight - height of window
//  - colWidth - width of a column on this building
//  - floorHeight - height of a floor for this building
void drawWindowDoorBase(float winLeft, float winTop, float winWidth, float winHeight, float colWidth, float floorHeight) { 
  fill(0,0,0,260);
  scaleRect(winLeft, winTop, winWidth, winHeight);      
  fill(color(0,0,100,360));
  noStroke();
  scaleRect(winLeft+(colWidth*0.02), winTop+(floorHeight*0.03), winWidth-(colWidth*0.04), winHeight-(floorHeight*0.04)); 
}

// Draw a utility box on the roof of a building
// - x1 - horizontal x position of the box
// - w - width of the box
// - roofTop - vertical poistion of the top of the roof
// - boxHue - hue to use for color of box 
void drawRoofBox(float x1, float w, float roofTop, int boxHue) {
    scaleStrokeWeight(calcWidth*0.001);
    stroke(0,0,0,250);
    fill(boxHue,random(5,12),random(22,44),350);
    if (random(0,100)>50) { // flat wide box
      float boxHeight = calcHeight*random(0.003,0.005);
      float boxLeft = x1+w*random(0.2,0.5);
      float boxWidth = w*random(0.14,0.20);
      scaleRect(boxLeft,roofTop-boxHeight,boxWidth,boxHeight);
    } else { // chimney pipe
      float boxHeight = calcHeight*random(0.006,0.012);
      float boxLeft = x1+w*random(0.2,0.8);
      float boxWidth = w*random(0.008,0.010);
      scaleRect(boxLeft,roofTop-boxHeight,boxWidth,boxHeight);
    }
}

// Draw an aerial on the roof of a building
// - x1 - horizontal x position of the aerial
// - w - width of the aerial
// - roofTop - vertical poistion of the top of the roof
// - aerialHue - hue to use for color of aerial 
void drawRoofAerial(float x1, float w, float roofTop, int aerialHue) {
    float aerialHeight = calcHeight*random(0.035,0.055);
    float aerialLeft = x1+w*random(0.2,0.5);
    float aerialVariance = w*random(-0.002,0.002);
    roofTop-=calcHeight*0.002;
    stroke(0,5,10,325);
    scaleStrokeWeight(calcWidth*0.0018);
    scaleLine(aerialLeft,roofTop-aerialHeight,aerialLeft+aerialVariance,roofTop);
    stroke(0,5,95,300);
    scaleStrokeWeight(calcWidth*0.0011);
    scaleLine(aerialLeft-calcWidth*0.001,roofTop-aerialHeight,aerialLeft-calcWidth*0.001+aerialVariance,roofTop);
    fill(0,5,10,325);
    textSize(scalePixelsX(calcWidth*0.017));
    fill(0,0,0,300);
    if (random(0,100)>20) {
      scaleText('I===I',aerialLeft,roofTop-aerialHeight*0.8);
      fill(0,5,95,300);
      scaleText('I===I',aerialLeft-calcWidth*0.001,roofTop-aerialHeight*0.8-calcWidth*0.001);    
    }
    if (random(0,100)>60) {
      stroke(aerialHue,5,25,220);
      fill(aerialHue,8,92,360);
      float topperH=roofTop-aerialHeight*random(0.3,0.8);
      scaleEllipse(aerialLeft,topperH,w*0.05,w*0.06);
      noStroke();
      fill(aerialHue,4,50,76);
      scaleEllipse(aerialLeft,topperH,w*0.03,w*0.035);      
      fill(0,5,5,222);
      scaleEllipse(aerialLeft,topperH,w*0.008,w*0.010);
    }
}

// Draw a person standing on the street
//  - x - horizontal x position of the person
//  - y - vertical y position of the person
//  - hue1 - First color hue to use for elements
//  - hue2 - Second color hue to use for elements
//  - hue3 - Third color hue to use for elements
void drawPerson(float x, float y, int hue1, int hue2, int hue3) {

  int bodyHue=hue1;
  if (random(0,100)>66) {
    bodyHue=hue2;
  }
  if (random(0,100)>66) {
    bodyHue=hue3;
  }
  color faceCol=color(10,random(15,25),random(15,30),360);
  color bodyCol=color(bodyHue,random(10,20),random(24,45),360);
  color legCol=color(hue3,random(15,25),random(18,27),360);

  float howTall=calcHeight*0.040;
  float hv = random(0.95, 1.05); // height variant percent
  float wv = random(0.95, 1.054); // width variant percent

  x*=random(0.980,1.020);
  y*=random(0.995,1.005);

  scaleStrokeWeight(calcWidth*0.0010);
  stroke(0,0,0,150);

  // draw head
  fill(faceCol);
  noStroke();
  scaleEllipse(x, y-howTall*1.01, calcHeight*0.0080, calcHeight*0.0080);

  // draw legs
  stroke(0,0,0,150);
  fill(legCol);
  scaleEllipse(x-calcHeight*0.003,y-howTall*0.14*hv,calcHeight*0.0045*wv,calcHeight*0.036*hv);
  scaleEllipse(x+calcHeight*0.003,y-howTall*0.14*hv,calcHeight*0.0045*wv,calcHeight*0.036*hv);

  // draw feet
  scaleEllipse(x-calcHeight*0.003,y+calcHeight*0.013,calcHeight*0.003,calcHeight*0.002);
  scaleEllipse(x+calcHeight*0.003,y+calcHeight*0.013,calcHeight*0.003,calcHeight*0.002);

  // draw body
  fill(bodyCol);
  stroke(0,0,0,150);
  scaleEllipse(x, y-howTall+calcHeight*0.013*hv, calcHeight*0.015*wv, calcHeight*0.0176*hv);  
  scaleRect(x-calcHeight*0.0065*wv*wv, y-howTall+calcHeight*0.013*hv, calcHeight*0.012*wv, calcHeight*0.0165*hv);

  // put some pattern of some sort on their shirt
  fill(hue1,22,100,70);
  textSize(scalePixelsX(calcWidth*0.025));
  string chars='=~-  H';
  scaleText(chars[floor(random(0,chars.length))],x, y-howTall+calcHeight*0.013*hv);
  scaleText(chars[floor(random(0,chars.length))],x, y-howTall+calcHeight*0.020*hv);
  scaleText(chars[floor(random(0,chars.length))],x, y-howTall+calcHeight*0.013*hv);

  // some people have long hair
  if (random(0,100)>50) {
    noStroke();
    fill(faceCol);
    scaleRect(x-calcHeight*0.0040*wv, y-howTall*hv, calcHeight*0.0080*wv, calcHeight*0.010*hv);
  }

}

// Draw a planter box next to a door or window
//  - x - horizontal x position of the box
//  - y - vertical y position of the box
//  - w - width of the box
//  - hue1 - First color hue to use for elements
//  - hue2 - Second color hue to use for elements
//  - hue3 - Third color hue to use for elements
void drawPlanterBox(float x, float y, float w, int hue1, int hue2, int hue3) {
  
  // calculate the box height
  int h=calcHeight*random(0.008,0.016);

  // vary x position slightly
  x=x*random(0.995,1.005);

  // draw some bush at the top
  noStroke();
  fill(0,0,0,260);
  drawTexture('W', calcWidth*0.007, 0.001, x+w*0.20, y-h*1.02, w*0.70, h*0.05, hue2, 15, 25, 15, 344, 320 );
  drawTexture('*', calcWidth*0.006, 0.001, x+w*0.20, y-h*1.02, w*0.70, h*0.08, hue1, 5, 15, 25, 34, 320 );
  drawTexture('!', calcWidth*0.008, 0.001, x+w*0.30, y-h*1.02, w*0.60, h*0.08, hue1, 25, 35, 65, 84, 320 );

  // choose the box color
  int boxHue=hue1;
  if (random(0,100)>66) {
    boxHue=hue2;
  }
  if (random(0,100)>66) {
    boxHue=hue3;
  }

  // draw the box
  scaleStrokeWeight(calcWidth*0.0011);
  stroke(0,0,0,200);
  fill(boxHue, random(15,25), random(45,86), 360);
  scaleRect(x, y-h*0.80, w, h);

  // draw lighter area at top
  noStroke();
  fill(boxHue, random(15,25), random(77,100), 360);
  scaleRect(x, y-h*0.80, w, h*0.3);

  // draw darker area at bottom
  noStroke();
  fill(0, 0, 0, 150);
  scaleRect(x, y-h*0.14, w, h*0.30);

  // redraw the box border
  stroke(0,0,0,200);
  noFill();
  scaleRect(x, y-h*0.80, w, h);

  // draw some grass at the bottom
  noStroke();
  fill(0,0,0,260);
  drawTexture('=', calcWidth*0.0035, 0.001, x, y+h*0.15, w, h*0.06, hue1, 5, 5, 5, 34, 320 );
  drawTexture(',', calcWidth*0.0035, 0.001, x+w*0.25, y+h*0.15, w*0.98, h*0.08, hue1, 5, 5, 5, 34, 320 );

}

// Draw a door on a building
//  - winLeft - horizontal x position of the door
//  - winTop - vertical y position of the door
//  - doorWidth - width of the door
//  - doorHeight - height of the door
//  - hue1 - First color hue to use for elements
//  - hue2 - Second color hue to use for elements
//  - hue3 - Third color hue to use for elements
//  - calcWidth - Calculated width of the door
//  - floorHeight - Height of a floor on this building
//  - colWidth - Width of a column in this building
//  - hasStep - Whether or not this door has a step in front of it
void drawDoor(void winLeft, void winTop, void doorWidth, void doorHeight, int hue1, int hue2, int hue3, float calcWidth, float floorHeight, float colWidth, int hasStep) {
  
  // pick a door color
  int doorHue=hue1;
  if (random(0,100)>66) doorHue=hue2;
  if (random(0,100)>66) doorHue=hue3;

  // fill in the base background of the door
  fill (doorHue,random(5,20),random(25,45),random(280,320));
  scaleRect(winLeft, winTop, doorWidth, doorHeight);
  
  // draw the layers of reflective patterning over the door
  string chars='xo#-:~';
  drawTexture(chars[floor(random(0,chars.length))], calcWidth*0.03, 0.0016, winLeft+(colWidth*0.06), winTop+(floorHeight*0.10), doorWidth-(colWidth*0.12), doorHeight-(floorHeight*0.17), doorHue, random(0,5), random(10,30), random(85,90), random(90,100), random(150,300));
  drawTexture(chars[floor(random(0,chars.length))], calcWidth*0.04, 0.0021, winLeft+(colWidth*0.06), winTop+(floorHeight*0.10), doorWidth-(colWidth*0.12), doorHeight-(floorHeight*0.17), doorHue, random(0,0), random(5,20), random(35,50), random(60,65), random(25,60));      
  drawTexture(chars[floor(random(0,chars.length))], calcWidth*0.03, 0.0016, winLeft+(colWidth*0.06), winTop+(floorHeight*0.10), doorWidth-(colWidth*0.12), doorHeight-(floorHeight*0.17), doorHue, random(0,0), random(5,10), random(85,90), random(95,100), random(25,100)); 
  drawTexture(chars[floor(random(0,chars.length))], calcWidth*0.03, 0.0016, winLeft+(colWidth*0.06), winTop+(floorHeight*0.10), doorWidth-(colWidth*0.12), doorHeight-(floorHeight*0.17), doorHue, random(0,5), random(10,30), random(85,90), random(90,100), random(150,300));
  drawTexture(chars[floor(random(0,chars.length))], calcWidth*0.04, 0.0021, winLeft+(colWidth*0.06), winTop+(floorHeight*0.10), doorWidth-(colWidth*0.12), doorHeight-(floorHeight*0.17), doorHue, random(0,0), random(5,20), random(35,50), random(60,65), random(25,60));      
  drawTexture(chars[floor(random(0,chars.length))], calcWidth*0.05, 0.0016, winLeft+(colWidth*0.06), winTop+(floorHeight*0.10), doorWidth-(colWidth*0.12), doorHeight-(floorHeight*0.17), doorHue, random(0,0), random(5,10), random(85,90), random(95,100), random(25,100)); 
  
  // redraw black outline of the door
  stroke(hue1,10,0,320);  
  noFill();
  scaleStrokeWeight(calcWidth*0.0016);
  scaleRect(winLeft, winTop, doorWidth, doorHeight);  

  // draw vertical line down the middle of all doors
  scaleLine(winLeft+doorWidth*0.5, winTop, winLeft+doorWidth*0.5, winTop+doorHeight); 

  // draw a shadow across the top of the door to help it look inset
  fill(0,0,10,190);
  noStroke();
  scaleRect(winLeft, winTop, doorWidth, doorHeight*0.08);

  // draw door handle
  fill(0,0,10,300);
  textSize(scalePixelsX(calcWidth*0.016));
  string chars = 'II!|';
  char handle=chars[floor(random(0,chars.length))];
  scaleText(handle,winLeft+doorWidth*0.62, winTop+(floorHeight*0.59));
  scaleText(handle,winLeft+doorWidth*0.37, winTop+(floorHeight*0.59));  

  if (hasStep) {
    scaleStrokeWeight(calcWidth*0.0016);
    noStroke();
    fill(0,0,5,280);
    scaleRect(winLeft-doorWidth*0.03, winTop+doorHeight*0.96, doorWidth*1.06, doorHeight*0.03);  
    if (hasStep==2) {
      stroke(0,0,0,240);
      fill(0,0,100,360);
      scaleRect(winLeft-doorWidth*0.04, winTop+doorHeight*0.99, doorWidth*1.08, doorHeight*0.06);    
    }
  }
}

// Draw a smattering of items seen through a window
//  - winLeft - horizontal x position of the window
//  - winTop - vertical y position of the window
//  - winWidth - width of the window
//  - winHeight - height of the window
//  - hue1 - Second color hue to use for elements
//  - hue2 - Third color hue to use for elements
void drawWindowItems(winLeft, winTop, winWidth, winHeight, hue1, hue2) {
  dx=winWidth*random(0.10,0.20);
  dy=winHeight*random(0.15,0.22);
  int itemsHue=0;
  string chars1 = '-="^';
  string chars2 = 'OX%@[';
  string prod=chars1[int(random(0,chars1.length))];
  string prod2=chars2[int(random(0,chars2.length))];
  textSize(scalePixelsX(calcWidth*0.015));
  stroke(0,10,10,110);
  scaleStrokeWeight(calcWidth*0.0010);
  for (int i=0; i<3; i++) {
    itemsHue=hue1;
    if (random(0,100)>50) itemsHue=hue2;
    fill(itemsHue,random(15,34),random(45,80),random(155,180));
    for (y=winTop+winHeight*0.3; y<winTop+winHeight-winHeight*0.25; y+=dy) {
      for (x=winLeft+winWidth*0.2; x<winLeft+winWidth-winWidth*0.25; x+=dx) {
        if (random(0,100)>80) {
          scaleRect(x, y, dx*0.7*random(0.7,1.3), dy*random(0.4,0.6));
        }
        if (random(0,100)>60) {
          scaleText(prod,x,y);
          scaleText(prod2,x,y);
        }        
      }
    }
  }
}

// Draw a sign on a building
//  - signLeft - horizontal x position of the sign
//  - signTop - vertical y position of the sign
//  - signWidth - Width of a sign
//  - floorHeight - height of a floor on this building
//  - hue1 - First color hue to use for elements
//  - hue2 - Second color hue to use for elements
//  - hue3 - Third color hue to use for elements
void drawSignage(signLeft, signTop, signWidth, floorHeight, hue1, hue2, hue3) {
  
  // if the sign is too wide, make two smaller signs
  if (signWidth>calcWidth*0.2) {
    drawSignage(signLeft+signWidth*0.5, signTop, signWidth*0.5, floorHeight, hue1, hue2, hue3);
    signWidth*=0.5;
  }

  // choose a random hue and saturation for the sign
  var signHue=hue2;
  if (random(0,100)>50) {
    signHue=hue3;
  }
  
  // set fill and outline style for the sign
  fill(signHue,random(5,25),random(60,90),350);
  stroke(0,10,10,340);
  scaleStrokeWeight(calcWidth*0.0022);

  // but just make some signs white or light grey
  if (random(0,100)>66) {
    fill(0,0,random(90,100),350);
  }

  // calculate width and height of the sign
  float signHeight=floorHeight*random(0.43,0.55);
  float signTop=signTop-floorHeight*0.45*random(0.9,1.1);

  // draw the base sign rectangle
  scaleRect(signLeft, signTop, signWidth,signHeight);

  // make some signs an awning
  if (random(0,100)>50) {
    drawTexture('!', calcWidth*0.025, 0.00015, signLeft, signTop+signHeight*0.25, signWidth,signHeight*0.62, signHue, random(0,5), random(10,30), random(85,90), random(90,100), random(300,360));
    fill(0,0,0,80);
    noStroke();
    scaleRect(signLeft, signTop, signWidth, signHeight*0.28);
    scaleRect(signLeft, signTop, signWidth, signHeight*0.12)
  } else {
    string chars='=-+~ou"';
    drawTexture(chars[floor(random(0,chars.length))], calcWidth*random(0.024,.034), 0.0003, signLeft+signWidth*0.10, signTop+signHeight*0.10, signWidth*0.80,signHeight*0.95, signHue, random(0,5), random(10,30), random(85,90), random(90,100), random(50,190));  
    noFill();
    stroke(0,5,20,250);
    scaleStrokeWeight(calcWidth*0.004);
    scaleRect(signLeft, signTop, signWidth,signHeight);
  }

  // draw shadow beneath the sign
  fill(0,0,0,180);
  noStroke();
  scaleRect(signLeft, signTop+signHeight, signWidth, signHeight*random(0.2,0.3));

  // sometimes put writing on the sign
  if (random(0,100)>33) {
    
    int signHue=hue1;
    if (random(0,100)>70) {
      signHue=hue2;
    } 
    if (random(0,100)>60) {
      signHue=hue3;
    } 
    fill(signHue,random(10,60),random(35,65),random(310,340));    
    if (random(0,100)>50) {
      textFont(fontArial, scalePixelsX(signHeight*random(0.46,0.64))); 
    } else {
      textFont(fontCourier, scalePixelsX(signHeight*random(0.46,0.64))); 
    }
    if (signWidth<calcWidth*0.17) {
      signText=shortSigns[int(random(shortSigns.length))];
    } else {
      signText=allSigns[int(random(allSigns.length))]
    }
    scaleText(signText, signLeft+signWidth*0.5,signTop+signHeight*0.54);
  }
}

// Draw an area of brick patterning
//  - txtSize - size of text to use for pattern characters
//  - variance - amount of variation in brick positioning (aka how 'loose' is the pattern)
//  - x1 - horizontal x position of the pattern area
//  - y1 - vertical y position of the pattern area
//  - w - widthof the pattern area
//  - h - height of the pattern area
//  - hue - HSB hue to use for pattern color
//  - sat - HSB saturation to use for pattern color
//  - bri - HSB brightness to use for pattern color
void drawBrickPattern(float txtSize, float variance, float x1, float y1, float w, float h, int hue, int sat, int bri) {
 
  int dw=calcWidth*0.006;
  int dh=calcHeight*0.008;

  x1*=1.005; // push in from left slightly
  w*=0.995;

  float numRows=h/dh;

  textSize(scalePixelsX(txtSize));

  char ch;

  noStroke();

  chars='-+~--=';
  ch=chars.charAt(int(random(0,chars.length()-1)));
  fill(color(hue,sat,bri,360));
  for (int x=x1; x<x1+w; x+=dw){
    for (int y=y1+dh; y<y1+h; y+=dh) {      
      for (int i=0; i<1; i++) {
        if (random(0,100)>10) {
         text(ch,scalePixelsX(x+calcWidth*random(-variance, variance)),scalePixelsY(y+calcWidth*random(-variance,0)));
        }
      }
    }
  }

  chars='T!';
  ch=chars.charAt(int(random(0,chars.length()-1)));
  fill(color(hue,sat*1.2,bri*0.8,360));
  for (int x=x1; x<x1+w; x+=dw){
    for (int y=y1+dh*2; y<y1+h-dh/2; y+=dh) {      
      for (int i=0; i<1; i++) {
        if (random(0,100)>70) {
         text(ch,scalePixelsX(x+calcWidth*random(-variance, variance)),scalePixelsY(y+calcWidth*random(-variance,0)));
        }
      }
    }
  }  

  if (random(0,100)>70) {
    chars='-*';
    ch=chars.charAt(int(random(0,chars.length()-1)));
    fill(color(hue,sat*random(1.2,1.5),bri*random(1.4,2.4),320));
    for (int x=x1; x<x1+w; x+=dw){
      for (int y=y1; y<y1+h; y+=dh) {      
        for (int i=0; i<1; i++) {
          if (random(0,100)>10) {
            text(ch,scalePixelsX(x+calcWidth*random(-variance, variance)),scalePixelsY(y+calcWidth*random(-variance,0)));
          }
        }
      }
    }   
  }

}

// Draw a textured rectangle filled with a pattern of overlapping characters
//  - char - character(s) to draw
//  - txtSize - size of text to use for pattern characters
//  - variance - amount of variation in brick positioning (aka how 'loose' is the pattern)
//  - x1 - left x position of rectangle
//  - y1 - top y position of rectangle
//  - w - width of rectangle
//  - h - height of rectangle
//  - hue - base hue for color
//  - startSat - starting saturation range for color
//  - endSat - ending saturation range for color
//  - startBri - staring brightness range for color
//  - endBri - ending brightness range for color
//  - opa - opacity of the pattern
void drawTexture(string char, float txtSize, float variance, float x1, float y1, float w, float h, int hue, int startSat, int endSat, int startBri, int endBri, int opa) {

  int dw=calcWidth*0.006;
  int dh=calcHeight*0.008;

  float numRows=h/dh;
  float dSat = (endSat-startSat)/numRows;
  float dBri = (startBri-endBri)/numRows;

  textSize(scalePixelsX(txtSize));

  noStroke();
  for (int x=x1; x<x1+w; x+=dw){
    float sat=startSat;
    float bri=startBri;
    for (int y=y1; y<y1+h; y+=dh) {      
      fill(color(hue,sat,bri,opa));
      sat+=dSat;
      bri-=dBri;
      for (int i=0; i<2; i++) {
        text(char,scalePixelsX(x+calcWidth*random(-variance, variance)),scalePixelsY(y+calcWidth*random(-variance, variance)));
      }
    }
 }
}

// Draw a line of trees
//  xLeft - left x position of treeline
//  yBot - bottom y position of treeline
//  w - width of treeline
//  maxcalcHeight - maximum high treeline can reach
//  ORA - color of treeline
//  blobSize - size of characters used to draw treeline elements
void drawTreeline(float xLeft, float yBot, float w, float maxcalcHeight, color ORA, void blobSize) {
  stroke(ORA);
  fill(ORA);
  textSize(scalePixelsX(calcWidth*0.0225));
  float treelinecalcHeight=round(maxcalcHeight*random(0.5,1));
  float treelineDelta=-5;
  float variant=0.010;
  for (x=xLeft; x<xLeft+w; x+=blobSize*0.8) {
    for (y=yBot; y>yBot-treelinecalcHeight; y-=blobSize*0.8) {
      if (random(0,100)>50) {
        text("*",scalePixelsX(x+calcWidth*random(-variant,variant)),scalePixelsY(y+calcWidth*random(-variant,variant))); 
      } else {
        text("^",scalePixelsX(x+calcWidth*random(-variant,variant)),scalePixelsY(y+calcWidth*random(-variant,variant))); 
      }
    }
    if (random(1,10)>3) {
      treelinecalcHeight+=treelineDelta;
    }
    if (treelinecalcHeight>maxcalcHeight) {
      treelinecalcHeight-=abs(treelineDelta);
      treelineDelta-=random(0,8);
    }
    if (treelinecalcHeight<(maxcalcHeight/2)) {
      treelinecalcHeight+=abs(treelineDelta);
      treelineDelta+=random(0,6);
    }
    if (random(1,10)>5) {
      treelineDelta+=random(-7,7);
    }
  }
}

// Begin the recursive process of drawing a tree and its roots
//  - x - horizontal position of the tree base
//  - y - vertical position of the tree base
//  - w - initial width of the tree base trunk
//  - hue1 - First color hue to use for elements
//  - hue2 - Second color hue to use for elements
//  - hue3 - Third color hue to use for elements
void drawTree(float x, float y, float w, int hue1, int hue2, int hue3) { 
  
  // if this element is too close to a building gap, adjust it randomly right or left
  for (int i=0; i<buildingEdges.length; i++) {
    if (abs(x-buildingEdges[i])<calcWidth*0.03) {
      float offsetX=calcWidth*random(0.04,0.05);
      if (random(0,100)>50) offsetX*=-1;
      x+=offsetX;
    }
  }

  textSize(scalePixelsX(calcWidth*0.014));
  drawBranch(x, y, x*random(0.98,1.02), y-(w*random(4.5,6.0)), w, hue1, hue2, hue3); 
  noStroke();  
  fill(hue1,12,12,360);
  scaleEllipse(x, y, w*7, w*0.6);
  drawTexture('!', calcWidth*0.0120, 0.002, x-w*3.2, y, w*6.5, w*0.3, hue1, 12, 17, 33, 55, 360 );
  drawTexture('!', calcWidth*0.0120, 0.003, x-w*3.2, y-w*0.3, w*6.5, w*0.4, hue3, 10, 24, 22, 44, 360 ); 
  drawTexture('!', calcWidth*0.0120, 0.003, x-w*3.2, y-w*0.3, w*6.5, w*0.3, hue3, 8, 14, 44, 66, 360 );  
  fill(hue1,2,100,360);
  stroke(0,0,0,150);
  scaleRect(x-w*3.6, y, w*7.5, w*0.4);
  fill(hue1,2,2,120);
  scaleRect(x-w*3.6, y+w*0.2, w*7.5, w*0.2);  
}

// Draw a single branch of a tree
// Then make recursive calls to this function to draw additional smaller branches splitting to the left and right of this one
// Note that recursive calls are wrapped in setTimout() calls to push them into another processing thread to reduce browser sluggishness
//  - x1 - horizontal x start position of branch
//  - y1 - vertical start position of branch
//  - x2 - horizontal x end position of branch
//  - y2 - vertical end position of branch
//  - thickness - thickness of the branch
//  - hue1 - First color hue to use for elements
//  - hue2 - Second color hue to use for elements
//  - hue3 - Third color hue to use for elements
void drawBranch(float x1, float y1, float x2, float y2, float thickness, int hue1, int hue2, int hue3) {

  // for thicker branches, draw two-tones, one darker and then a lighter highlight
 if (thickness>calcWidth*0.005) {
    strokeWeight(scalePixelsX(thickness*0.7));
    stroke(0,0,0,330);
    line(scalePixelsX(x1), scalePixelsY(y1), scalePixelsX(x2), scalePixelsY(y2));    

    strokeWeight(scalePixelsX(thickness*0.4));
    stroke(hue1,14,25,360);
    line(scalePixelsX(x1), scalePixelsY(y1), scalePixelsX(x2), scalePixelsY(y2));

    strokeWeight(scalePixelsX(thickness*0.1));
    stroke(hue1,20,35,360);
    line(scalePixelsX(x1), scalePixelsY(y1), scalePixelsX(x2), scalePixelsY(y2));

  } else { // for thinner branches, just draw one line in a random lighter tone
      strokeWeight(scalePixelsX(thickness*0.4));
      stroke(0,0,0,360);
      line(scalePixelsX(x1), scalePixelsY(y1), scalePixelsX(x2), scalePixelsY(y2));   
   }

  // sometimes draw some leaves
  if (thickness<calcWidth*0.008) {
    if (random(0,100)>80) {
      fill(hue1,random(4,11),random(33,9555),360);
      scaleText('*',x2,y2);    
      scaleText('^',x2,y2+calcHeight*0.004); 
      fill(hue1,random(4,11),random(88,100),360);
      scaleText('"',x2*random(0.99,1.01),y2+calcHeight*0.006); 
    }  
  }

  // make potential new child branches thinner than their parent
  thickness=thickness*0.77;  

  // while the branch is thick enough, split it into two smaller ones
  if (thickness>calcWidth*0.0017) { 
      
    // split a branch out to the left
    float dx=thickness*random(2,4);
    float dy=thickness*random(2,4);   
    drawBranch(x2, y2, x2-dx, y2-dy, thickness*0.9, hue1, hue2, hue3);

    // split a branch out to the right
    float dx=thickness*random(2,4);
    float dy=thickness*random(2,4); 
    drawBranch(x2, y2, x2+dx, y2-dy, thickness*0.9, hue1, hue2, hue3);

    // carry on main trunk
    float dx=thickness*random(-1,1);
    float dy=thickness*random(2,4); 
    drawBranch(x2, y2, x2+dx, y2-dy, thickness*1.05, hue1, hue2, hue3);

  }

}

// Draw an electrical pole, with curved wires connected to each side running out the edge of the artwork
//  - x - horizontal position of the base of the pole
//  - y - vertical position of the base of the pole
//  - hue1 - First color hue to use for elements
//  - hue2 - Second color hue to use for elements
//  - hue3 - Third color hue to use for elements
void drawPole(float x, float y, int hue1, int hue2, int hue3) {

  // if this element is too close to a uilding gap, adjust it randomly right or left  
  for (int i=0; i<buildingEdges.length; i++) {
    if (abs(x-buildingEdges[i])<calcWidth*0.03) {
      float offsetX=calcWidth*random(0.055,0.065);
      if (random(0,100)>50) offsetX*=-1;
      x+=offsetX;
     }
  }

  // give the pole some horizontal tilt, never let it be straight vertical (that's boring)
  float variance=calcWidth*random(0.005,0.012);
  if (random(0,100)>50) variance*=-1;

  // calculate the top of the pole
  float topX=x+variance;
  float topY=y-calcHeight*random(0.38,0.44);

  // define three color shades for the pole
  color baseCol=color(hue1,8,89,360);
  color altCol=color(hue1,6,55,360);
  color shadowCol=color(hue1,2,9,360);

  // draw a small shadow at the foot of the pole
  noStroke();
  fill(hue1,5,15,301);
  scaleEllipse(x-calcWidth*0.002, y*1.002, calcWidth*0.040, y*0.004);

  // draw wires first, so the pole goes on top of them
  stroke(0,0,0,255);
  noFill();
  scaleStrokeWeight(calcWidth*0.003);
  drawCurvedLine(topX,topY+calcHeight*0.010 , topX+calcWidth/2,topY+calcHeight*random(0.04,0.06) , topX+calcWidth,topY+calcHeight*0.010);
  drawCurvedLine(topX,topY+calcHeight*0.030 , topX+calcWidth/2,topY+calcHeight*random(0.05,0.07) , topX+calcWidth,topY+calcHeight*0.030);
  drawCurvedLine(topX,topY+calcHeight*0.050 , topX+calcWidth/2,topY+calcHeight*random(0.07,0.09) , topX+calcWidth,topY+calcHeight*0.050);

  drawCurvedLine(topX,topY+calcHeight*0.010 , topX-calcWidth/2,topY+calcHeight*random(0.04,0.06) , topX-calcWidth,topY+calcHeight*0.010);
  drawCurvedLine(topX,topY+calcHeight*0.030 , topX-calcWidth/2,topY+calcHeight*random(0.05,0.07) , topX-calcWidth,topY+calcHeight*0.030);
  drawCurvedLine(topX,topY+calcHeight*0.050 , topX-calcWidth/2,topY+calcHeight*random(0.07,0.09) , topX-calcWidth,topY+calcHeight*0.050);

  // draw left attachments for the wires behind the pole
  noStroke();
  fill(0,0,0,123);
  scaleEllipse(topX-calcWidth*0.004,topY+calcHeight*0.010, calcWidth*0.004, calcWidth*0.003);
  scaleEllipse(topX-calcWidth*0.004,topY+calcHeight*0.030, calcWidth*0.004, calcWidth*0.003);
  scaleEllipse(topX-calcWidth*0.004,topY+calcHeight*0.050, calcWidth*0.004, calcWidth*0.003);

  // make sure pole line has square ends
  noFill();
  strokeCap(SQUARE);

  // draw full width of pole in dark shadow
  stroke(shadowCol);
  scaleStrokeWeight(calcWidth*0.011);
  scaleLine(x,y,topX,topY);

  // fill in the body of the pole with a lighter shade
  stroke(altCol);
  scaleStrokeWeight(calcWidth*0.007);
  scaleLine(x,y,topX,topY);
    
  // add a narrow highlight along the length of the pole
  stroke(baseCol);
  scaleStrokeWeight(calcWidth*0.002);
  scaleLine(x,y,topX,topY);

  // draw right attachments for the wires in front of the pole
  scaleStrokeWeight(calcWidth*0.002);
  stroke(0,0,0,360);
  fill(0,0,100,360);
  scaleEllipse(topX+calcWidth*0.005,topY+calcHeight*0.010, calcWidth*0.006, calcWidth*0.004);
  scaleEllipse(topX+calcWidth*0.005,topY+calcHeight*0.030, calcWidth*0.006, calcWidth*0.004);
  scaleEllipse(topX+calcWidth*0.005,topY+calcHeight*0.050, calcWidth*0.006, calcWidth*0.004);

  // draw grass at base of pole
  noStroke();
  fill(0,0,0,260);
  drawTexture('!', calcWidth*0.006, 0.002, x-calcWidth*0.022, y*1.000, calcWidth*0.047, y*0.004, hue1, 5, 5, 15, 22, 320 );
  drawTexture('|', calcWidth*0.006, 0.002, x-calcWidth*0.020, y*1.000, calcWidth*0.041, y*0.004, hue1, 5, 5, 25, 35, 277 );
  drawTexture("'", calcWidth*0.006, 0.002, x-calcWidth*0.020, y*1.000, calcWidth*0.041, y*0.004, hue1, 5, 5, 25, 35, 277 );

  // sometimes draw small street furniture boxes nearby
  if (random(0,100)>25) {
    drawStreetBox(x*random(0.95,1.05), y, hue1, hue2, hue3);
  }

}

// Draw a newspaper box on the street
//  - x - horizontal position of the box
//  - y - vertical position of the box
//  - hue1 - First color hue to use for elements
//  - hue2 - Second color hue to use for elements
//  - hue3 - Third color hue to use for elements
void drawStreetBox(float x, float y, int hue1, int hue2, int hue3) {
  
  // calculate the dimensions of the box
  float topX=x;
  float h=calcHeight*random(0.028,0.044);
  float topY=y-h;
  float w=calcWidth*random(0.014,0.023);

  // determine main hue for box
  int boxHue=hue1;
  if (random(0,100)>50) {
    boxHue=hue2;
  }
  if (random(0,100)>50) {
    boxHue=hue3;
  }  
  // define three color shades for the box
  color baseCol=color(boxHue,random(18,33),random(65,85),360);
  color highlightCol=color(boxHue,random(15,30),random(75,100),360);

  // make sure box lines have square ends
  noFill();
  strokeCap(SQUARE);

  scaleStrokeWeight(calcWidth*0.0012);  
  stroke(0,0,0,350);

  // draw full width of box in dark shadow
  fill(baseCol);
  scaleRect(topX, topY, w, h);

  // add some texture to the box
 // drawTexture('#',calcWidth*0.01, 0.004, topX+w*0.25, topY+h*0.1, w*0.70, h*0.9, hue1, 5, 10, 44, 66, 220);
  drawTexture('+',calcWidth*0.01, 0.004, topX+w*0.25, topY+h*0.1, w*0.70, h*0.9, boxHue, 8, 12, 33, 44, 220);
  if (random(0,100)>50) {
    drawTexture('=',calcWidth*0.01, 0.004, topX+w*0.25, topY+h*0.1, w*0.70, h*0.9, boxHue, 3, 2, 16, 27, 200);
  }
  if (random(0,100)>50) {
    drawTexture('o',calcWidth*0.01, 0.004, topX+w*0.25, topY+h*0.1, w*0.70, h*0.9, boxHue, 8, 12, 33, 44, 160);
  }

  // draw a clean outline around the box
  noFill();
  stroke(0,0,0,350);
  scaleStrokeWeight(calcWidth*0.0015);
  scaleRect(topX, topY, w, h);

  // draw a darker base on the box
  scaleStrokeWeight(calcWidth*0.0022);
  scaleLine(x,y,x+w,y);

  // add some highlight text on the box
  fill(hue1,random(0,10),random(0,100),322);;
  textSize(scalePixelsX(calcWidth*0.018));
  string chars='TO"*<[]';
  scaleText(chars[floor(random(chars.length))],topX+w*0.5, topY+h*0.33);

  // draw grass at base of box
  noStroke();
  fill(0,0,0,260);
  drawTexture('!', calcWidth*0.008, 0.002, x, y+h*0.02, w*1.2, h*0.05, hue1, 5, 5, 55, 88, 320 );
  drawTexture('x', calcWidth*0.007, 0.002, x, y+h*0.02, w*1.2, h*0.06, hue1, 5, 5, 25, 35, 277 );
  drawTexture('=', calcWidth*0.006, 0.002, x, y+h*0.02, w*1.2, h*0.03, hue1, 5, 5, 15, 32, 277 );

  // if there's not too many already, randomly add another street box next to this one
  numStreetBoxes++;
  if (numStreetBoxes<5 && random(0,100)>35) {
    drawStreetBox(x+w*random(1.05,1.22), y, hue1, hue2, hue3);    
  }
}

// Draw a gently curving line (use for electrical wires to give them some "sag")
//  - x1 - starting horizontal position of the line
//  - y1 - starting vertical position of the line
//  - x2 - midpoint horizontal position of the line
//  - y2 - midpoint vertical position of the line
//  - x3 - ending horizontal position of the line
//  - y3 - ending vertical position of the line
void drawCurvedLine(void x1, void y1, void x2, void y2, void x3, void y3) {
  beginShape();
  scaleCurveVertex(x1,y1);
  scaleCurveVertex(x1,y1)
  scaleCurveVertex(x2,y2);
  scaleCurveVertex(x3,y3);
  scaleCurveVertex(x3,y3);
  endShape();
}

// Draw the lines on the street (to incidate parking spots)
//  - x - starting horizontal position of the lines
//  - y - starting vertical position of the lines
//  - w - width of the lines area
//  - h - height of the lines area
void drawStreetLines(float x, float y, float w, float h) {
  
  noFill();
  stroke(0,0,100,100);
  scaleStrokeWeight(calcWidth*0.006);
  
  scaleLine(x,y,x+w,y);

  stroke(0,0,100,90);
  scaleStrokeWeight(calcWidth*0.005);

  float vx=int(calcWidth*0.5); // vanishing point x
  float vy=int(calcHeight*0.6666); // vanishing point y

  float middle=x+w*random(0.46,0.54);
  scaleLine(middle-w*0.4,y*0.995,vx,vy);
  scaleLine(middle,y*0.995,vx,vy);
  scaleLine(middle+w*0.4,y*0.995,vx,vy);

}

// Draw a white border frame around the final artwork
// Use characters to make the frame look a bit "ragged"
void drawPictureFrame() {
  
  fill(0,0,100,360);   
  stroke(0,0,100,360);
  scaleStrokeWeight(calcWidth*0.0016);

  scaleRect(0,0,calcWidth,calcHeight*0.021);
  drawTexture('=', calcWidth*0.0200, 0.004, 0,0,calcWidth,calcHeight*0.024, 0, 0, 0, 100, 100, 360);

  scaleRect(0,calcHeight*0.985,calcWidth,calcHeight*0.05);
  drawTexture('=', calcWidth*0.0200, 0.0014, 0,calcHeight*0.986,calcWidth,calcHeight*0.05, 0, 0, 0, 100, 100, 360);

  scaleRect(0,0,calcWidth*0.017,calcHeight*1.01);
  drawTexture('!', calcWidth*0.0180, 0.002, 0,0,calcWidth*0.019,calcHeight*1.01, 0, 0, 0, 100, 100, 360);

  scaleRect(calcWidth*0.982,0,calcWidth,calcHeight*1.1);
  drawTexture('!', calcWidth*0.0200, 0.004, calcWidth*0.983,0,calcWidth,calcHeight*1.1, 0, 0, 0, 100, 100, 360);
}

// Return the left split complementary color for a given hue
//  hue - hue to split
color colorSplitComplementLeft(int h) {
  h+=150;
  h=h%360;
  return h;
}

// Return the right split complementary color for a given hue
//  hue - hue to split
color colorSplitComplementRight(int h) {
  h+=210;
  h=h%360;
  return h;
}

// Scale a horizontal (x) position on the canvas to the width of the canvas
// This allows calculations to be done independent of canvas size
//  px - The horizontal x position to scale
float scalePixelsX(px) {
  return int(px*(width/calcWidth));
}

// Scale a vertical (y) position on the canvas to the height of the canvas
// This allows calculations to be done independent of canvas size
//  py - The vertical y position to scale
float scalePixelsY(py) {
  return int(py*(height/calcHeight));
}

// Scale a stroke width to the width of the canvas
// This allows calculations to be done independent of canvas size
//  - px - Stroke width
voide scaleStrokeWeight(px) {
  strokeWeight(scalePixelsX(px)); 
}

// Scale a line to the width of the canvas
// This allows calculations to be done independent of canvas size
//  x1 - start horizontal position of the line
//  y1 - start vertical position of the line
//  x2 - end horizontal position of the line
//  y2 - end vertical position of the line
void scaleLine(float x1, float y1, float x2, float y2) {
  line(scalePixelsX(x1), scalePixelsY(y1), scalePixelsX(x2), scalePixelsY(y2));
}

// Scale a curved line to the width of the canvas
// This allows calculations to be done independent of canvas size
//  x1 - start horizontal position of the line
//  y1 - start vertical position of the line
//  x2 - midpoint horizontal position of the line
//  y2 - midpoint vertical position of the line
//  x3 - end horizontal position of the line
//  y3 - end vertical position of the line
void scaleCurve(float x1, float y1, float x2, float y2, float x3, float y3) {
  curve(scalePixelsX(x1), scalePixelsY(y1), scalePixelsX(x2), scalePixelsY(y2), scalePixelsX(x3), scalePixelsY(y3));
}

// Scale a curve vertex to the width of the canvas
// This allows calculations to be done independent of canvas size
//  x1 - start horizontal position of the curve vertex
//  y1 - start vertical position of the curve vertex
void scaleCurveVertex(float x1, float y1) {
  curveVertex(scalePixelsX(x1), scalePixelsY(y1));
}

// Scale a rectangle's coordinates on the canvas to the width of the canvas
// This allows calculations to be done independent of canvas size
//  x - left x position of the rectangle
//  y - top y position of the rectangle
//  w - width of the rectangle
//  h - height of the rectangle
void scaleRect(float x, float y, float w, float h) {
  rect(scalePixelsX(x), scalePixelsY(y), scalePixelsX(w), scalePixelsY(h));
}

// Scale a text size to the width of the canvas
// This allows calculations to be done independent of canvas size
//  text - text string to be rendered
//  x - left x position of the text
//  y - top y position of the text
void scaleText(string txt, float x, float y) {
  text(txt, scalePixelsX(x), scalePixelsY(y));
}

// Scale an ellipse's coordinates on the canvas to the width of the canvas
// This allows calculations to be done independent of canvas size
//  x - left x position of the ellipse
//  y - top y position of the ellipse
//  w - width of the ellipse
//  h - height of the ellipse
void scaleEllipse(float x, float y, float w, float h) {
  ellipse(scalePixelsX(x), scalePixelsY(y), scalePixelsX(w), scalePixelsY(h));
}
