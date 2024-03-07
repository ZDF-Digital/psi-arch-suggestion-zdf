# Deployment and code guidelines (ZDFD draft)

## Infrastructure:
The services will be implemented in a way that makes shifting the services from one cloud technology to another easy. At minimum there is going to be a kubernetes deployment.  
Deployment will be under deployments/<technology\>/<environment\>. Each service will be run in a docker-container.
Terraform and/or deployment scripts, as well as CI/CD should be provided by devops under deployments/iac.

## Repositories:
Every backend service will be hosted in its own github repository. The services should be implemented in a compilable programming language. Assets should run in a minimal environment (e.g. alpine-linux).

## Frontend services:
Standalone frontend services should be implemented in react, react-native or comparable frameworks.

## Backend protocols:
Only streaming capable protocols such as gRPC, AMQP, Kafka or similar protocols, without or with a broker will be used.

## Frontend protocols:
REST to connect, websockets for intermediate updates.
