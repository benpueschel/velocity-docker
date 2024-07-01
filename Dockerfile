FROM alpine:latest

RUN apk update && \
	apk add jq bash openjdk21-jre wget

# Create a non-priviliged user and set the working directory to their home
RUN adduser -D -S -h /home/minecraft minecraft
WORKDIR /home/minecraft
RUN mkdir velocity
RUN chown minecraft velocity

# Copy the start script and make it executable
COPY start.sh ./
RUN chown minecraft start.sh
RUN chmod +x start.sh

# Container setup
EXPOSE 25577/tcp
EXPOSE 25577/udp

COPY start.sh ./

RUN chmod +x start.sh

ENTRYPOINT [ "./start.sh" ]
