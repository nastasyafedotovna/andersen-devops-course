### Continuous delivery

Following the automation of builds and unit and integration testing in CI, 
continuous delivery automates the release of that validated code to a repository. 
So, in order to have an effective continuous delivery process, it’s important that CI is already built into your development pipeline. 
The goal of continuous delivery is to have a codebase that is always ready for deployment to a production environment.

In continuous delivery, every stage—from the merger of code changes to the delivery of production-ready builds—involves test automation and code release automation.

### Continuous deployment

The final stage of a mature CI/CD pipeline is continuous deployment. 
As an extension of continuous delivery, which automates the release of a production-ready build to a code repository, continuous deployment automates releasing an app to production. 
Because there is no manual gate at the stage of the pipeline before production, continuous deployment relies heavily on well-designed test automation.

In practice, continuous deployment means that a developer’s change to a cloud application could go live within minutes of writing it (assuming it passes automated testing). 
This makes it much easier to continuously receive and incorporate user feedback. Taken together, all of these connected CI/CD practices make deployment of an application less risky, 
whereby it’s easier to release changes to apps in small pieces, rather than all at once. 
