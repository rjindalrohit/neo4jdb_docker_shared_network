# neo4jdb_docker_shared_network

In this project i am using jar file created from the project "https://github.com/neo4j-examples/movies-java-spring-data-neo4j.git".

and i have update the password and db url for application in file src/main/resources/application.properties as below :

spring.data.neo4j.uri=bolt://neo4jdb
spring.data.neo4j.username=neo4j
spring.data.neo4j.password=neo4j1

and created the jar file sdn5-movies-0.0.1-SNAPSHOT.jar.

steps to execute the project.
1) first start docker-compose in common folder.
    cd common
    docker-compose up
  wait to start all container.
2) check for the neo4j UI consule on URL http://localhost:7474
    below on page give password as 'ne04j' and on next page as suggest give new passowrd as neo4j1.

3) now start docker-compose in main folder

program is start access the http://{docker_container_ip}:8888. here you will be seeing only html page without data.

4) Now again go to http://localhost:7474 and execute :play movies then it will show some instruction just below it. press on next it will show some Query. click on that query it will automatically copy the query in executer section and then execute.
you will see sample mapping dig

5) now refresh http://{docker_container_ip}:8888 . you will be able to see the data inserted by sdn5-movies-0.0.1-SNAPSHOT.jar in neo4jdb in other container. 
