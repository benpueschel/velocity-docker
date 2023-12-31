FROM openjdk:11.0-jre-slim

RUN apt update \
	&& apt install -y wget \
	&& apt install -y jq \
	&& rm -rf /var/lib/apt/lists/* \
	&& mkdir /velocity

# Container setup
EXPOSE 25577/tcp
EXPOSE 25577/udp

COPY start.sh /

RUN chmod +x start.sh

ENTRYPOINT [ "/start.sh" ]
