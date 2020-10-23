# Wildfly-DB2

## Wildfly
Version: 14.0.1.Final

## DB2 Driver
Version: JDBC4 - 4.19

## docker-compose example
```Dockerfile
version: "3.7"
services:
    wildfly:
        restart: always
        build: ./
        ports:
          - "8080:8080"
          - "9990:9990"
        volumes:
            - ./docker-vols/tmp:/tmp
        command: /opt/jboss/wildfly/bin/standalone.sh -b 0.0.0.0 -bmanagement 0.0.0.0
        environment:
            DB2_DATASOURCE_NAME: db2ds
            DB2_DATASOURCE_DRIVER_NAME: db2
            DB2_DATASOURCE_JNDI_NAME: java:jboss/datasources/db2ds
            DB2_DATASOURCE_URL: jdbc:db2://db2:50000/guest
            DB2_DATASOURCE_USER: guest
            DB2_DATASOURCE_PASSWORD: guest
            DB2_DATASOURCE_MAX_POOL_SIZE: 25
            DB2_DATASOURCE_BLOCK_TIMEOUT: 5000

    db2:
        restart: always
        image: ignatov/db2
        volumes:
            - ./docker-vols/database:/database
        ports:
          - "50000:50000"
```

## Dockerfile example for new project
```Dockerfile
####################################################################################
# BASE IMAGE
####################################################################################
FROM moorea/wildfly-db2:latest
####################################################################################
# ADD APP WAR
####################################################################################
ADD target/*.war /opt/jboss/wildfly/standalone/deployments/
####################################################################################
```
