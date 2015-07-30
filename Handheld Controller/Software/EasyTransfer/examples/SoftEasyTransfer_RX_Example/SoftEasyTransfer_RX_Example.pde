#include <NewSoftSerial.h>
#include <SoftEasyTransfer.h>

//create Serial Port
NewSoftSerial mySerial(2,3);
//create object
SoftEasyTransfer ET; 

struct RECEIVE_DATA_STRUCTURE{
  //put your variable definitions here for the data you want to receive
  //THIS MUST BE EXACTLY THE SAME ON THE OTHER ARDUINO
  int blinks;
  int pause;
};

//give a name to the group of data
RECEIVE_DATA_STRUCTURE mydata;

void setup(){
  mySerial.begin(9600);
  //start the library, pass in the data details and the name of the serial port.
  ET.begin(details(mydata), &mySerial);
  
  pinMode(13, OUTPUT);
  
}

void loop(){
  //check and see if a data packet has come in. 
  if(ET.receiveData()){
    //this is how you access the variables. [name of the group].[variable name]
    //since we have data, we will blink it out. 
    for(int i = mydata.blinks; i>0; i--){
      digitalWrite(13, HIGH);
      delay(mydata.pause * 100);
      digitalWrite(13, LOW);
      delay(mydata.pause * 100);
    }
  }
  
  delay(250);
}
