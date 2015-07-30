#include <NewSoftSerial.h>
#include <SoftEasyTransfer.h>

//create software serial port
NewSoftSerial mySerial(2, 3);
//create object
SoftEasyTransfer ET; 
bool master;

struct SEND_DATA_STRUCTURE{
  char switches; // 00000000 - each bit = 1 switch
};

//give a name to the group of data
SEND_DATA_STRUCTURE mydata;

void setup(){
  Serial.begin(9600);
  mySerial.begin(9600);
  //start the library, pass in the data details and the name of the serial port.
  ET.begin(details(mydata), &mySerial);
  
  pinMode(13, OUTPUT);
  pinMode(12, INPUT);
  pinMode(8, INPUT);
  master = false;  
}

void loop(){
  if(ET.receiveData()){
    if(mydata.switches == 'a'){
      digitalWrite(13,HIGH);
    } else if (mydata.switches == 0){
      digitalWrite(13,LOW);
    }
  }
  delay(500);
}

