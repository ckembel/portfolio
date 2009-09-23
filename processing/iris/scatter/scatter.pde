Table data;
float dataMin, dataMax;
float xMin, xMax, yMin, yMax;

float plotX1, plotY1;
float plotX2, plotY2;
float labelX, labelY;

int rowCount;
int currentColumn = 0;


int yearInterval = 10;
int volumeInterval = 1;
int volumeIntervalMinor = 1;

PFont plotFont; 


void setup() {
  size(750, 405);
  
  data = new Table("iris.data");
  rowCount = data.getRowCount();

  xMin = 4;
  yMin = 1;
  xMax = 8;
  yMax = 5;
  
  
  // Corners of the plotted time series
  plotX1 = 120; 
  plotX2 = width - 130;
  labelX = 50;
  plotY1 = 60;
  plotY2 = height - 70;
  labelY = height - 25;
  
  plotFont = createFont("SansSerif", 20);
  textFont(plotFont);

  smooth();
}


void draw() {
  background(224);
  
  // Show the plot area as a white box  
  fill(255);
  rectMode(CORNERS);
  noStroke();
  rect(plotX1, plotY1, plotX2, plotY2);

  drawTitle();
  drawAxisLabels();
  drawLegend();
  
  drawYearLabels();
  drawVolumeLabels();

  stroke(#5679C1);
  strokeWeight(5);
  drawDataPoints(currentColumn);
}


void drawTitle() {
  fill(0);
  textSize(20);
  textAlign(LEFT);
  String title = "Sepal Length vs Sepal Width for the IRIS Data Set";
  text(title, plotX1, plotY1 - 10);
}


void drawAxisLabels() {
  fill(0);
  textSize(13);
  textLeading(15);
  
  textAlign(CENTER, CENTER);
  // Use \n (enter/linefeed) to break the text into separate lines
  text("Sepal \nWidth \n(cm)", labelX, (plotY1+plotY2)/2);
  textAlign(CENTER);
  text("Sepal Length \n(cm)", (plotX1+plotX2)/2, labelY);
}


void drawYearLabels() {
  fill(0);
  textSize(10);
  textAlign(CENTER, TOP);
  
  // Use thin, gray lines to draw the grid
  stroke(224);
  strokeWeight(1);
  
  for (int row = 0; row < rowCount; row++) {
   // if (years[row] % yearInterval == 0) {
    //  float x = map(years[row], yearMin, yearMax, plotX1, plotX2);
     // text(years[row], x, plotY2 + 10);
     // line(x, plotY1, x, plotY2);
   // }
  }
}


void drawVolumeLabels() {
  fill(0);
  textSize(10);
  
  stroke(128);
  strokeWeight(1);

  for (float v = yMin; v <= yMax; v += volumeIntervalMinor) {
    if (v % volumeIntervalMinor == 0) {     // If a tick mark
      float y = map(v, yMin, yMax, plotY2, plotY1);  
      if (v % volumeInterval == 0) {        // If a major tick mark
        if (v == yMin) {
          textAlign(RIGHT);                 // Align by the bottom
        } else if (v == yMax) {
          textAlign(RIGHT, TOP);            // Align by the top
        } else {
          textAlign(RIGHT, CENTER);         // Center vertically
        }
        text(floor(v), plotX1 - 10, y);
        line(plotX1 - 4, y, plotX1, y);     // Draw major tick
      } else {
        // Commented out, too distracting visually
        //line(plotX1 - 2, y, plotX1, y);   // Draw minor tick
      }
    }
  }
  
  for (float v = xMin; v <= xMax; v += volumeIntervalMinor) {
    if (v % volumeIntervalMinor == 0) {     // If a tick mark
      float x = map(v, xMin, xMax, plotX1, plotX2);  
      if (v % volumeInterval == 0) {        // If a major tick mark
                   // Align by the top
        
          textAlign(CENTER, CENTER);         // Center vertically
        
        text(floor(v), x, plotY2 + 10);
        line(x, plotY2 + 4, x, plotY2);     // Draw major tick
      } else {
        // Commented out, too distracting visually
        //line(plotX1 - 2, y, plotX1, y);   // Draw minor tick
      }
    }
  }
}


void drawDataPoints(int col) {
  for (int row = 0; row < rowCount; row++) {
      String type = data.getString(row,4);
     if(type.equals("Iris-setosa"))
        stroke(255,64,64);
     else if(type.equals("Iris-versicolor"))
        stroke(35,35,142);
     else
        stroke(255,20,147);
      float valueX = data.getFloat(row, 0);
      float valueY = data.getFloat(row, 1);
      float x = map(valueX, xMin, xMax, plotX1, plotX2);
      float y = map(valueY, yMin, yMax, plotY2, plotY1);
      point(x, y);
    
  }
}

void drawLegend(){
  float interval;
  interval = plotY2 - plotY1;
  interval = interval/2 + plotY1;
  fill(0);
  textSize(13);
  textLeading(15);
  
   textAlign(LEFT);
  // Use \n (enter/linefeed) to break the text into separate lines
  text("Iris-setosa", plotX2 +30, interval - 20);
  text("Iris-versicolor", plotX2+30, interval);
  text("Iris-virginica", plotX2+30, interval+20);
  fill(255,64,64);
  rect(plotX2+15, interval - 30, plotX2 +25, interval - 20); 
  fill(35,35,142);
  rect(plotX2+15, interval - 10, plotX2 +25, interval);
  fill(255,20,147);
  rect(plotX2+15, interval +10, plotX2 +25, interval + 20);
}


