FROM debian:jessie
LABEL maintainer "mrummuka@hotmail.com"
ENV GOPATH /root/gocode
RUN mkdir /root/gocode
ENV PATH $PATH:$GOPATH/bin
RUN apt-get update && apt-get install -y \
	wget \
	build-essential \
	make \
	gawk \
	gcc \
	dos2unix \
	bc \
	dc \
	units \
	sharutils \
	curl \
	gpsbabel \
	golang-go \
        git \
        default-jre \
	zip \
 && rm -rf /var/lib/apt/lists/* \
 && cd ~ \
 && wget https://github.com/ericchiang/pup/releases/download/v0.4.0/pup_v0.4.0_linux_amd64.zip \
 && unzip pup_v0.4.0_linux_amd64.zip \
 && ln -s ~/pup /usr/local/bin/ \
 && cd /opt \
 && wget `curl -s http://geo.rkkda.com/ | pup 'a:contains("geo.rkkda") text{}'` \
 && tar xvzf `curl -s http://geo.rkkda.com/ | pup 'a:contains("geo.rkkda") attr{href}'`\
 && rm geo-*.tar.gz \
 && cd geo \
 && make \
 && make install \
 && mkdir ~/Wherigo \
 && cd ~/Wherigo \
 && git clone https://github.com/driquet/gwcd \
 && git clone https://github.com/Krevo/WherigoTools \
 && ln -s WherigoTools/extra/unluac_2015_06_13.jar .
 RUN echo "deb http://ftp.us.debian.org/debian testing main contrib non-free" >/etc/apt/sources.list \
 && apt-get update \
 && apt-get install -y -t testing gpsbabel golang-go \
 && go get github.com/phonkee/goexpose \
 && apt-get purge -y --auto-remove wget build-essential make gcc git zip # golang-go
# Add geotools installed to /root/bin to path
ENV PATH /root/bin:$PATH
COPY .georc /root/
COPY geo-tools.yml /root/
EXPOSE 9900
#CMD ["go", "run", "$GOPATH/src/github.com/phonkee/goexpose/cmd/goexpose/goexpose.go", "-format", "yaml", "-config" "/root/geo-tools.yml"]
ENTRYPOINT "exec" "go" "run" "$GOPATH/src/github.com/phonkee/goexpose/cmd/goexpose/goexpose.go" "-format" "yaml" "-config" "/root/geo-tools.yml"
