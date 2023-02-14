# OCI-Based Oracle on Containers Lab
Lab resources for working with Oracle databases in containers using Oracle Cloud Infrastructure resources.

This lab uses Docker images and prepared snapshots, allowing students to quickly refresh the lab to any point. It runs on Oracle Cloud Infrastructure but does *not* use Always-Free resources. However, it will run on an Oracle Free Tier account using credits during the introductory period. Cost for running the lab is approximately $2.50/day for block storage and $3-5/day for compute resources. Compute doesn't incur charges if the instance is stopped. It is possible to run *most* of this on Always Free resources but the performance and experience are poor, and the limited memory of VM.Standard.E2.1.Micro instances prevent database containers from running.

# Provision Lab Resources
There are two options available for provisioning the lab:
* [Deploy the resources on Oracle Cloud Infrastructure.](#deploy-on-oci)
* [Install Docker Desktop and download files to your laptop.](#deploy-lab-resources-locally)

OPTIONAL: If you want to experiment with remote connections to container databases, [download SQL Developer](https://www.oracle.com/database/sqldeveloper/technologies/download/) and set it up on your machine.

## Deploy on OCI
To deploy this lab on Oracle Cloud Infrastructure, [create a new Always Free Tier account](https://signup.cloud.oracle.com), log in to an existing Free Tier account during the trial period, or log into a paid account.

Then, click on the "Deploy to Oracle Cloud" button:

[![Deploy to Oracle Cloud](https://oci-resourcemanager-plugin.plugins.oci.oraclecloud.com/latest/deploy-to-oracle-cloud.svg)](https://cloud.oracle.com/resourcemanager/stacks/create?zipUrl=https://github.com/oraclesean/RMOUG2023/releases/latest/download/RMOUG-lab.zip)

Accept the Oracle Terms of Use and click the "Next" button.

![p1](/images/p1.png)

Confirm that you have accepted the License Agreement by checking the box.

![p3](/images/p3.png)

Check "Show advanced options." Uncheck the "Auto-generate SSH key" box if you want to add your own SSH key.

![p4](/images/p4.png)

If you chose to use your own key, add or paste it here.  [How to generate an SSH key](https://docs.oracle.com/en/cloud/cloud-at-customer/occ-get-started/generate-ssh-key-pair.html)

![p5](/images/p5.png)

Click the "Next" button. On the next page, make sure the "Run Apply" checkbox is checked, then click the "Create" button.

![p6](/images/p6.png)

Resource Manager will begin building the stack. It takes roughly 15-20 minutes.

![p7](/images/p7.png)

When the job completes, the "RMJ" box turns green and a new tab will appear (you may need to reload the page) titled "Application Information". Select this tab and copy the "Compute instance public IP". 

If you opted for a generated SSH key, click the "Unlock" link beside the SSH key field. Copy the key, then paste it into a file on your system. The key text isn't formatted—you'll need to add line breaksinto your file.

![p8](/images/p8.png)

Open a terminal or shell session on your local machine and enter the following command, substituting the path to your SSH key and the public IP address of the compute instance you just copied from OCI:

```
ssh -l opc -i <path to your key> <compute public IP address>
```

Full provisioning takes roughly 15-20 minutes. The instance is ready when the last line of  `/tmp/setup-docker.log` reads `Docker and database setup is complete`.

The Resource Manager stack performs the following actions:
* Creates resources: a VCN, Internet Gateway, public subnet and security list, compute instance with attached 1TB block storage under `/oradata`, etc.
* Creates the `oracle` user and `oinstall` and `docker` groups.
* Installs Git and Docker Engine for Linux.
* Relocates the Docker Engine directory from `/var/lib/docker` in the boot volume to `/oradata/.docker` (to provide additional space for container resources).
* Creates directories and downloads Apline, a small-footprint Linux OS, which we'll use for demonstrating Overlay Filesystems.
* Clones the Oracle container repostitory to `/oradata/docker-images` and prepopulates the 19c image build directory with the Oracle Database software.
* Clones lab scripts to `/oradata/scripts`.
* Pulls an Oracle 19c EE container image. This is faster than building one—you have the opportunity to build one if you prefer.

## Deploy Lab Resources Locally
If you prefer to run the lab on your local machine, you'll need to provision resources on your own.

* [Download and install Docker Desktop from https://www.docker.com](https://www.docker.com) for your operating system.

    *NOTE: Docker Desktop for Apple Silicon does _not_ currently support Oracle Database images/containers.*

    If you're on Windows, you'll also need to [install Windows Subsystem for Linux 2](https://learn.microsoft.com/en-us/windows/wsl/install). The default Ubuntu Linux distribution is fine. I also recommend [installing Windows Terminal](https://learn.microsoft.com/en-us/windows/terminal/install), which I find more usable and fluid than PuTTY, PowerShell, CMD, etc.

* Clone the Oracle container image repository to a directory on your machine. I suggest selecting a base directory that's close to the root of your user home, since the path we'll be working with is fairly lengthy.

    The following command clones the repository into a directory called `docker-images` under your user's home: `git clone https://github.com/oracle/docker-images ~/docker-images`. 

    Alternately, you can navigate to the directory where you want to add the repository and run: `git clone https://github.com/oracle/docker-images`.

    Or, download a ZIP archive from [https://github.com/oracle/docker-images](https://github.com/oracle/docker-images). Click on the green "Code" button, and select the "Download ZIP" option. Then, unzip the file in the desired location.

* Pull the prepared Oracle 19c database image to your machine with the following command: 

    `docker pull phx.ocir.io/axh0z5q052rw/oracle:19.3.0`

    Confirm the image is present by running:

    `docker images`

* Open the [lab scripts](https://github.com/oraclesean/oracle-container-lab) in a browser window.

* OPTIONAL: Before you can build your own images, [download the Oracle 19c installation binaries from https://www.oracle.com/database/technologies/oracle-database-software-downloads.html](https://www.oracle.com/database/technologies/oracle-database-software-downloads.html).

    *IMPORTANT: No matter what OS you're using, download the 19.3 ZIP file for Linux x86-64!*

* OPTIONAL: Move or copy the Oracle 19c Database installation ZIP file you downloaded earlier into the following directory under the container repostitory you created above: `docker-images/OracleDatabase/SingleInstance/dockerfiles/19.3.0`. Do not unzip the file or change the name!

