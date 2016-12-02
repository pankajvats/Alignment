FROM ubuntu:latest

MAINTAINER Pankaj Vats

RUN apt-get update && apt-get install -y \
        wget \
        git \
        build-essential \
        zlib1g-dev \
        ncurses-dev \
        g++ \
        python-dev \
        bzip2 \
        unzip \
        xz-utils \
	cmake \
	vim \
	default-jre \
	default-jdk 
#	libcurl4-openssl-dev

#RUN alias sh=bash
RUN alias vi=vim	       
#RUN useradd --shell /bin/bash -u 214388 -m pankajv
#RUN useradd --shell /bin/bash -e USER=pankajv --user=pankajv 
#RUN mkdir opt/ 


WORKDIR /opt/
RUN wget https://github.com/samtools/samtools/releases/download/1.3.1/samtools-1.3.1.tar.bz2
#RUN wget https://github.com/samtools/samtools.git
RUN tar xvjf samtools-1.3.1.tar.bz2
RUN cd samtools-1.3.1 && make && make install

 
RUN git clone https://github.com/broadinstitute/picard.git
RUN cd picard && ./gradlew shadowJar

RUN apt-get update
RUN apt-get -y install r-base
#RUN echo "r <-getOption('repos');r['CRAN'] <-'http://cran.us.r-project.org';options(repos =r)";>~/.Rprofile
#RUN Rscript -e 

copy ./novocraftV3.06.00.Linux3.0.tar.gz /opt/
WORKDIR /opt/
RUN tar xvzf  novocraftV3.06.00.Linux3.0.tar.gz
#RUN cd novocraft
copy ./novoalign.lic /opt/novocraft/


WORKDIR /opt/
copy init.sh /opt/
RUN  /opt/init.sh



RUN date

