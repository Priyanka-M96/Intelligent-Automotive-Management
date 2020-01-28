import processing.serial.*;
import ddf.minim.*;

Minim minim;
Minim minim2;
AudioPlayer player;
AudioPlayer player2;

int lf = 10;    // Linefeed in ASCII
String myString = null;
Serial myPort;  // The serial port


void setup() {
  // List all the available serial ports
  printArray(Serial.list());
  // Open the port you are using at the rate you want:
  myPort = new Serial(this, Serial.list()[2], 9600);
  myPort.clear();
  // Throw out the first reading, in case we started reading 
  // in the middle of a string from the sender.
  myString = myPort.readStringUntil(lf);
  myString = null;
  // we pass this to Minim so that it can load files from the data directory
  minim = new Minim(this);
    minim2 = new Minim(this);
  // loadFile will look in all the same places as loadImage does.
  // this means you can find files that are in the data folder and the 
  // sketch folder. you can also pass an absolute path, or a URL.
  // Change the name of the audio file here and add it by clicking on "Sketch —> Import File"
player = minim.loadFile("w.mp3", 2048);
player2 = minim2.loadFile("nn.mp3", 2048);
  
}

void draw() {
  // check if there is something new on the serial port
  while (myPort.available() > 0) {
    // store the data in myString 
    myString = myPort.readStringUntil(lf);
    // check if we really have something
    if (myString != null) {
      myString = myString.trim(); // let's remove whitespace characters
      // if we have at least one character...
      if(myString.length() > 0) {
        println(myString); // print out the data we just received
        // if we received a number (e.g. 123) store it in sensorValue, we sill use this to change the background color. 
        
        if(myString.equals("1")){
          if(player.isPlaying() == false){
              
            player.play();
          }
        }
         if(myString.equals("2")){
          if(player2.isPlaying() == false){
              
            player2.play();
          }
        }
       
      }
    }
  }
}