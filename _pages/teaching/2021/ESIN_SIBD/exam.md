---
layout: page
title: ESIN/SIBD - Final Exam
permalink: /teaching/2021/ESIN_SIBD/exam/
crumbtitle: ESIN/SIBD 2020/2021 - Final Exam
tags: teaching databases web programming feup
---


{% include info.html content="Read these instructions carefully to avoid surprises. If you still have questions please email the course professors or post on Moodle." %}

## Times and Locations

### 1st Phase

- **Date**: 22/01/2021
- **Time**: 11:30 - 13:00
- **Rooms**: B207, B104

### 2nd Phase / Improvement

- **Date**: 06/02/2021
- **Time**: 08:30 - 10:00
- **Room**: B207, B104

## Necessary materials

If it is not listed below, it should not be on your table. Any consultation materials deemed necessary for the exam will be made available in Moodle.

- **Writing material**.
- **Blank paper sheets**, just in case we run out of draft paper sheets that we will supply during the exam. Sign and return all draft paper sheets to the professor in your exam room before leaving. All questions will be answered in Moodle, so you can use the paper sheet simply as a draft. **Anything written on the paper sheets will not be considered for evaluation.**
- **Student card**, which you will place on the corner of your table for easy checking; otherwise we will bother you during the exam unnecessarily.

**Smartwatches and mobile phones must stay in your bags.**

## Format

The exam will be made available in [Moodle](https://moodle.up.pt). **Please make sure to test your access to the platform. Contact the [FEUP Helpdesk](mailto:helpdesk@fe.up.pt) to sort out any issues beforehand.**  

**NOTE**: wrong answers on multiple choice questions will produce negative scores, so if you are not sure, **do not answer**.

- **UML Class Diagram**: multiple choice and open-answer questions.
- **Relational Model**: open-answer questions.
- **SQL**:
	- An SQL script will be provided in Moodle, that you must download and use to initialize your database. **Please review how to initialize a database in SQLite3 beforehand, so you do not waste time during he exam**.
	- For every exercise, you must provide the SQL query that returns the expected results. To avoid losing work and time, you can follow this workflow, like we did in class:
		1. Use a proper code text editor available at the FEUP computers, such as Notepad++, Atom or VS Code.
		2. Use UTF-8 encoding (same as the one used in the script).
		3. Make a separate text file for each of your solutions and edit the code there.
		4. Test your queries using the SQLite command line (use the `.read` command to run each of your files instead of typing on the command line).
		5. When you are happy with your solution, please copy and paste the solution into the answer text box in Moodle.
		6. Do not include any SQLite initialization code, such as `.headers on` or `.mode columns`. The answer should be the query itself only.
	- When a question does not ask you to order the results, your answer will be correct as long as it returns the expected tuples, regardless of their order.
	- Even when your answer produces the same tuples as the ones presented as the example result for the question, it may not be considered correct. In the correction we will test your queries against a database with the same structure as the supplied script but with different records, designed to test more edge cases (like we have seen in class). To be considered correct, your query should still produce the correct answers when ran against the correction database.
- **HTML, CSS, PHP, Git and Docker**: multiple choice and open-answer questions.
- **PHP**: code question.

## Previous exams

Some examples of previous years are available [here](https://web.fe.up.pt/~arestivo/page/courses/2018/sibd/exam/). Given that some topics covered have changed this year, the structure may also be different. Use the format above as reference.

## Important notes for Erasmus students (remote exams)

- In exceptional cases justified by the school calendar, Erasmus students may carry out the exam remotely at their home University.

- All Erasmus students that cannot be present during the exam **must** contact the course professors to arrange a remote exam.

- These students must secure the contact of a responsible person at their home University beforehand and supply that contact to the course professors. We will then coordinate with this person to arrange a controlled environment at the student's home institution where they can perform the exam. This person will assume responsibility for making sure that exam rules are followed.

- The responsible person needs to communicate to the professors the range of external IPs from which the student will perform the exam, otherwise the student will not be able to perform the exam.

## Play fair

Any illegal behaviour during the exam (plagiarism by any means or exchange of information between students) is punishable with a full annulment of the exam, resulting in a grade of zero.

All network accesses and interactions with the computers during the exam are monitored. Unlawful behaviour will be easy to detect and any implicated individuals will be dealt with accordingly.

Any attempt to perform the exam on computers other than the ones in the computer rooms is easily detectable and will result in __immediate anullment of the exam__, unless you are an Erasmus student and have contacted us beforehand to arrange a remote exam.
