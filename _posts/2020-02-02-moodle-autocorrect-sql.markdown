---
layout: post
title:  "Semi-automated correction of SQL exercises in Moodle"
date:   2020-02-02 18:37:000 +0100
categories: moodle teaching automated correction sql sqlite elearning
---

At FEUP we have a [Moodle instance](https://moodle.up.pt) provided by the University of Porto. I think Moodle is an awesome tool for e-learning: I use it as much as possible for centralizing lecture contents, organize assignment deliveries and provide not only grades but also individual feedback to my students. 

### The need for SQL (semi-) automated correction in moodle

I teach classes on Databases and [Web](https://sigarra.up.pt/feup/pt/ucurr_geral.ficha_uc_view?pv_ocorrencia_id=436868) [Development](https://sigarra.up.pt/feup/pt/ucurr_geral.ficha_uc_view?pv_ocorrencia_id=436868), and we have final exams that include SQL queries over a provided database. We use [SQLite](https://www.sqlite.org/download.html) for its ease of use and portability. It removes the need for a local or faculty server like [PostgreSQL](https://www.postgresql.org/download/) and [MySQL](https://www.mysql.com/downloads/) do. At the same time, what want is to focus on the students' learning of the SQL, not the maximum performance. Another great open-source tool for working with SQLite is the [DB Browser for SQLite](https://sqlitebrowser.org) software, by the way.

Going back to moodle, while I think it is packed with features that make it (imho) an essential tool for teaching nowadays, it does not support automatic correction of SQL exercises. 

Also, I am not a fan of 100% automatic correction of SQL exercises, so I needed a way to run the queries written by the students in an automated fashion against two databases: one that I provide to the students, and another, with the same schema but with more records, designed to test more edge cases.

However, as an informatics engineer, I hate repetitive tasks, especially those that can be automated. Copying and pasting student solutions from moodle into an SQL prompt only got me so far as the 20th answer before I was pulling hair out and decided something had to be done.

### Enter `moodle-autocorrect-sqlite`

To make my SQL corrections easier, I have written and published some [Python+Bash scripts on GitHub](https://github.com/silvae86/moodle-autocorrect-sqlite) for running students' queries present in the Excel Spreadsheet produced by Moodle with the results of an exam. This means that you need either **Linux** of **Mac OS X** to use these. Sorry this time, Windows users!

These scripts will produce a text file per answer that looks more or less like this:

![Sample output](https://github.com/silvae86/moodle-autocorrect-sqlite/raw/master/docs/img/sample.png){:class="img-responsive"}

## Two SQL scripts: one for the students, one for grading

We shall evaluate our students using two distinct database scripts.

While they both share the same database schema, one is provided to the students during the exam and contains fewer records than a second script with additional entries designed to test additional edge cases. We shall call them `script-students.sql` and `script-correction.sql` in this guide.

## Pre-requisites

	- Ubuntu Linux or
	- macOS with [Homebrew](https://brew.sh) installed

## Instructions

### Installation

1. Open Terminal
2. Clone the repository:

		`git clone https://github.com/silvae86/moodle-autocorrect-sqlite`

3. Go to the directory where the cloned files are:

		`cd moodle-autocorrect-sqlite`

4. Run the setup in Terminal (should detect your operating system, macOS or Ubuntu, and act appropriately)

	- `chmod +x setup.sh && ./setup.sh`

### Preparation of the environment

1. Download the answers of your students from moodle

	1.1. Access the Exam in Moodle

	1.2. Select the 'Responses' option to access the list of answers given by the students

	<img src="https://github.com/silvae86/moodle-autocorrect-sqlite/raw/master/docs/img/downloading_answers.png" alt="Access all student answers" width="200"/>

	1.3. Sort the answers by the first name of the students (or any other criteria, as the SQL evaluator will produce a list of answers ordered by that same criteria).

	1.4. Select Microsoft Excel as the download format for the answers

	1.5. Click 'Download'. An Excel file will be produced by moodle and start downloading.

	<img src="https://github.com/silvae86/moodle-autocorrect-sqlite/raw/master/docs/img/download_answers.jpg" alt="Ordering and downloading student answers" width="800"/>

2. Change the name of the downloaded file to `student_answers.xlsx` and place it in the `correction` folder.

3. Place the scripts that create the database schema and insert the necessary records in the `correction` folder: `script-students.sql` for the script given to the students and `script-correction.sql` to your correction script.

4. Now we need to place your proposed solutions for the SQL questions in the `correction/proposed_answers` folder.

	4.1. For every question that you want to automatically correct, place a `.sql` file with the same name as the header of the column in the Excel file downloaded from Moodle. 
	
	- For example, if the `Response 15` column in the Excel file contains SQL answers, you need to create a `correction/proposed_answers/Response 15.sql` file with your proposed solution (in SQL) for that question.

	4.2. The script will detect these `.sql` files and try to correct only those answers where there is a proposed answer.


### Running the script

The hard part is done. Let's run the script.

1. Open Terminal

2. `cd` to the folder where your files are (same as where you initially cloned this too)

3. Run script
	`./run.sh`

4. See the results in the `Results/` folder.
	- There should be one .txt file for each of the questions, more or less like this:

	<img src="https://github.com/silvae86/moodle-autocorrect-sqlite/raw/master/docs/img/results.png" alt="Example of the results" width="250"/>

### It's fast

These scripts are super fast, because they are simple. They even run in parallel, meaning that a separate process instance will be launched for every question you are grading, to take advantage of multicore processors.

### Grading

Access the exam in Moodle and go to the little gear at the top right and select "Manual Grading". After choosing the question you want to grade, change the settings like this:

1. Sort by the same criteria you used when you downloaded your Excel spreadsheet with the answers and 
2. Show many answers per page

<img src="https://github.com/silvae86/moodle-autocorrect-sqlite/raw/master/docs/img/manual-grading-settings.png" alt="Manual Grading Settings Example" />
	
Then, open the text file by the side of the manual grading window. Scroll in parallel and start grading!
