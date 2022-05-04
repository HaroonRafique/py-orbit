include ../conf/make_root_config

DIRS = $(filter-out test%,$(patsubst %/, %, $(filter %/,$(shell ls -F))))
#========rules=========================


TOPTARGETS := all clean

$(TOPTARGETS): $(DIRS)
	@echo ""
	@echo "****************************************"
	@echo "****************************************"
	@echo "****************************************"
	@echo "Compilation of py-orbit/src sub-directories completed"
	@echo "****************************************"
	@echo "Compiling py-orbit/src with MakefileMain"
	$(MAKE) --makefile=MakefileMain
	@echo "Compilation of py-orbit/src completed"
	@echo "****************************************"

$(DIRS):
	$(info Calling argument $@)
	$(MAKE)  -C $@ $(MAKECMDGOALS) # -f Makefile.$(COMP)

	
.PHONY: $(TOPTARGETS) $(DIRS)




compile: 
	for dir in $(DIRS); do \
		(cd $$dir; if [ -f ./Makefile ]; then echo Compiling $$dir; $(MAKE) compile; fi;); \
	done
	@echo "Compilation of py-orbit/src sub-directories completed"
	@echo "****************************************"
	@echo "Compiling py-orbit/src with MakefileMain"
	$(MAKE) --makefile=MakefileMain compile
	@echo "Compilation of py-orbit/src completed"
	@echo "****************************************"

clean:
	@for dir in $(DIRS); do \
		(cd $$dir; if [ -f ./Makefile ]; then $(MAKE) clean; fi;); \
	done
	rm -rf $(orbit_main)
