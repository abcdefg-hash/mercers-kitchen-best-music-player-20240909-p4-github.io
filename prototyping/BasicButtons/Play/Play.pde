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
float playButton1X, playButton1Y, playButton2X, playButton2Y, playButton3X, playButton3Y;
//
color purple=#DB05FF, yellow=#E9FF00, blue=#0700F5, green=#46FA00, black=#000000, white=#ffffff, orange=#FAA423, red=#F50002;
color dayForeground=red, dayHoverover=blue, dayBackground=white;
color darkForeground=yellow, darkHoverover=green, darkBackground=black;
color nightForeground=green, nightHoverover=orange, nightBackground=black;
color appColorForeground, appColorHoverover, appColorBackground;
color stopButtonHoverOver;
//
Boolean colorDarkMode=true;//true or false up to you
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
  playButton1X = stopX = musicButtonSquareX + musicButtonSquareWidth*1/4;
  playButton1Y = stopY = musicButtonSquareY + musicButtonSquareHeight*1/4;
  playButton2X = stopX = musicButtonSquareX + musicButtonSquareWidth*3/4;
  playButton2Y = stopY = musicButtonSquareY + musicButtonSquareHeight*1/2;
  playButton3X = stopX = musicButtonSquareX + musicButtonSquareWidth*1/4;
  playButton3Y = stopY = musicButtonSquareY + musicButtonSquareHeight*3/4;
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
  //song[currentSong].play();
  //rect( X, Y, Width, Height );
  //rect( musicButtonDIV_X, musicButtonDIV_Y, musicButtonDIV_Width, musicButtonDIV_Height );
  if ( hour()<=7 || hour()>17 ) {
    //nightmode
    appColorForeground = nightForeground;
    appColorHoverover = nightHoverover;
    appColorBackground = nightBackground;
  } else if ( colorDarkMode=true && hour()>=7 || hour()<17 ) {
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
  background(0); // Gray Scale: 0-255
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
  noStroke(); //I think its the line
  //
  triangle(playButton1X, playButton1Y, playButton2X, playButton2Y, playButton3X, playButton3Y);
  fill(255);//padding colour
  stroke(1);
} //End draw
//
void mousePressed() {
  //Boolean for Click
  //if() {} else {}
  if ( mouseX>musicButtonSquareX && mouseX<musicButtonSquareX+musicButtonSquareWidth && mouseY>musicButtonSquareY && mouseY<musicButtonSquareY+musicButtonSquareHeight ) {
    song[currentSong].loop(0);//"play" button("loop" button if double tap)
  }
} //End mousePressed


//
void keyPressed() {
  if ( key=='P' || key=='p' ) song[currentSong].play(); //press once play and rewind for second
  if ( key=='S' | key=='s' ) {
    if ( song[currentSong].isPlaying() ) {
      song[currentSong].pause(); //single tap pause
    } else {
      song[currentSong].rewind(); //double tap rewind
    }
  }
  if ( key=='L' || key=='l' ) song[currentSong].loop(1); // plays twice
  if ( key=='K' || key=='k' ) song[currentSong].loop(); // infinte(0 or -1 or blank)
  if ( key=='F' || key=='f' ) song[currentSong].skip( 10*1000 ); // Fast Forward, Rewind, & Play Again //Parameter MILISECONDS
  if ( key=='R' || key=='r' ) song[currentSong].skip( -10*1000 ); // Fast Reverse
  if ( key=='M' || key=='m' ) { //mute
    //
    if ( song[currentSong].isMuted()  ) {
      song[currentSong].unmute();
    } else {
      song[currentSong].mute();
    }
  }
  if ( key=='O' || key=='o' ) { //pause
    //
    if ( song[currentSong].isPlaying() ) {
      song[currentSong].pause();
    } else {
      song[currentSong].play();
    }
  }
  if ( key==CODED || keyCode==ESC ) exit(); // quit up
  if ( key=='Q' || key=='q' ) exit(); // up
  //
  if ( key=='N' || key=='n' ) ; // next
  if (song[currentSong].isPlaying()) {
    song[currentSong].pause();
    song[currentSong].rewind();
    //
    if (currentSong==2) {
      currentSong = 0;
    } else {
      currentSong++;
    }
    println("the current song is", currentSong);
    song[currentSong].play();
  } else {
    println("the current song is", currentSong);
  }




  //if ( key=='' || key=='' ) ; // Shuffle - PLAY (Random)
  //if ( key=='' || key=='' ) ; // Play-Pause-STOP
  //Note: CAP Lock with ||
  // if ( key=='p' || key=='P' )   song[currentSong].play();//"play" button
  //
  //if ( key=='p' || key=='P' )   song[currentSong].loop(0);//"play" button("loop" button if double tap)
  //
  //if ( key=='s' || key=='S' )   song[currentSong].pause();//"stop" button no double tap

  //End keyPressed
  //
  // End Main Program
}
