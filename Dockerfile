FROM openjdk:8-jre as jdk

RUN true \
  && apt-get update \
  && apt-get install -y libxrender1 libxtst6 libxi6
RUN true \
  && mkdir /documents \
  && mkdir /opcat \
  && chmod 777 /opcat \
  && mkdir /Users \
  && chmod 777 /Users

WORKDIR /opcat
COPY OPCAT.jar license.lic opcat_in_container.sh ./
#RUN ln -s /documents/conf.txt
#chmod 666 conf.txt

CMD [ "/opcat/opcat_in_container.sh" ]
