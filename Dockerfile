FROM ubuntu:16.04
MAINTAINER Gemma Hoad <ghoad@sfu.ca>

# Install packages then remove cache package list information
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get -yq install openssh-client \
    make \
    curl \
    wget \
    apt-utils \
    build-essential \
    net-tools \
    librpc-xml-perl \
    bioperl \
    ncbi-blast+-legacy \
    nano \
    libf2c2 \
    libxmlrpc-lite-perl \
    libextutils-makemaker-cpanfile-perl \
    gcc 

RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /tmp/results && chmod 777 /tmp/results

WORKDIR /usr/local/bin

RUN mkdir pftools && cd pftools && wget ftp://ftp.lausanne.isb-sib.ch/pub/software/unix/pftools/pft2.3/executables/linux_x86_elf/static/pft2.3_static.tar.gz && tar xvf pft2.3_static.tar.gz && chmod 755 * && ln -s /usr/local/bin/pftools/pfscan /usr/local/bin/pfscan

WORKDIR /usr/local/src

RUN echo '/usr/local/lib64' >>/etc/ld.so.conf

RUN wget ftp://ftp.ncbi.nih.gov/blast/executables/blast+/2.6.0/ncbi-blast-2.6.0+-x64-linux.tar.gz && tar xvf ncbi-blast-2.6.0+-x64-linux.tar.gz && export PATH=$PATH:/usr/local/bin/ncbi-blast-2.6.0+/bin

RUN wget http://www.psort.org/download/libpsortb-1.0.tar.gz && tar zxvf libpsortb-1.0.tar.gz && cd libpsortb-1.0 && ./configure && make && make install && ldconfig

RUN mkdir -p /usr/local/src/blastdb

WORKDIR /usr/local/src

RUN wget http://www.psort.org/download/bio-tools-psort-all.3.0.6.tar.gz && tar zxvf bio-tools-psort-all.3.0.6.tar.gz

WORKDIR /usr/local/src/bio-tools-psort-all

RUN wget http://www.psort.org/download/docker/psortb_standalone_for_docker.tar.gz && tar xvf psortb_standalone_for_docker.tar.gz && mv psortb_standalone_for_docker/Makefile.PL ./

RUN wget http://www.psort.org/download/docker/psortb.defaults && perl Makefile.PL && make && make install 

RUN mv /usr/local/psortb/bin /usr/local/psortb/bin_orig && mv psortb_standalone_for_docker/bin /usr/local/psortb/ && chmod +x /usr/local/psortb/bin

#cleanup
WORKDIR /usr/local/src

RUN rm libpsortb-1.0.tar.gz bio-tools-psort-all.3.0.6.tar.gz ncbi-blast-2.6.0+-x64-linux.tar.gz /usr/local/bin/pftools/pft2.3_static.tar.gz bio-tools-psort-all/psortb_standalone_for_docker.tar.gz 

RUN rm -r /usr/local/src/bio-tools-psort-all/psortb_standalone_for_docker

ENTRYPOINT ["/usr/local/psortb/bin/psort"]
CMD []

