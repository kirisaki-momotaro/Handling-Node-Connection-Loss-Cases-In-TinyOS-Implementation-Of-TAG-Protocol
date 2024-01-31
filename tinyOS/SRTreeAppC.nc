#include "SimpleRoutingTree.h"

configuration SRTreeAppC @safe() { }
implementation{
	components SRTreeC;

#if defined(DELUGE) //defined(DELUGE_BASESTATION) || defined(DELUGE_LIGHT_BASESTATION)
	components DelugeC;
#endif

#ifdef PRINTFDBG_MODE
		components PrintfC;
#endif
	components MainC, ActiveMessageC, RandomC, RandomMlcgC; // Added RandomC and RandomMlcgC. 	
	components new TimerMilliC() as RoutingMsgTimerC; 
	//when this timer rings, nodes with some probability get disconnected from parents
	components new TimerMilliC() as LoseParentTimerC;
	
	//timer for data transmition
	components new TimerMilliC() as SendMeasurementTimerC;
	//routing done event timer
	components new TimerMilliC() as RoutingFinishedTimerC;
	// Timers bellow to add a randomness to the sending of retrsnmition and notify children messages
	components new TimerMilliC() as RetransmissionTimerC; 
	components new TimerMilliC() as NotifyChildrenTimerC;
	//this timer defines for how long a node that lost connection should wait for candidates
	components new TimerMilliC() as StopWaitingForNewCandidatesTimerC; 

	//OFFSET TIMER TO ACCOMODATE FOR DEPTH CHANGE	
	components new TimerMilliC() as OffsetTimerC;

	
	components new AMSenderC(AM_ROUTINGMSG) as RoutingSenderC;
	components new AMReceiverC(AM_ROUTINGMSG) as RoutingReceiverC;

	// components for measurements.	
	components new AMSenderC(AM_MEASUREMENTMSG) as MeasurementSenderC;
	components new AMReceiverC(AM_MEASUREMENTMSG) as MeasurementReceiverC;
	
	components new PacketQueueC(SENDER_QUEUE_SIZE) as RoutingSendQueueC;
	components new PacketQueueC(RECEIVER_QUEUE_SIZE) as RoutingReceiveQueueC;

	// New components for measurement queues. 
	components new PacketQueueC(SENDER_QUEUE_SIZE) as MeasurementSendQueueC;
	components new PacketQueueC(RECEIVER_QUEUE_SIZE) as MeasurementReceiveQueueC;


	//help message
	components new AMSenderC(AM_HELPMSG) as HelpSenderC;
	components new AMReceiverC(AM_HELPMSG) as HelpReceiverC;

	components new PacketQueueC(SENDER_QUEUE_SIZE) as HelpSendQueueC;
	components new PacketQueueC(RECEIVER_QUEUE_SIZE) as HelpReceiveQueueC;

	//notify childern for depth change
	components new AMSenderC(AM_NOTIFYCHILDREN) as NotifyChildrenSenderC;
	components new AMReceiverC(AM_NOTIFYCHILDREN) as NotifyChildrenReceiverC;
  
	components new PacketQueueC(SENDER_QUEUE_SIZE) as NotifyChildrenSendQueueC;
	components new PacketQueueC(RECEIVER_QUEUE_SIZE) as NotifyChildrenReceiveQueueC;
	
	// New components for Retransmission of Routing Msgs.
	components new AMSenderC(AM_NEWROUTING) as RetransmissionSenderC;
	components new AMReceiverC(AM_NEWROUTING) as RetransmissionReceiverC;

	// New components for retransmitting queues.
	components new PacketQueueC(SENDER_QUEUE_SIZE) as RetransmissionSendQueueC;
	components new PacketQueueC(RECEIVER_QUEUE_SIZE) as RetransmissionReceiveQueueC;
	
	SRTreeC.Boot->MainC.Boot;
	
	SRTreeC.RadioControl -> ActiveMessageC;
	
	SRTreeC.RoutingMsgTimer->RoutingMsgTimerC;

	SRTreeC.LoseParentTimer->LoseParentTimerC; 
	
	
	//wire message timer
	SRTreeC.SendMeasurementTimer->SendMeasurementTimerC;
	//wire rooting timer
	SRTreeC.RoutingFinishedTimer->RoutingFinishedTimerC;

	SRTreeC.OffsetTimer->OffsetTimerC;

	SRTreeC.RetransmissionTimer->RetransmissionTimerC;
	SRTreeC.NotifyChildrenTimer->NotifyChildrenTimerC;

	SRTreeC.StopWaitingForNewCandidatesTimer->StopWaitingForNewCandidatesTimerC;

	SRTreeC.RoutingPacket->RoutingSenderC.Packet;
	SRTreeC.RoutingAMPacket->RoutingSenderC.AMPacket;
	SRTreeC.RoutingAMSend->RoutingSenderC.AMSend;
	SRTreeC.RoutingReceive->RoutingReceiverC.Receive;
	
	// New wirings for measurement purposes added.
	SRTreeC.MeasurementPacket->MeasurementSenderC.Packet;
	SRTreeC.MeasurementAMPacket->MeasurementSenderC.AMPacket;
	SRTreeC.MeasurementAMSend->MeasurementSenderC.AMSend;
	SRTreeC.MeasurementReceive->MeasurementReceiverC.Receive;
	
	//help messsage wiring
	SRTreeC.HelpPacket->HelpSenderC.Packet;
	SRTreeC.HelpAMPacket->HelpSenderC.AMPacket;
	SRTreeC.HelpAMSend->HelpSenderC.AMSend;
	SRTreeC.HelpReceive->HelpReceiverC.Receive;

	//notify children messsage wiring
	SRTreeC.NotifyChildrenPacket->NotifyChildrenSenderC.Packet;
	SRTreeC.NotifyChildrenAMPacket->NotifyChildrenSenderC.AMPacket;
	SRTreeC.NotifyChildrenAMSend->NotifyChildrenSenderC.AMSend;
	SRTreeC.NotifyChildrenReceive->NotifyChildrenReceiverC.Receive;
	
	
	// New wirings for retransmission purposes added.
	SRTreeC.RetransmissionPacket->RetransmissionSenderC.Packet;
	SRTreeC.RetransmissionAMPacket->RetransmissionSenderC.AMPacket;
	SRTreeC.RetransmissionAMSend->RetransmissionSenderC.AMSend;
	SRTreeC.RetransmissionReceive->RetransmissionReceiverC.Receive;

	SRTreeC.RoutingSendQueue->RoutingSendQueueC;
	SRTreeC.RoutingReceiveQueue->RoutingReceiveQueueC;

	// New wirings for measurement queues added.
	SRTreeC.MeasurementSendQueue->MeasurementSendQueueC;
	SRTreeC.MeasurementReceiveQueue->MeasurementReceiveQueueC;

	// New wirings for Help queues added.
	SRTreeC.HelpSendQueue->HelpSendQueueC;
	SRTreeC.HelpReceiveQueue->HelpReceiveQueueC;

	// New wirings for notify children queues added.
	SRTreeC.NotifyChildrenSendQueue->NotifyChildrenSendQueueC;
	SRTreeC.NotifyChildrenReceiveQueue->NotifyChildrenReceiveQueueC;


	// New wirings for Retransmission queues added.
	SRTreeC.RetransmissionSendQueue->RetransmissionSendQueueC;
	SRTreeC.RetransmissionReceiveQueue->RetransmissionReceiveQueueC;
	
	// Used for random number creation
	SRTreeC.RandomMeasurement->RandomC;
	SRTreeC.Seed->RandomMlcgC.SeedInit;
	
}
