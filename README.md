# Automated Code Deployment

Sometimes deployment can be very tidious task from cloning the code from the Git to deployment to the test and production environment  for the developers. which includes the dependency on the operations team for deployment of nay new feature. The complete process of deployment can be automated by following the instructions in the project. The objective of this project is to remove the blockheads and manual intervention in the process of deployment.

##### Sample Project


### Pre-requisites
- Docker Engine
- Jenkins
- Git


# Installation

- Clone this repository to add scripts for Jenkins Jobs

`Github Project URL`: https://github.com/riteshsoni10/login
`Github Repository`: https://github.com/riteshsoni10/login.git

Let's start with the configuration of JENKINS job 

### for Production Environment. 

1. Login into jenkins GUI
2. Click on `New Item` in the left column
3. Enable GitHub Project
    - Click on GitHub Project 
    - Enter the Github Project URL
 
 4. Configure the Source Code Management
    In source code management, the project's repository URL is to be entered. If the repository is public, there will be no need to configure the credentials; otherwise credentials for access of the repository will have to configured.

    In `branches to build` variable, the branch from which the code will be downloaded is to be configured. In our case, since this job is for production environment, the master branch is configured.

5. Build Triggers
    Build triggers notify when the job will be executed.  For now, Poll SCM variable is used, since the jenkins is in the private network and github is hosted in public network.
    
    `Poll SCM trigger` checks for any changes in the branch of the repository during the interval configured. Currently, the Poll SCM interval is configured to validate for changes in the branch at an interval of every minute.

6. Build
    In build step, Select `Execute Bash Shell` from `Add Build Step`.
    Paste the entire content of Bash script named production_job.sh in this step.
 
 7. Apply and then Save the Job
 
 
### for Development Environment 
`
asdadad
```
