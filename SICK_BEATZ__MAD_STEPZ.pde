//import midim library that you can download here: http://code.compartmental.net/tools/minim/
//needed to record audio
import ddf.minim.*;
Minim minim;
AudioInput in;
AudioRecorder recorder;

//import sound library and make 4 soundfiles for 4 tracks
import processing.sound.*;

SoundFile soundfile;
SoundFile soundfile2;
SoundFile soundfile3;
SoundFile soundfile4;

//setup for the generative art
int num = 30;
float incr = 1.3, decr = 0.8, v=2.0;
PVector[] loc = new PVector[num];
PVector[] vel = new PVector[num];
float[] sz = new float[num];


void setup() {
  size(800, 600); // P2D or P3D or OPENGL or nothing, in this case - nothing
  frame.setResizable(true);
  frameRate(10);
 
  initStuff();
  
  //save the audio as
  minim = new Minim(this);
  in = minim.getLineIn();
  recorder = minim.createRecorder(in, "sick_beatz_mad_stepz2.wav");
        
    //Load a soundfile
    soundfile = new SoundFile(this, "beat1.wav");
    soundfile2 = new SoundFile(this, "beat2.wav");
    soundfile3 = new SoundFile(this, "drums.wav");
    soundfile4 = new SoundFile(this, "voice.wav");

    // These methods return useful infos about the file
    println("SFSampleRate= " + soundfile.sampleRate() + " Hz");
    println("SFSamples= " + soundfile.frames() + " samples");
    println("SFDuration= " + soundfile.duration() + " seconds");

}      


void draw() {
  if (frameCount%150==0) {
    background(0);
    //fill(0);
    //noStroke();
    //rect(0, 0, width, height);
  }
    for (int i=0; i<loc.length; i++) {
    loc[i].add(vel[i]);
    if (loc[i].x > width-sz[i]/2 || loc[i].x<sz[i]/2) {
      vel[i].x = -vel[i].x;
    }
    if (loc[i].y > height-sz[i]/2 || loc[i].y<sz[i]/2) {
      vel[i].y = -vel[i].y;
    }
  }
  drawElement();
  
  //record audio
   if ( recorder.isRecording() )
  {
    text("Currently recording...", 5, 15);
  }
  else
  {
    text("Not recording.", 5, 15);
  }
}

void drawElement() {
  for (int i=0; i<loc.length; i++) {
    stroke(255,20);
    for (int j=0; j<loc.length; j++) {
      float distance=dist(loc[i].x, loc[i].y, loc[j].x, loc[j].y);
      float proximity=(sz[i]+sz[j])/2;
      if (distance<proximity) {
        if (i != j) line(loc[i].x, loc[i].y, loc[j].x, loc[j].y);
      }
    }
  }
}

void keyPressed(){

//4 keys are assigned to 4 different tracks, 
//later they will be connected to the pressure sensors
if (key == 'q')
 soundfile.play();
  initStuff();

if (key == 'w')
 soundfile2.play();
 initStuff();
 
if (key == 'e')
  soundfile3.play();
  initStuff();
  
if (key == 'r')
  soundfile4.play(); 
  initStuff();
}

void keyReleased(){

  if (key == 'q')
  soundfile.stop();


if (key == 'w')
  soundfile2.stop();

  
if (key == 'e')
  soundfile3.stop();

  
if (key == 'r')
  soundfile4.stop();

  if ( key == 'd' ) 
  {
    // to indicate that you want to start or stop capturing audio data, you must call
    // beginRecord() and endRecord() on the AudioRecorder object. You can start and stop
    // as many times as you like, the audio data will be appended to the end of whatever 
    // has been recorded so far.
    if ( recorder.isRecording() ) 
    {
      recorder.endRecord();
    }
    else 
    {
      recorder.beginRecord();
    }
  }
  if ( key == 's' )
  {
    // we've filled the file out buffer, 
    // now write it to the file we specified in createRecorder
    // the method returns the recorded audio as an AudioRecording, 
    // see the example  AudioRecorder >> RecordAndPlayback for more about that
    recorder.save();
    println("Done saving.");
  }
}

//void mouseReleased() {
//  initStuff();
//}

void initStuff() {
  background(0);
  for (int i=0; i<num; i++) {
    sz[i] = random(width/10, width/5);
    float x = random(sz[i], width-sz[i]);
    float y = random(sz[i], height-sz[i]);
    loc[i] = new PVector(x, y);
    vel[i] = new PVector(random(-v, v), random(-v, v));
  }
}
//void stop(){
//  soundfile.stop();
//}