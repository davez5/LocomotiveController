//Locomotion.h
#ifndef Locomotion_H
#define Locomotion_H

#include <inttypes.h>
#include "ComInterface.h"

class Locomotion: public ComInterface
{
private:
        uint16_t speed;
        bool isForward;
   
public:
	void sendData(NewSoftSerial *_Serial);
	Locomotion(uint16_t velocity, bool forward);
	~Locomotion();
	void setSpeed(uint16_t velocity);
	void setDirectionForward(bool forward);
	uint16_t* addressSpeed();
	bool* addressIsForward();
	bool isDirectionForward();
	uint16_t getSpeed();
	
	
};
#endif

