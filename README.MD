
# AWSTools

This is a docker image that provides some basic tools to manipulate an AWS envionment

Its built on the Alpine docker image and contains the following tools:

 * AWSCLI - Installed via the python package manager ( pip )
 * Terraform - Downloaded directly from HashiCorp
 * Bash-my-AWS - Nice set of tools to help you AWS. Downloaded directly from the master branch on github [here](https://github.com/realestate-com-au/bash-my-aws) 

The containers default user is `cloud` and its home directory is /home/cloud
For convenience a directory named `project` has been created in this home directory. You can use this to store the files for your project or as a convenient place to mount your existing files as a volume



## Running

There are a number of ways you can run this container.

You could run it and execute your commands directly inside it:

    docker run -it mcrmonkey/awstools

You could pass commands to the container like so:

    docker run mcrmonkey/awstools aws <command>

or

    docker run mcrmonkey/awstools terraform <command>

You can mount your existing project files in to the container by adding the following volume options to the run command:

    -v /path/to/your/files:/home/cloud/project

See the docker documentation on volumes [here](https://docs.docker.com/engine/tutorials/dockervolumes/) for more information


### Your AWS Credentials 

Obviously you'll need to some credentials to actually talk to AWS or nothing will work for you.

You can do a few things to pass these details in:

 * Run `aws configure` inside the container

Enter each detail as prompted however if you delete the container the details will be lost

 * Pass your .aws directory to the container

Run the container with the volume option set:

    docker run -it -v /home/user/.aws:/home/cloud/.aws:ro mcrmonkey/awstools

 * Pass your pre-set details in to the container

If your envionment variables are already setup you can run the following to pass those variables directly in to the container:

   docker run -it -e AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY -e AWS_SESSION_TOKEN -e AWS_DEFAULT_REGION mcrmonkey/awstools


## Building

If you like you can build your own version of this container

First, clone this repo to a location of your choosing on your own machine:

    git clone git@github.com:mcrmonkey/awstools.git

Then run the following in that directory:

    docker build -t awstools .


Then you should be all set


## License

I've not applied one.

You can do what ever you like to this version. However, I'd ask you link back here if you make something based on this.


