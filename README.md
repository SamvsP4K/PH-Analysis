# Retirement Analysis 

## The purpose of this analysis is to document how many potential job openings would need to be covered considering the number of employees that are closer to retirement. Additionally, we also found how many current employees would be considered for the mentorship program the company has.

## Documents and data process

We were given multiple excel files that contained information about the current employees, the timeline of their employment, titles, management information, and identification numbers. Using those documents a table was created to find the retirement titles that would need to be considered and how many of each of those positions will need to be filled. That was done by joining an employees table that included IDs and employee names with a titles table.

From there, the Distinct ON and count functions were used to find the specific number of each title that would need to be covered. See table below. (Additional exports can be found in the exports folder included in this github)


![Number_titles](https://user-images.githubusercontent.com/110923091/196006193-78cca1a7-3dda-498d-b58a-cde481f91fbc.PNG)

##Findings

* In the table about we can see that the total number of jobs that will need to be covered is 72,458.
* 70% of those jobs are between two categories, Senior Engineer and Senior Staff.
* In the mentorship export we find that 1550 current employees are eligible for the mentorship program. 

![mentor_titles](https://user-images.githubusercontent.com/110923091/196006473-62a1162d-3411-4373-ba01-fdc5f60dc537.PNG)

* Above is a breakdown of the eligible employees for mentorship and their current titles. When we compare this breakdown to the number of positions that need to be filled we can quickly see that a lot of action needs to be taken to staff the amount of retirement positons. The mentorship program, while helpful, will not be able to cover even 50% of the positions that need to be filled.
