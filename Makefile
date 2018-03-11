all: nikal.ko nipalk.ko niorbk.ko nidimk.ko nimdbgk.ko nimxdfk.ko nipxirmk.ko nipxigpk.ko nipxifpk.ko NiViPxiK.ko NiViPciK.ko 


Module.symvers: nikal/Module.symvers
	cp nikal/Module.symvers ./

nikal/Module.symvers: nikal.ko

nikal/Makefile.in:
	cd ./nikal; ./configure

nikal.ko: nikal/Makefile.in
	make -C ./nikal
	mv ./nikal/$@ ./

%.ko: nikal/Makefile.in ./client/Module.symvers
	make -C ./client CLIENT_MODULE=/opt/ni-visa/objects/$(notdir $(basename $@))-unversioned.o CLIENT_NAME=$(notdir $(basename $@))
	mv ./client/$@ ./

./client/Module.symvers: Module.symvers
	ln -sf ../Module.symvers ./client/Module.symvers

clean:
	make -C ./nikal clean
	make -C ./client clean

.PHONY: all clean