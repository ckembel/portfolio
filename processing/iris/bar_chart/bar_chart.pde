Table data;
float dataMin, dataMax;

float plotX1, plotY1;
float plotX2, plotY2;
float labelX, labelY;

int rowCount;
int columnCount;
int currentColumn = 0;

int xMin, xMax;

int yearInterval = 10;
int volumeInterval = 2;

PFont plotFont; 


void setup() {
  size(720, 405);
  
  data = new Table("iris.data");
  rowCount = data.getRowCount();
  
  xMin = 0;
  xMax = 3;
  
  dataMin = 0;
  dataMax = 10;
  

   



  // Corners of the plotted time series
  plotX1 = 120; 
  plotX2 = width - 80;
  labelX = 50;
  plotY1 = 60;
  plotY2 = height - 70;
  labelY = height - 25;
  
  float plotW = plotX2 - plotX1;
  
  plotFont = createFont("SansSerif", 20);
  textFont(plotFont);

  smooth();
}


void draw() {
  background(224);
  
  fill(255);
rectMode(CORNERS);
noStroke( );
rect(plotX1, plotY1, plotX2, plotY2);

  
  drawTitle();
  drawAxisLabels();
  drawVolumeLabels();

  noStroke();
  fill(#5679C1);
  drawDataBars(currentColumn);
  
  drawYearLabels();
}


void drawTitle() {
  fill(0);
  textSize(20);
  textAlign(LEFT);
  String title = "Mean & Range of Sepal Length & Width for IRIS data";
  text(title, plotX1, plotY1 - 10);
}


void drawAxisLabels() {
  fill(0);
  textSize(13);
  textLeading(15);
  
  textAlign(CENTER, CENTER);
  text("Centimeters \n(cm)", labelX, (plotY1+plotY2)/2);

}


void drawYearLabels() {
  fill(0);
  textSize(10);
  textAlign(CENTER);
  
  // Use thin, gray lines to draw the grid
  stroke(255);
  strokeWeight(1);
  
  for (int row = 0; row < rowCount; row++) {
    //if (years[row] % yearInterval == 0) {
     // float x = map(years[row], yearMin, yearMax, plotX1, plotX2);
      //text(years[row], x, plotY2 + textAscent() + 10);
      //line(x, plotY1, x, plotY2);
    //}
  }
}


int volumeIntervalMinor = 1;   // Add this above setup()

void drawVolumeLabels() {
  fill(0);
  textSize(10);
  textAlign(RIGHT);
  
  stroke(128);
  strokeWeight(1);

  for (float v = dataMin; v <= dataMax; v += volumeIntervalMinor) {
    if (v % volumeIntervalMinor == 0) {     // If a tick mark
      float y = map(v, dataMin, dataMax, plotY2, plotY1);  
      if (v % volumeInterval == 0) {        // If a major tick mark
        float textOffset = textAscent()/2;  // Center vertically
        if (v == dataMin) {
          textOffset = 0;                   // Align by the bottom
        } else if (v == dataMax) {
          textOffset = textAscent();        // Align by the top
        }
        text(floor(v), plotX1 - 10, y + textOffset);
        line(plotX1 - 4, y, plotX1, y);     // Draw major tick
      } else {
       
       
        line(plotX1 - 2, y, plotX1, y);     // Draw minor tick
      }
    }
  }
}


float barWidth = 60;  // Add this line above setup()

void drawDataBars(int col) {
  noStroke();
  rectMode(CORNERS);
  String dataName = "";
      
      for(int i = 0; i < 2; i++){
        if( i == 0)
          dataName = "Sepal Length";
        if( i == 1)
          dataName = "Sepal Width";
        float value = getMean(i);
        float x1 = map(i+.8, xMin, xMax, plotX1, plotX2);
        float y1 = map(value, dataMin, dataMax, plotY2, plotY1);
        rect(x1-barWidth/2, y1, x1+barWidth/2, plotY2);
        fill(0);
        textSize(10);
        textAlign(CENTER);
        text("Mean", x1, plotY2+10);
        text(value, x1, y1 - 10);
        fill(#5679C1);
        
        value = getRange(i);
        float x2 = map(i+1.2, xMin, xMax, plotX1, plotX2);
        float y2 = map(value, dataMin, dataMax, plotY2, plotY1);
        rect(x2-barWidth/2, y2, x2+barWidth/2, plotY2);
        fill(0);
        text("Range", x2, plotY2+10);
        text(value, x2, y2 - 10);
        
        textSize(14);
        text(dataName, (x1+x2)/2, plotY2+25);
        fill(#5679C1);
        
        
       }
  
}


void drawDataArea(int col) {
  beginShape();
  for (int row = 0; row < rowCount; row++) {
    
      //float value = data.getFloat(row, col);
     // float x = map(years[row], yearMin, yearMax, plotX1, plotX2);
      //float y = map(value, dataMin, dataMax, plotY2, plotY1);
     // vertex(x, y);
    
  }
  // Draw the lower-right and lower-left corners
  vertex(plotX2, plotY2);
  vertex(plotX1, plotY2);
  endShape(CLOSE);
}

float getMean(int col){
   float sum = 0;
   for( int row = 0; row < rowCount; row++){
      sum = sum + data.getFloat(row, col);
   } 
   return sum/rowCount;
  
}

float getVar(int col){
  float sum = 0;
  float mean = getMean(col);
  for(int row = 0; row < rowCount; row++){
     sum = sum + (data.getFloat(row,col) - mean)*(data.getFloat(row,col) - mean);
  }
  return sum/(rowCount-1);
}


float getRange(int col){
  float Min, Max;
  Min = MAX_FLOAT;
  Max = MIN_FLOAT;
 
  
  for (int row = 0; row < rowCount; row++) {
    float value = data.getFloat(row, col);
    if (value > Max) {
      Max = value;
    }
    if (value < Min) {
      Min = value;
    }
  }
  return Max - Min;
  
}


