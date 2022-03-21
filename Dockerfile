FROM openjdk:16-jdk-alpine3.12

ENV PLANTUML_VERSION=1.2022.2
ENV LANG en_US.UTF-8

RUN \
  apk add --no-cache graphviz wget ca-certificates && \
  apk add --no-cache graphviz wget ca-certificates ttf-dejavu fontconfig && \
  mkdir /plantuml && \
  wget "http://downloads.sourceforge.net/project/plantuml/${PLANTUML_VERSION}/plantuml.${PLANTUML_VERSION}.jar" -O /plantuml/plantuml.jar && \
  wget "http://beta.plantuml.net/batikAndFop.zip" -O deps.zip && \
  unzip deps.zip -d /plantuml && \
  apk del wget ca-certificates 

# Install Unicode LaTeX default fonts 
RUN cd /tmp && \
wget https://sourceforge.net/projects/cm-unicode/files/cm-unicode/0.7.0/cm-unicode-0.7.0-ttf.tar.xz/download && \
tar -xf download && \
cd cm-unicode-0.7.0 && \
mkdir -p /usr/share/fonts/cm-unicode && \
cp * /usr/share/fonts/cm-unicode/ && \
mkfontscale && \
mkfontdir && \
fc-cache


WORKDIR /plantuml




ENTRYPOINT ["java", "-Djava.awt.headless=true", "-jar", "/plantuml/plantuml.jar", "-p"]

CMD ["-tsvg"]