COMPONENT=SRTreeAppC
include $(TINYOS_ROOT_DIR)/Makefile.include
BUILD_EXTRA_DEPS += NotifyParentMsg.class NotifyParentMsg.java
CLEAN_EXTRA= *.class NotifyParentMsg.java


#BOOTLOADER=tosboot


CFLAGS += -DSERIAL_EN
#CFLAGS += -I$(TOSDIR)/lib/printf -DPRINTFDBG_MODE

NotifyParentMsg.class: $(wildcard *.java) NotifyParentMsg.java
	javac *.java
NotifyParentMsg.java:
	mig java -target=null -java-classname=NotifyParentMsg SimpleRoutingTree.h NotifyParentMsg -o $@

