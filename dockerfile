FROM maven:3.8.5-openjdk-17-slim AS build

RUN mkdir /project

COPY . /project

WORKDIR /project

RUN mvn clean package

FROM khipu/openjdk17-alpine

RUN mkdir /app

RUN addgroup -g 1001 -S tecogroup

RUN adduser -S teco -u 1001

COPY --from=build /project/target/spring-petclinic-3.1.0-SNAPSHOT.jar /app/bmi.jar

WORKDIR /app

RUN chown -R teco:tecogroup /app

CMD java $JAVA_OPTS -jar bmi.jar