# RootedWI
Rooted's Troy Farm customer balance app

## Getting Started 
(From UWanted tutorial)

How to create a new branch from other's and push your branch to remote repo

* First you need to clone the remote repository

        git clone https://github.com/owenjcarr/RootedWI.git

    Then create a new branch from an old branch you want to work from

        git checkout -b newbranch master

    And now you are in your new branch.

* When you push your branch to remote repository for the first time, you need to set the upstream to the remote branch

        git push --set-upstream origin newbranch

    After this, you can just push your branch by

        git push
