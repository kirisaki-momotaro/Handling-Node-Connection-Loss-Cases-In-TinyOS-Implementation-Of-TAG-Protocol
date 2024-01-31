#ifndef SIMPLEROUTINGTREE_H
#define SIMPLEROUTINGTREE_H


enum{
	SENDER_QUEUE_SIZE=5,
	RECEIVER_QUEUE_SIZE=3,
	AM_SIMPLEROUTINGTREEMSG=22,
	AM_ROUTINGMSG=22,	
	AM_MEASUREMENTMSG=25,
	AM_HELPMSG=28,
	AM_NEWROUTING=30,
	AM_NOTIFYCHILDREN=32,
	SEND_CHECK_MILLIS=70000,
	//correct timer period
	TIMER_PERIOD_MILLI=60*1024,
	TIMER_FAST_PERIOD=200,
	TIMER_LEDS_MILLI=1000,
	//quantum of time in which to send data
	TIMER_FAST_SEND_MEASUREMENT_PERIOD=1280
};
/*uint16_t AM_ROUTINGMSG=AM_SIMPLEROUTINGTREEMSG;
uint16_t AM_NOTIFYPARENTMSG=AM_SIMPLEROUTINGTREEMSG;
*/
typedef nx_struct RoutingMsg
{
	nx_uint16_t senderID;
	nx_uint8_t depth;
	nx_uint8_t RANDOM_NUM;
} RoutingMsg;

// measurement structs
// data from 1 group
typedef nx_struct MeasurementMsg
{
	nx_uint8_t includedGroups;
	nx_uint8_t count;
	nx_uint16_t measurement;
} MeasurementMsg;
// data from 2 group
typedef nx_struct MeasurementMsg1
{
	nx_uint8_t includedGroups;
	nx_uint8_t count;
	nx_uint16_t measurement;
	nx_uint8_t count1;
	nx_uint16_t measurement1;	
} MeasurementMsg1;
// data from 3 group
typedef nx_struct MeasurementMsg2
{
	nx_uint8_t includedGroups;
	nx_uint8_t count;
	nx_uint16_t measurement;
	nx_uint8_t count1;
	nx_uint16_t measurement1;
	nx_uint8_t count2;
	nx_uint16_t measurement2;
} MeasurementMsg2;

// New struct for HelpMsg.
typedef nx_struct HelpMsg
{
	nx_uint8_t help;
		
} HelpMsg;

// New struct needed for NewRoutingMsg to be sent after the connection is lost.
typedef nx_struct NewRoutingMsg
{
	nx_uint16_t senderID;
	nx_uint8_t depth;

} NewRoutingMsg;

// New struct needed to notify children if their parent changed their depth.
typedef nx_struct NotifyChildrenMsg
{
	nx_uint16_t senderID;
	nx_uint16_t new_depth;

} NotifyChildrenMsg;



#endif
