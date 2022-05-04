DIRS  = 
DIRS += ./ext
DIRS += ./src

ifeq ($(COMP),)
    COMP=intel
endif

$(info COMP is $(COMP))
$(info MAKE is $(MAKE))

$(info $$PROD_DIR is [${PROD_DIR}])
$(info $$INTEL_TARGET_ARCH is [${INTEL_TARGET_ARCH}])
$(info $$ORBIT_ARCH is [${ORBIT_ARCH}])


#========rules=========================

#all: compile
#all: $(DIRS)

TOPTARGETS := all clean

$(TOPTARGETS): $(DIRS)

export INTEL_TARGET_ARCH PROD_DIR

$(DIRS):
	$(info Calling is $@)
	$(MAKE) -C $@ $(MAKECMDGOALS) COMP=$(COMP)

.PHONY: $(TOPTARGETS) $(DIRS)

compile:
	@for dir in $(DIRS); do \
		(cd $$dir; if [ -f ./Makefile ]; then echo "Compiling $$dir"; $(MAKE) compile; fi;); \
	done
	


docs:
	doxygen
