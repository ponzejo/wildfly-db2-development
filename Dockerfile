####################################################################################
# JBOSS WILDFLY
####################################################################################
FROM jboss/wildfly:14.0.1.Final
RUN /opt/jboss/wildfly/bin/add-user.sh admin 1234 --silent
####################################################################################
# INSTALL DB2 DRIVER
####################################################################################
ADD ./db2jcc4.jar /opt/jboss/db2.jar
RUN mkdir -p META-INF/services
RUN echo "com.ibm.db2.jcc.DB2Driver" > META-INF/services/java.sql.Driver 
RUN jar uf /opt/jboss/db2.jar META-INF
ADD add-db2-driver.cli /opt/jboss/add-db2-driver.cli
RUN /opt/jboss/wildfly/bin/jboss-cli.sh --file=/opt/jboss/add-db2-driver.cli
RUN rm -rf /opt/jboss/wildfly/standalone/configuration/standalone_xml_history
####################################################################################
# ADD DB2 DATASOURCE
####################################################################################
ADD add-datasource.cli /opt/jboss/add-datasource.cli
RUN /opt/jboss/wildfly/bin/jboss-cli.sh --file=/opt/jboss/add-datasource.cli
RUN rm -rf /opt/jboss/wildfly/standalone/configuration/standalone_xml_history
####################################################################################
# ADD APP WAR
####################################################################################
# ADD target/*.war /opt/jboss/wildfly/standalone/deployments/
####################################################################################
# HOW TO BUILD WAR
####################################################################################
# # docker run -it --rm -v "$PWD":/usr/src/app -v "$HOME"/.m2:/root/.m2 -w /usr/src/app maven:3-jdk-8-alpine mvn install -Dmaven.test.skip=true
####################################################################################