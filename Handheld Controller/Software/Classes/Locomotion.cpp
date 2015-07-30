//Locomotion.cpp
#include "Locomotion.h"


Locomotion::Locomotion(uint16_t velocity, bool forward):speed(velocity),isForward(forward),ComInterface(LOCOMOTION_TYPE,(sizeof(speed)+sizeof(isForward)))
{

}

Locomotion::~Locomotion()
{

}

void Locomotion::setSpeed(uint16_t velocity)
{
	speed = velocity;
}

void Locomotion::setDirectionForward(bool forward)
{
	isForward = forward;
}

bool Locomotion::isDirectionForward()
{
	return isForward;
}

uint16_t Locomotion::getSpeed()
{
	return speed;
}

void Locomotion::sendData(NewSoftSerial *_Serial, uint8_t *ptr, uint8_t length)
{  
        
	address = (uint8_t*)&speed;
        Serial.println((int)*address);
	uint8_t CS = size; // need to calculate the size bassed on properties!!!
	
	_Serial->print(0x06, BYTE);
	_Serial->print(packetType, BYTE);
	_Serial->print(size, BYTE);
	for(int i = 0; i<sizeof(speed); i++)
	{
		CS^=*(address+i);
		_Serial->print(*(address+i), BYTE);
	}
	address = (uint8_t*)&isForward;
        Serial.println((int)*address);
	//_Serial->print(BLANK,BYTE);
	for(int i = 0; i<sizeof(isForward); i++)
	{
		CS^=*(address+i);
		_Serial->print(*(address+i), BYTE);
	}
	_Serial->print(CS);
        Serial.print("Size : ");
        Serial.println((int)size);
        Serial.print("CS : ");
        Serial.println((int)CS);

}

uint16_t* Locomotion::addressSpeed()
{
	return &speed;
}

bool* Locomotion::addressIsForward()
{
	return &isForward;
}


