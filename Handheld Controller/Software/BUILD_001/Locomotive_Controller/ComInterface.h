//ComInterface.h
#ifndef COMINTERFACE_H
#define COMINTERFACE_H


//make it a little prettier on the front end. 
#define details(name) (byte*)&name,sizeof(name)

//Not neccessary, but just in case. 
#include "WProgram.h"
#include <NewSoftSerial.h>
#include <math.h>
#include <stdio.h>
#include <stdint.h>
#include <avr/io.h>
#define LOCOMOTION_TYPE 0x10
#define SWITCH_TYPE		0x20
#define BLANK			0x00


class ComInterface {
  
public:
//void begin(uint8_t *, uint8_t, NewSoftSerial *theSerial);
virtual void sendData(NewSoftSerial *_Serial, uint8_t *ptr, uint8_t length){};
boolean receiveData(NewSoftSerial *_Serial);
//ComInterface(int thePacketType, uint8_t dataSize);
ComInterface(int thePacketType);

protected:
uint8_t *address;  //address of struct
uint8_t size;       //size of struct
uint8_t rx_len;		//RX packet length according to the packet
uint8_t rx_array[255]; //RX packet parsing buffer
uint8_t rx_array_inx;  //index for RX parsing buffer
uint8_t calc_CS;	   //calculated Chacksum
const int packetType;
//NewSoftSerial *_serial;

private:
boolean sizeCorrect(NewSoftSerial *_Serial);
boolean getData(NewSoftSerial *_Serial);
boolean chkSumCorrect();

};



#endif
