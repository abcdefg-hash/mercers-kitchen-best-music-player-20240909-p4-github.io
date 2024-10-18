import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;
//
//Global Variables
Minim minim;
int numberOfSongs = 3; //Able to Autodetect based on Pathway
AudioPlayer[] song = new AudioPlayer[numberOfSongs];
int currentSong = numberOfSongs - numberOfSongs;  //beginning current song as ZERO
//
int appWidth, appHeight;
//CAUTION: IF Statement Variable Population
float musicButtonDIV_X, musicButtonDIV_Y, musicButtonDIV_Width, musicButtonDIV_Height;
float musicButtonSquareX, musicButtonSquareY, musicButtonSquareWidth, musicButtonSquareHeight;
float stopX, stopY, stopWidth, stopHeight;
float quitLineWeight
//
color purple=#DB05FF, yellow=#E9FF00, blue=#0700F5, green=#46FA00, black=#000000, white=#ffffff, orange=#FAA423, red=#F50002;
color dayForeground=red, dayHoverover=blue, dayBackground=white;
color darkForeground=yellow, darkHoverover=green, darkBackground=black;
color nightForeground=green, nightHoverover=orange, nightBackground=black;
color appColorForeground, appColorHoverover, appColorBackground;
color stopButtonHoverOver;
//
Boolean colorDarkMode=false;//true or false up to you
//
void setup()
{
  size(1000, 800);
  appWidth = width;
  appHeight = height;
  //Variables for any music button
  musicButtonDIV_Width = appWidth*1/2;
  musicButtonDIV_Height = appHeight*1/2;
  musicButtonDIV_X = musicButtonDIV_Width - musicButtonDIV_Width*1/2;
  musicButtonDIV_Y = musicButtonDIV_Height- musicButtonDIV_Height*1/2;
  //
  //variable population
  //
  if ( musicButtonDIV_Width >= musicButtonDIV_Height ) {
    //
    musicButtonSquareWidth = musicButtonDIV_Height ;
    musicButtonSquareHeight = musicButtonDIV_Height ;
    float padding1 = musicButtonDIV_Width - musicButtonDIV_Height;
    float padding2 = padding1*1/2;
    musicButtonSquareX = musicButtonDIV_X + padding2 ;
    musicButtonSquareY = musicButtonDIV_Y;
  } else { //Portrait
    // musicButtonHeight needs to change
    musicButtonSquareWidth = musicButtonDIV_Width ;
    musicButtonSquareHeight = musicButtonDIV_Width;
    float padding1 = musicButtonDIV_Height - musicButtonDIV_Width; //working out value needed, with formulae
    float padding2 = padding1*1/2; ////working out value needed, with formulae
    musicButtonSquareX = musicButtonDIV_X; //note: minus moves it the wrong way, difficult to see
    musicButtonSquareY = musicButtonDIV_Y + padding2;
  }
  //
  stopWidth = musicButtonSquareWidth*1/2;
  stopHeight = musicButtonSquareHeight*1/2;
  stopX = musicButtonSquareX + musicButtonSquareWidth*1/4;
  stopY = musicButtonSquareY + musicButtonSquareHeight*1/4;
  quitLineWeight = (musicButtonSquareWidth/musicButtonSquareWidth) + musicButtonSquareWidth*1/8;
  quitbuttonX1 = stopX;
  quitbuttonY1 = stopY;
  quitbuttonX2 = stopX + stopWidth;
  quitbuttonY2 = stopY + stopHeight;
  quitbuttonX3 = stopX;
  quitbuttonY3 = stopY;
  quitbuttonX4 = stopX;
  quitbuttonY4 = stopY;
  //
  minim = new Minim(this); //load from data directory, loadFile should also load from project folder
  //
  // Load Music
  String musicPathway = "Music/";
  String mp3FileName = ".mp3";
  //Alphebetical order, same as OS ordering files
  String beatYourCompetition = "Beat_Your_Competition";
  String cycles = "Cycles";
  String newsroom = "Newsroom";
  //
  //Add Reading into Array
  String directory = "../../../" + musicPathway;
  String file = directory + cycles + mp3FileName;
  song[currentSong] = minim.loadFile( file );
  file = directory + beatYourCompetition + mp3FileName;
  song[currentSong+=1] = minim.loadFile( file );
  file = directory + cycles + mp3FileName;
  song[currentSong+=1] = minim.loadFile( file );
  file = directory + newsroom + mp3FileName;
  //
  currentSong = 0;
  //
  song[currentSong].play();
  //rect( X, Y, Width, Height );
  //rect( musicButtonDIV_X, musicButtonDIV_Y, musicButtonDIV_Width, musicButtonDIV_Height );
  if ( colorDarkMode==false && hour()<=7 || hour()>17 ) {
    //nightmode
   appColorForeground = nightForeground;
   appColorHoverover = nightHoverover;
   appColorBackground = nightBackground;
  } else if ( colorDarkMode==true && hour()>=7 || hour()<17 ) {
    //day mode 
   appColorForeground = dayForeground;
   appColorHoverover = dayHoverover;
   appColorBackground = dayBackground;
  } else {
    // dark mode  
   appColorForeground = darkForeground;
   appColorHoverover = darkHoverover;
   appColorBackground = darkBackground;
  }
} //End setup
//
void draw() {
  background(appColorBackground); // Gray Scale: 0-255
  //
  rect( musicButtonSquareX, musicButtonSquareY, musicButtonSquareWidth, musicButtonSquareHeight );
  //
  /* Note: 3 types of colour, in pairs for hoverover
   day: hoverover: blue #0700F5 background: #FFFFFF  foreground:red #F50002
   dark: hoverover green #46FA00 background #000000 foreground: yellow #E9FF00
   night: hoverover orange #FAA423 background #000000 foreground green #46FA00
   */
  //if ( day ) {} else if ( dark ) {} else {}
  //
  if ( mouseX>musicButtonSquareX && mouseX<musicButtonSquareX+musicButtonSquareWidth && mouseY>musicButtonSquareY && mouseY<musicButtonSquareY+musicButtonSquareHeight) {
    stopButtonHoverOver = appColorHoverover;//see setup: single line ifs for day, dark and night boleans
  } else {
    stopButtonHoverOver=appColorForeground;//see setup: single line ifs for day, dark and night boleans
  }
  fill(stopButtonHoverOver);//yellow and purple
  //stroke(); //I think its the line
  //
  strokeWeight(quitStrokeWeight);
  line(quitbuttonX1,quitbuttonY1,quitbuttonX2,quitbuttonY2);
  line(quitbuttonX3,quitbuttonY3,quitbuttonX4,quitbuttonY4);
  //rect( stopX, stopY, stopWidth, stopHeight ); //(X, Y, width, height, roundedEdge1, roundedEdge2, roundedEdge3, roundedEdge4, )
  fill(255);//padding colour
  //noStroke(1);
} //End draw
//
void mousePressed() {
  //Boolean for Click
  //if() {} else {}
  if ( mouseX>musicButtonSquareX && mouseX<musicButtonSquareX+musicButtonSquareWidth && mouseY>musicButtonSquareY && mouseY<musicButtonSquareY+musicButtonSquareHeight ) {
    if ( song[currentSong].isPlaying() ) {
      song[currentSong].pause(); //single tap
    } else {
      song[currentSong].rewind(); //double tap
    }
  }
} //End mousePressed


//
void keyPressed() {
  //Note: CAP Lock with ||
  // if ( key=='p' || key=='P' )   song[currentSong].play();//"play" button
  //
  if ( key=='p' || key=='P' )   song[currentSong].loop(0);//"play" button("loop" button if double tap)
  //
  //if ( key=='s' || key=='S' )   song[currentSong].pause();//"stop" button no double tap

  //End keyPressed
  //
  // End Main Program
}
