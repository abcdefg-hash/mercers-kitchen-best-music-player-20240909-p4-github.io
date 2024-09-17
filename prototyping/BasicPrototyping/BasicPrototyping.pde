import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;
//
//Global variables
Minim minim;
int numberOfsongs = 3; // Able to autodetect based on pathway
AudioPlayer[] song = new AudioPlayer[numberOfsongs];
int currentSong = numberOfsongs - numberOfsongs; //beginning current song as ZERO
//
void setup() 
{
  size(900, 800);
  //
  minim = new Minim(this);// load from a data directory
  // Load Music
  String musicPathway = "Music/";
  String mp3FileName = ".mp3";
  String beatYourCompetition = "Beat_Your_Competition";
  String cycles = "Cycles";
  String eureka = "Eureka";
  song[currentSong] =minim.loadFile("../../Music/Beat_Your_Competition.mp3"); //../../ + musicPathway + cycles + mp3FileName
  //song[currentSong+=1] =minim.loadFile("../../Music/cycles");
  //song[currentSong+=1] =minim.loadFile("../../Music/eureka");
  song[currentSong].play();
} //End setup
//
void draw() {
} //End draw
//
void mousePressed() {
} //End mousePressed
//
void keyPressed() {
} //End keyPressed
//
// End Main Progam
