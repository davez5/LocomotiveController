/******************************************************************
*  EasyTransfer Arduino Library v1.0
*		details and example sketch: 
*			http://www.billporter.info/easytransfer-arduino-library/
*
*		Brought to you by:
*              Bill Porter
*              www.billporter.info
*
*  Lib version history
*	1.0  Created
*	1.1  Fixed dumb Copy-paste error in header file
*		 Added a keyword file
*	1.5  Forked lib into Software and Hardware Serial branches, I don't know a better way
*		 added passing in of Serial port
*
*
*  Limits of the Library
*		You can change the Serial port below,
*		but the Struct size must not pass 255 bytes
*
*   The protcol is as follows:
*		Header(0x06,0x85),SizeofPayload,Payload,Checksum
*	
*  
*This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or(at your option) any later version.
This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.
<http://www.gnu.org/licenses/>
*
*This work is licensed under the Creative Commons Attribution-ShareAlike 3.0 Unported License. 
*To view a copy of this license, visit http://creativecommons.org/licenses/by-sa/3.0/ or
*send a letter to Creative Commons, 444 Castro Street, Suite 900, Mountain View, California, 94041, USA.
******************************************************************/


Library now has two versions, one for regular hardware Serial, one for use with the NewSoftSerial library
making any Arduino pin capable of transfering data back and forth easily. 

See the examples to find out how to use the library. 