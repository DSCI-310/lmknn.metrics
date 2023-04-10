# Welcome to DSCI310 Group 16 project contributing guide.
Thank you for investing your time in contributing to our project! We welcome all forms of contributions to this project! The following is a set of guidlines for contributing to our project. Feel free to propose changes in a pull request.

## New contributor guide
To get an overview of the project, read the [README](README.md). 

Please also take a look at our [Code of Conduct](CODE_OF_CONDUCT.md) before proposing any changes.

Here are some resources to help you get started with open source contributions:

- [Finding ways to contribute to open source on GitHub](https://docs.github.com/en/get-started/exploring-projects-on-github/finding-ways-to-contribute-to-open-source-on-github)
- [Set up Git](https://docs.github.com/en/get-started/quickstart/set-up-git)
- [GitHub flow](https://docs.github.com/en/get-started/quickstart/github-flow)
- [Collaborating with pull requests](https://docs.github.com/en/github/collaborating-with-pull-requests)


## Issues
Make sure it's substantially different from an existing issue. If a related issue doesn't exist, you can open a new issue by adding on to our [issues board](https://github.com/mjbrodie/dsci-310-group-16/issues). Ensure your post include as many details as possible:

- Title should be clear and desciptive
- Elaborate on how you observed the issue
- Provide a step-by-step method of recreating your issue.
- Describe the behaviour you observed after following the steps
- Explain which behaviour you expected to see instead and why
- Include details about your configuration and envrionment

**Note: A snapshot would help us significantly in aiding your issue.**

## How you can contribute to this project!

### Set Up Your Environment
Fork this project's repository on GitHub and then clone the fork to your local machine. For more details on forking see the [GitHub
Documentation](https://help.github.com/en/articles/fork-a-repo).
```
$ git clone https://github.com/mjbrodie/dsci-310-group-16
```

To keep your fork up to date with changes in this repo, you can use the fetch upstream button on GitHub. More details regarding fork syncing, e.g., syncing from your terminal instead of directly on Github can be found [**here**](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/working-with-forks/syncing-a-fork). 

### Create a Branch

Once your local environment is up-to-date, you can create a new git branch which will contain your contribution (always create a new branch instead of making changes to the master branch):
```
$ git switch -c <branch-name>
```
With this branch checked-out, make your desired changes.


### Testing your Changes

Before suggesting your contributing your changing to the main project repository, it is recommended that you run your changes on your separate branch first! Study the output of any failed tests and try to fix the issues before proceeding to the next section.

### Creating a Pull Request

When you are happy with your changes, you can commit them to your branch by running
```
$ git add <modified-file>
$ git commit -m "Some descriptive message about your change"
$ git push origin <branch-name>
```
You will then need to submit a pull request (PR) on GitHub asking to merge your example branch into our main project repository. For more details on creating a PR see GitHub documentation [Creating a pull request](https://help.github.com/en/articles/creating-a-pull-request). You can add more details about your example in the PR e.g., why you thought it would be a good addition.  

You will get feedback in 7 working days in the PR discussion if anything needs to be changed. 

We hope your PR will be answered in a timely manner and your contribution will help others in the future. Should there be a lack of a timely response, please send an email to ammarb99@student.ubc.ca

## Participated Contributors
This Project was mainly conducted by Miles Brodie, Ammar Bagharib and Sammy Gulip. We will also list other contributors' name here. We would like to acknowledge the other contributors who helped in the original data anaylsis of this project but are not participating in the current project; Ali Tariq, Simon Liang, and Luca Festa-Bianchet.  Thank you so much for reading this.




