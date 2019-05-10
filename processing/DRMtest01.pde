import processing.sound.*;
import java.util.Collections;

int nList=2;
int nStim=15;
int W = 640;
int H = 480;
int fps = 10;
int Tinterval = 2;
int Twait = 120;
String fileInit = "test.mp3";
String strtmp;
SoundFile filePlayInit;
SoundFile filePlay[][] = new SoundFile[nList][nStim];
float dt= 1/fps;

ArrayList xList = new ArrayList();
ArrayList xStim = new ArrayList();

Table table = new Table();

int i,j,it,ii, iflag;

void settings() {
  size(W,H);
}

void setup(){
  frameRate(fps);
  filePlayInit = new SoundFile(this, fileInit);
  background(0);
  for (i=0; i<nList; i++){
    for (j=0; j<nStim; j++) {
      strtmp = str(i+1)+"-"+str(j+1)+".mp3";
      filePlay[i][j] = new SoundFile(this, strtmp);
      println(strtmp);
    }
  }
  for (i=0; i<nList; i++) {
    xList.add(i);
  }
  Collections.shuffle(xList);
  for (i=0; i<nList; i++){
    print(xList.get(i)+", ");
  }
  println(" ");
  for (ii=0; ii<nStim; ii++) {
    xStim.add(ii);
  }
  Collections.shuffle(xStim);
  for (ii=0; ii<nStim; ii++){
    print(xStim.get(ii)+", ");
  }
  println(" ");

  //filePlayInit.play();
  it=0;
  iflag=0;
  i=0; j=0;
  
  table.addColumn("# List");
  table.addColumn("# Stim");
  table.addColumn("Played");
}

void draw() {
  if (iflag==0) {
    initPlay();
  }
  else if (iflag==1) {
    stimDRM();
  }
  else if (iflag==2) {
    restDRM();
  }
  else {
    stop();
  }
}

void initPlay(){
  if (it==1) {
    filePlayInit.rate(0.35);
    filePlayInit.play();
    background(0);
    textSize(24);
    textAlign(CENTER);
    fill(255, 255, 255);
    text("Press [N]ext or Play_[A]gain.",W/2,H/2);  
  }
  it++;
  if (keyPressed == true && (key == 'a')) {
        it=0; println(key);
  }
  if (keyPressed == true && (key == 'n')) {
        iflag=1; it=0; println(key);
  } 
}

void stimDRM() {
  if (it==1 && i<nList) {
    background(0);
    textSize(24);
    textAlign(CENTER);
    fill(255, 255, 255);
    filePlay[(int)xList.get(i)][(int)xStim.get(j)].rate(1);
    filePlay[(int)xList.get(i)][(int)xStim.get(j)].play();
    it=2;
    //println(i+" "+j);
  }
  else if (it>1 && it<=Tinterval*fps*2+2) {
    //background(0);
    fill(1);
    int x1=(int)random(0, W-20);
    int y1=(int)random(0, H-20);
    int w1=(int)random(1, 20);
    rect(x1, y1, x1+w1, y1+w1);
  }
  else if (it==Tinterval*fps*2+3) {
    if (i<nList) {
      if (j<nStim-1) {
        j++;        
        it=0;
      }
      else {
        for (ii=0; ii<nStim; ii++) {
          TableRow newRow = table.addRow();
          newRow.setInt("# List",(int)xList.get(i)+1);
          newRow.setInt("# Stim",(ii+1));
          newRow.setInt("Played",(int)xStim.get(ii)+1);
        }    
        xStim = new ArrayList();
        for (ii=0; ii<nStim; ii++) {
          xStim.add(ii);
        }
        Collections.shuffle(xStim);
        for (ii=0; ii<nStim; ii++){
          print(xStim.get(ii)+", ");
        }
        println(" ");
        it=0;
        iflag=2;
      }
    } else {
      background(0);
      textSize(24);
      textAlign(CENTER);
      fill(255, 255, 255);
      text("Finished.", W/2, H/2);
      
      iflag=3;
    }
      
  }  
  it++;
}

void restDRM() {
  it++;
  int d;
  if (it<Twait*fps) {
    background(0);
    textSize(24);
    textAlign(CENTER);
    d=255-(int)(255*it/(Twait*fps));
    fill(d);
    text("Waiting...", W/2, H/2);
  }
  else if (it==Twait*fps) {
    if (i<nList) {
      i++;
      j=0;
      iflag=1;
      it=0;
    } 
    else {
      iflag=3;
    }
  }
  
}

void stop() {
  filePlayInit.stop();
  saveTable(table, "data/DRMtest01_"+year()+month()+day()+hour()+minute()+".csv");
  for (i=0; i<nList; i++) {
    for (j=0; j<nStim; j++) {
      filePlay[i][j].stop();
    }
  } 
  super.stop();
  if (keyPressed == true) {
    exit();
  }
}
