# devops
Files for devops-related demo

The "application" folder is the code that gets installed to the default apache webroot directory on the web servers.

The "support_scripts" folder contains a RightScript and a support script for TravisCI. Together these scripts provide the entire CI/CD automation for this demo.

[![Build Status](https://travis-ci.org/RightScale-Demo/devops.svg?branch=master)](https://travis-ci.org/RightScale-Demo/devops)

## Demo
This section discusses how to use this repository to demonstrate the concept of CI/CD in RightScale.

### Preparation
Before demoing this functionality, prep the following things.

* Prepare to edit the index.html file and commit/push a change.
  * Using the github editor is easy [index.html](https://github.com/RightScale-Demo/devops/edit/master/application/html/index.html)
* Find (or launch) base linux servers which are tagged with `devops:servertype=webserver`
  * There are some running [here](https://us-3.rightscale.com/acct/30601/deployments/906750003#servers)
* Navigate to `http://<ip>/` for each server found in the previous step

### Demo Steps

* Change the `<h1>` value in the index.html page referenced above, and commit/push the change
* (Optionally) Show the latest build triggered in [TravisCI](https://travis-ci.org/RightScale-Demo/devops)
* Show the audit entries for the Deployment, or servers which ran the `DevOps_Demo_Webpage_Installer` RightScript.
* Refresh the web pages opened in the preparation steps, and show that the message changed to the value you set in the `<h1>` html tag and committed to git.

### Talking Points
* TravisCI main talking points
  * Github webhook that calls the TravisCI build when code commit occurs
  * .travis.yml defines the [target account](https://github.com/RightScale-Demo/devops/blob/master/.travis.yml#L3-L6) and executes the [support script](https://github.com/RightScale-Demo/devops/blob/master/.travis.yml#L15) for deployment.
  * The support script uses [rsc](https://github.com/RightScale-Demo/devops/blob/master/support_scripts/jenkinsBuildScript.sh#L17) to find all appropriately tagged servers, and run a cloud-agnostic rightscript to deploy the updated code.
    * Talk to the idea of the build script actually launching the web servers as well - [RightScale-Demo/devops Issue #3](https://github.com/RightScale-Demo/devops/issues/3)
* RightScale main talking points:
  * Single view of multiple servers across multiple clouds
  * Enables executing the same code install across multiple servers in multiple clouds.
  * Audit entries will show the updates occurring
  * Hitting the servers' IP addresses will show the web pages.

# TODO
Future enhancements and issues can be tracked [here](https://github.com/RightScale-Demo/devops/issues)
