FROM tomcat:8.5-jdk11

# Clean out unneccessary files from tomcat (especially pre-existing applications)
RUN rm -rf /usr/local/tomcat/webapps/* \
    /usr/local/tomcat/conf/Catalina/localhost/manager.xml

RUN apt update \
  && apt install -y postgresql-client

ARG OPENELIS_URL=http://nexus.mekomsolutions.net/repository/maven-releases/org/openelisglobal/openelisglobal/2.1.2.1/openelisglobal-2.1.2.1.war
RUN wget -O /tmp/openelis.war ${OPENELIS_URL} && \
    mv /tmp/openelis.war /usr/local/tomcat/webapps/openelis.war

COPY OpenELIS-Global.war  /usr/local/tomcat/webapps/openelis.war

# COPY startup.sh /usr/local/tomcat/startup.sh
# RUN chmod +x /usr/local/tomcat/startup.sh

# CMD ["/usr/local/tomcat/startup.sh"]
