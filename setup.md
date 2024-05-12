---
layout: page
title: Setup
root: .
---


### Key requirement

The main requirement for this workshop is a personal computer with a web browser and a command line shell program.  

*Windows* users: [MobaXterm](https://mobaxterm.mobatek.net/download-home-edition.html) is the *preferred option*.  The *Portable Edition* is best, as it does not require administrative privileges.  
<!--Other acceptable options would be [Visual Studio Code](https://code.visualstudio.com/) or PuTTY, but you will also need to install [Cygwin/X](https://x.cygwin.com) to run the example on X11 applications.  -->
In this way you will be able to follow the online materials and to login to a facility with the required software stack.


### Training accounts

We will be providing training user accounts to both pre-configured EC2 instances.

<div style="text-align:center"><img src="fig/AWS_logo.png" width="250"></div>

This tutorial is supported by the Amazon AWS Machine Learning Research Awards. EC2 images and temporary login credentials will be distributed onsite at the tutorial.

After the tutorial, you can boot our tutorial image yourself on Amazon EC2 to run through the tutorial again. We recommend you use your own EC2 key and change the password.

US-West-2 Oregon: ami-08ab931791269deeb


### NERSC Training Accounts (optional)

In addition to the AWS instances, you can also try running some of the Shifter-based excercises on NERSC's Perlmutter system, a Cray EX system.  To sign-up for a NERSC tutorial account, visit
[https://iris.nersc.gov/train](https://iris.nersc.gov/train) and fill out the form.  The training code will be provided during the tutorial.  Please note that, due to security
restrictions, access may be limited but all of the excercises can be done on the AWS instances.


### Materials repository

To run the examples yourself, you can download the materials with:

```bash
cd ~
git clone https://github.com/supercontainers/isc-tutorial.git
cd isc-tutorial
git checkout isc23
cd exercises
```


> ## Prerequisites for self-paced tutorials
> 
> Users can also install Docker and Singularity prior to attending the tutorial session.  MPICH is required for running the MPI examples, too.  
> Here, it may be beneficial to create a Docker and Sylabs (Singularity) account in advance at [https://cloud.docker.com](https://cloud.docker.com) and [https://cloud.sylabs.io](https://cloud.sylabs.io).  These accounts will be needed to create images on Docker Cloud/DockerHub and Sylabs Cloud.
> 
> [Install Singularity on Linux]({{ page.root }}/files/install-singularity.sh) \| [docs](https://sylabs.io/guides/3.5/user-guide/quick_start.html)
> 
> [Install Docker on Linux]({{ page.root }}/files/install-docker.sh) \| [docs (unofficial)](https://www.itzgeek.com/how-tos/linux/ubuntu-how-tos/how-to-install-docker-on-ubuntu-18-04-lts-bionic-beaver.html)
> 
> [Install MPICH on Linux]({{ page.root }}/files/install-mpich.sh) \| [docs](https://www.mpich.org/documentation/guides/)
> 
> **Note:** install scripts have been tested on a Ubuntu machine through a user that can run *sudo* commands without password prompts. There's no warranty they will work in your Linux box, you should consider them as templates.
> 
> ### macOS or Windows machine
> 
> For *Singularity*, you will need to setup a Linux virtual machine, and then follow the same instructions as above.  
> It's not as bad as it sounds... the main two options are:
>   - Vagrant: follow these instructions by Sylabs on [Setting up Singularity with Vagrant](https://sylabs.io/guides/3.5/admin-guide/installation.html#installation-on-windows-or-mac) (*macOS* users: DO NOT use the proposed *Singularity Desktop*, use Vagrant instead);
>   - Multipass: follow instructions from the [Multipass Homepage](https://multipass.run).
> 
> For *Docker*, you can download and run installers for [macOS](https://hub.docker.com/editions/community/docker-ce-desktop-mac/) and [Windows](https://hub.docker.com/editions/community/docker-ce-desktop-windows/).
{: .solution}
