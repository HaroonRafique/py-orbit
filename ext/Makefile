DIRS  = 
#DIRS += ./ecloud
#DIRS += ./intsystem
#DIRS += ./laserstripping
#DIRS += ./H0starkeffect
DIRS += ./PTC

$(info Got $$LIBS as follows [${LIBS}])
$(info Got $$COMP is [${COMP}])
$(info $$PROD_DIR is [${PROD_DIR}])
$(info $$INTEL_TARGET_ARCH is [${INTEL_TARGET_ARCH}])
$(info $$ORBIT_ARCH is [${ORBIT_ARCH}])

export INTEL_TARGET_ARCH PROD_DIR

#========rules=========================

#all: compile

TOPTARGETS := all clean

$(TOPTARGETS): $(DIRS)



$(DIRS):
	$(info Calling argument $@)
	$(MAKE)  -C $@ $(MAKECMDGOALS) -f Makefile.$(COMP)
	
.PHONY: $(TOPTARGETS) $(DIRS)


compile:  
	@for dir in $(DIRS); do \
		(cd $$dir; if [ -f ./Makefile.$(COMP) ]; then echo "Compiling $$dir"; $(MAKE) -f Makefile.$(COMP) compile; fi;); \
	done
	@echo "Compilation of py-orbit/ext sub-directories completed"
	@echo "Compilation of py-orbit/src completed"
	@echo "****************************************"

clean:
	@for dir in $(DIRS); do \
		(cd $$dir; if [ -f ./Makefile ]; then $(MAKE) clean; fi;); \
	done
