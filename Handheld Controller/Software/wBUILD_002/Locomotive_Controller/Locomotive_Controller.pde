#include <NewSoftSerial.h>
#include "Locomotion.h"
#define m_SPEED 16338
#define m_DIR  false

#define DIRECTION_INPUT 12
#define DIRECTION_OUTPUT 12
#define SPEED_INPUT A0
#define SPEED_OUTPUT 11
#define MASTER_SEL 8
#define TRANSMIT_PIN 2
#define RECEIVE_PIN 3
#define LED_HEART 13

// LED HEART BEAT CODE
long prevMillis = 0;
long currentMillis = 0;
int heartState = 0;
long beatInterval = 0;


//create software serial port
NewSoftSerial mySerial(TRANSMIT_PIN, RECEIVE_PIN);
// controls if master or slave
bool master;
// create a locomotion 
Locomotion loco(0,true);
// get a base class pointer for easier use
ComInterface *com = &loco;
// a debug counter
int counter;

// SETUP
void setup(){
  counter = 0;
  // hardwire serial
  Serial.begin(9600);
  // software serial
  mySerial.begin(57600);
  
  Serial.println("setup");
  
  pinMode(LED_HEART, OUTPUT);
  pinMode(SPEED_OUTPUT, OUTPUT);
  pinMode(MASTER_SEL, INPUT);
  
  // determine if this unit is a master or slave
  if(digitalRead(MASTER_SEL)){
    master = true;
  } else {
    master = false;
  }
  
  // if master, start up different
  if(master)
  {
    // master needs to get the direction
    pinMode(DIRECTION_INPUT ,INPUT);
    digitalWrite(DIRECTION_INPUT, HIGH);
    beatInterval = 100;
    Serial.println("Master");
  } else {
    // slave needs to output direction
    pinMode(DIRECTION_OUTPUT,OUTPUT);
    beatInterval = 1000;
    Serial.println("Slave");
  }
  // set on both master and slave to use the +5v external referance for the ADC
  analogReference(EXTERNAL); 
}


// main loop
void loop(){
  // debug counter
  Serial.println(counter); 
  
  // if master
  if(master){
    if(digitalRead(DIRECTION_INPUT)){
      // set direction to forward
      loco.setDirectionForward(true);
    } else {
      // must be in reverse
      loco.setDirectionForward(false);
    }
    // send all of the loco data
    loco.sendData(&mySerial);
    // delay
    // debug code
    // needs to be cleaned up!!!!
    uint16_t temp = 0;
    // set current speed to pot value
    loco.setSpeed(temp = analogRead(SPEED_INPUT));
    Serial.println((int)temp);      
  } else if (!master){
    // not master
    // check to see if there is data was recieved
    if(com->receiveData(&mySerial)){
     // Serial.println("Received Data");
     // Serial.println("-----------------");
     // Serial.println("loco.getSpeed():");
      Serial.println((int)loco.getSpeed());
     // Serial.println("-----------------");
     // Serial.println("loco.isDirectionForward():");
     // Serial.println((int)loco.isDirectionForward());
     // Serial.println("-----------------");
     // write the loco speed out to the control board
      analogWrite(SPEED_OUTPUT,(int)loco.getSpeed()/4);
      
      // check the direction
      if(loco.isDirectionForward()){
        //set to 0v forward
        digitalWrite(DIRECTION_OUTPUT,LOW);
      }else {
        // set to +5v reverse
        digitalWrite(DIRECTION_OUTPUT,HIGH);
      }
    }
  }
  
  
  // HEART BEAT LOGIC
  currentMillis = millis();
  
  if(currentMillis - prevMillis >= beatInterval) {
    prevMillis = currentMillis;
    
    if (heartState == LOW)
    {
      heartState = HIGH;
    }else{
      heartState = LOW;
    }
    digitalWrite(LED_HEART, heartState);
  } 
}

