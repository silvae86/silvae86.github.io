---
layout: page
title: Project work environment setup
permalink: /teaching/2021/ESIN_SIBD/project_setup
crumbtitle: Project Setup with Git and Docker
tags: teaching databases web programming feup docker setup project git
---

## Set up the working environment for the project using Git and Docker

It is recommended that only one element of each group does this process and the others watch carefully to avoid `git` conflicts. 

### Windows instructions

1. Go to GitHub and create your new Git repository for the practical work. 
2. Clone the repository into a folder. 
	- In Windows you can clone to `C:\webdev`, to make it a shorter path without spaces, which sometimes complicates things
	- You may need to run the operation as an administrator, because it needs that to be able to write to the `C:\webdev` folder. In Windows, accessing the hard drive root requires admin rights.
3. Now double-click `C:\webdev`. It should be an empty folder. 
4. Create a new folder inside `C:\webdev` called `html`. Download [this file]({% link _pages/teaching/2021/ESIN_SIBD/common/index.html %}) and place it inside the newly created `html` folder.
5. Open a command line (press Windows Key + R on your keyboard, then type `cmd.exe` and press Enter)
6. Type `cd C:\webdev` to go to the repository folder
7. Run `git status` on the command line to see if it really is a repository
8. See installation instructions [here](/teaching/howto/local_dev_with_docker) if you do not have Docker installed yet
9. Run the command to start the HTTP Server powered by Docker
	```cmd
	docker run -d -p 8080:8080 -it --name=php -v C:\webdev\html:/var/www/html quay.io/vesica/php73:dev
	```
10. Access your browser at [http://localhost:8080](http://localhost:8080). You should see a "Hello World!" page.	
	- If you edit the `C:\webdev\html\index.html` with Notepad and refresh the  [http://localhost:8080](http://localhost:8080) page, it should change!
11. Commit and push your changes
		- Run `git commit -a -m "My first commit!"` in the command line that you should still have open
12. Go to your GitHub repository on the GitHub website. You should see the new commit message.

### Linux / Mac Instructions

1. Go to GitHub and create your new Git repository for the practical work. 
2. Clone the repository into a **folder**. 
3. Now double-click the **folder**. It should be empty. 
4. Create a new folder inside the **folder**, called `html`. Download [this file]({% link _pages/teaching/2021/ESIN_SIBD/common/index.html %}) and place it inside the newly created `html` folder.
5. Open a command line
6. Type `cd <folder>` to go to the **folder**, which is now a git repository
7. Run `git status` on the command line to see if it really is a repository
8. See installation instructions [here](/teaching/howto/local_dev_with_docker) if you do not have Docker installed yet
9. Run the command to start the HTTP Server powered by Docker
	```bash
	docker run -d -p 8080:8080 -it --name=php -v $(pwd)/html/site:/var/www/html quay.io/vesica/php73:dev
	```
10. Access your browser at [http://localhost:8080](http://localhost:8080). You should see a "Hello World!" page.	
	- If you edit the `<folder>/html/index.html` with GEdit or atom and refresh the  [http://localhost:8080](http://localhost:8080) page, it should change!
11. Commit and push your changes
	- Run `git commit -a -m "My first commit!"` in the command line that you should still have open
12. Go to your GitHub repository on the GitHub website. You should see the new commit message.

### Reporting questions or problems

Questions or problems with this guide? Please contact the professors via email or in class. 