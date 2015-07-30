#include <NewSoftSerial.h>
#include <SoftEasyTransfer.h>
#include "Locomotion.h"
#define m_SPEED 16338
#define m_DIR  false
//create software serial port
NewSoftSerial mySerial(2, 3);
bool master;
Locomotion loco(50,true);
ComInterface *com = &loco;
int counter;

void setup(){
  counter = 0;
Serial.begin(9600);
mySerial.begin(57600);
Serial.println("setup");
 
  
  pinMode(13, OUTPUT);
  pinMode(11, OUTPUT);
  
  pinMode(8, INPUT);
  if(digitalRead(8)==1){
    master = true;
  } else {
    master = false;
  }
  if(master)
  {
    pinMode(12,INPUT);
    Serial.println("Master");
    loco.setSpeed(m_SPEED);
    //loco.setDirectionForward(m_DIR);
  } else {
    pinMode(12,OUTPUT);
    Serial.println("Slave");
    loco.setSpeed(100);
    loco.setDirectionForward(false);
  }
  analogReference(EXTERNAL); 
}

void loop(){
  Serial.println(counter);
  if(master){
    if(digitalRead(12) == 1){
      loco.setDirectionForward(true);
    } else {
      loco.setDirectionForward(false);
    }
    digitalWrite(13,HIGH);
    loco.sendData(&mySerial,0,0);
    delay(500);
    uint16_t temp = 0;
    loco.setSpeed(temp = analogRead(A0));
    Serial.println((int)temp);   
  } else if (!master){
    if(com->receiveData(&mySerial)){
      Serial.println("Received Data");
      Serial.println("-----------------");
      Serial.println("loco.getSpeed():");
      Serial.println((int)loco.getSpeed());
      Serial.println("-----------------");
      Serial.println("loco.isDirectionForward():");
      Serial.println((int)loco.isDirectionForward());
      Serial.println("-----------------");
      analogWrite(11,(int)loco.getSpeed());
      if(loco.isDirectionForward()){
        //set to 0v forward
        digitalWrite(12,LOW);
      }else {
        // set to +5v reverse
        digitalWrite(12,HIGH);
      }
    }
    delay(250);
  }
digitalWrite(13,LOW);
delay(100);
}

