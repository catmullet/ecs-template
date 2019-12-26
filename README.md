![](https://s3-us-west-2.amazonaws.com/assets.kyani.net/github/Screenshot+from+2019-11-20+14-40-24.png)
# ECS Template

## Getting started
#### Steps
- Create new repository using the ```Use this template``` button.
  > Use the kms naming convention
- Run in the terminal ```create.envfile ```
  > This will take the env.example.yml file and create a new one for you
- Run the project from the root.
  > You should see that it is running on the port specified in the environment file.
  > Once we have an environment running lets start building.
- Rename the project by running ```./rename-project {{Project Name}}```
  > This can only be run once so choose wisely.
- Commit your work so far.
  > Remember to keep it clean
  
## Getting to know the template
#### Description

All applications will have an API Gateway and behind that gateway microservices.  These microservices should reflect the businesses needs and should be designed in a way they can be maintained and scaled.  Any microservice endpoint that takes longer than a second should be re-thought and refactored to run the quickest possible.  Microservices will not be specific to any app and should be designed as if all applications will be accessing them.

## Where this will fit in
![](https://s3-us-west-2.amazonaws.com/assets.kyani.net/github/kms_architecture.png)
