import proxml.*;

Data data;

int sW = 720;
int sH = 405;
int fps = 24;

proxml.XMLElement keyFrameList;
XMLInOut xmlIO;
boolean loaded = false;

String[] oscNames = {
  "r_hand","r_elbow","r_shoulder", "l_hand","l_elbow","l_shoulder","head"
};

int[] pinNums = {
  1,2,3,4,5,6,7
};

float posX,posY,posZ;


void setup() {
  //size(sW,sH);
  //frameRate(fps);

  xmlIO = new XMLInOut(this);
  try {
    xmlIO.loadElement("mocapData.xml"); //loads the XML
  }
  catch(Exception e) {
    //if loading failed 
    println("Loading Failed");
  }

  data = new Data();
  data.beginSave();
  data.add("Adobe After Effects 8.0 Keyframe Data");
  data.add("\r");
  data.add("\t"+"Units Per Second"+"\t"+fps);
  data.add("\t"+"Source Width"+"\t"+"100");
  data.add("\t"+"Source Height"+"\t"+"100");
  data.add("\t"+"Source Pixel Aspect Ratio"+"\t"+"1");
  data.add("\t"+"Comp Pixel Aspect Ratio"+"\t"+"1");
}

void xmlEvent(proxml.XMLElement element) {
  //this function is ccalled by default when an XML object is loaded
  keyFrameList = element;
  //parseXML(); //appelle la fonction qui analyse le fichier XML
  loaded = true;
}

void draw() {
  if(loaded) {
    
    for(int j=0;j<oscNames.length;j++){
    data.add("\r");
    data.add("Effects" + "\t" + "Puppet #2" + "\t" + "arap #3" + "\t" + "Mesh" + "\t" + "Mesh #1" + "\t" + "Deform" + "\t" + "Pin #" + pinNums[j] + "\t" + "Position");
    data.add("\t" + "Frame" + "\t" + "X pixels" + "\t" + "Y pixels");
    for(int i=0;i<keyFrameList.countChildren();i++) { // i=1 because 0 is the frame number
      data.add("\t" + i  
      + "\t" + (sW * float(keyFrameList.getChild(i).getChild(j+1).getChild(0).getChild(0).toString()))
      + "\t" + (sH * float(keyFrameList.getChild(i).getChild(j+1).getChild(1).getChild(0).toString()))); //gets to the child we need //gets to the child we need
    }
    }


    data.add("\r");
    data.add("\r");
    data.add("End of Keyframe Data");
    data.endSave(
    data.getIncrementalFilename(
    sketchPath("save"+
      java.io.File.separator+
      "data ####.txt")));
    exit();
  }
}

