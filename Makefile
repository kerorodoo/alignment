DLIB_INC = /home/facerecognition/SWD_DLIB
DLIB_SOURCE = $(DLIB_INC)/dlib/all/source.cpp

INC = -I/usr/include/python2.7 -I/usr/include/x86_64-linux-gnu/python2.7 `pkg-config --cflags opencv`
INC += -I$(DLIB_INC)

LIBS = -L/usr/lib/python2.7/config-x86_64-linux-gnu -L/usr/lib -lpthread -ldl -lutil -lm -lpython2.7 `pkg-config --libs opencv`


CFLAGS_Python = -fno-strict-aliasing -D_FORTIFY_SOURCE=2 -g -fstack-protector --param=ssp-buffer-size=4 -Wformat \
	 -Werror=format-security  -DNDEBUG -g -fwrapv -O2 -Wall -Wstrict-prototypes \
	 -Xlinker -export-dynamic -Wl,-O1 -Wl,-Bsymbolic-functions -fpermissive

CFLAGS_Dlib = -Wreturn-type -DDLIB_JPEG_SUPPORT -DDLIB_USE_BLAS -DDLIB_USE_LAPACK -O3 -DNDEBUG -msse4.2

LDLIBS = -lpthread -lnsl -lSM -lICE -lX11 -lXext -lpng -ljpeg -lopenblas -llapack


all: run

run: main.cpp source.o
	g++ $? $(INC) $(LDLIBS) $(LIBS) $(CFLAGS_Python) $(CFLAGS_Dlib) -o $@ 
	
source.o: $(DLIB_SOURCE)
	g++ $< $(LIBS) $(INC) $(CFLAGS_Dlib) -c


clean:
	rm -f  *.o run 

#use following instructions to get the argumets above
#python-config --cflags
#python-config --ldflags 
