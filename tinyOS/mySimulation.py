#!/usr/bin/python

from TOSSIM import *
import sys ,os
import random

t=Tossim([])
f=sys.stdout #open('./logfile.txt','w')
#simulation time
SIM_END_TIME= 1000 * t.ticksPerSecond()

number_of_nodes=int(sys.argv[1])

print "TicksPerSecond : ", t.ticksPerSecond(),"\n"

#activate dbg messages
#t.addChannel("Boot",f)
#t.addChannel("RoutingMsg",f)
#t.addChannel("Radio",f)
#t.addChannel("Serial",f)
#t.addChannel("SRTreeC",f)
#t.addChannel("comm",f)
#t.addChannel("PacketQueueC",f)
#t.addChannel("measurements",f)
##t.addChannel("receive",f)
#t.addChannel("querysend",f)




t.addChannel("final",f)
t.addChannel("help",f)
t.addChannel("rerouting",f)
t.addChannel("offset_timer",f)
t.addChannel("notify_children",f)
#takes nodes 0-9 and boots them at different times
#HOW MANY NODES BOOT MUST BE PASSED AS A PARAMETER
for i in range(0,number_of_nodes):
	m=t.getNode(i)
	m.bootAtTime((number_of_nodes)*t.ticksPerSecond() + i)


topo = open("topology_generated.txt", "r")

if topo is None:
	print "Topology file not opened!!! \n"


#read topology file
r=t.radio()
lines = topo.readlines()
for line in lines:
  s = line.split()
  if (len(s) > 0):
    print " ", s[0], " ", s[1], " ", s[2];
    r.add(int(s[0]), int(s[1]), float(s[2]))

mTosdir = os.getenv("TINYOS_ROOT_DIR")
noiseF=open(mTosdir+"/tos/lib/tossim/noise/meyer-heavy.txt","r")
lines= noiseF.readlines()

#add noise  
for line in  lines:
	str1=line.strip()
	if str1:
		val=int(str1)		
		for i in range(0,number_of_nodes):
			t.getNode(i).addNoiseTraceReading(val)
noiseF.close()
for i in range(0,number_of_nodes):
	t.getNode(i).createNoiseModel()
	
ok=False
#if(t.getNode(0).isOn()==True):
#	ok=True
h=True
while(h):
	try:
		h=t.runNextEvent()
		#print h
	except:
		print sys.exc_info()
#		e.print_stack_trace()

	if (t.time()>= SIM_END_TIME):
		h=False
	if(h<=0):
		ok=False

print "Node 0 connected with node 1" , r.connected(0,1) , r.connected(1,0)
print "Node 0 connected with node 2" , r.connected(0,2) , r.connected(2,0)
print "Node 1 connected with node 7" , r.connected(1,7) , r.connected(7,1)
print "Node 2 connected with node 3" , r.connected(2,3) , r.connected(3,2)
print "Node 4 connected with node 8" , r.connected(4,8) , r.connected(8,4)
