# What is applciation modernization?

## Application Modernization

Application modernization is the process of updating older applications to newer languages, frameworks, and deployment models. To be specific, app modernization includes, but is not limited to: deploying applciations to containers, deploying applications to a cloud platform, and refactoring monolithic applications to microservices. Typically, one will see a combination of these processes in their modernization efforts. The reasons for doing this will vary from organization to organization, and many of them will only adopt certain facets of modernization, but generally, some of the reasons for modernization include: scalability benefits, faster time-to-deployment, and standard infrastructure platforms. This workshop will explore some of the benefits of adopting app modernization in a Data Mesh architecture. 

## Modernization in this workshop

This workshop will show you how to extend the functionality of an existing application using microservices. Specifically, we have a monolithic Jakarta EE application running on WebLogic Server, and we would like to add a new feature that is responsible for querying patients at risk of experiencing poor symptoms to COVID-19. For scalability concerns, we would like to package this functionality outside of the WebLogic Server and have it run within its own JVM. For this reason, we have chosen to go with Helidon, a lightweight set of Java libraries that enables us to develop microservices. Particulary, we have chosen to go with Helidon MP. Helidon MP implements the MicroProfile specification which implements many of the same standards as Jakarta EE, but in a way that suits microservices. This allows us to maintain consistency in our programming styles.

## Acknowledgements

- **Author**- Matthew McDaniel, North America Cloud and Technology Engineering
- **Last Updated By/Date** - Matthew McDaniel, North America Cloud and Technology Engineering, July 29, 2022
