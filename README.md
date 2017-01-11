# PR Hero

An app to help keep track of PR's, utilising the Github API with Octokit, webhooks & the Hipchat API

## PR Hero does 3 things:

### 1) PR Lead time

Shows the average, maximum & minimum lead time for PR's for a given repo on a weekly basis. This data is displayed on a line graph, using Highcharts

![Alt text](/app/assets/images/lead_time.png?raw=true "Optional Title")

### 2) Number of PR's contributed to per team member

To help gain an understanding of a teams productivity, a bar chart displays the number of PR's contributed to per team member, both all time and in the last 7 days. Team member names are obscured

### 3)  Hipchat notifications

Using webhooks, whenever a PR is opened or merged, a message will be posted in a Hipchat room. When a PR is opened, the app will make a recommendation on who should review it, based on number of PR's contributed to in the last 7 days

## To run

## To do

- PR Hero has verrrrry basic styling at the moment, and no there is no UX, it is very functional so I would like to make it a better experience to use

- I would like to make it easier to input/change the repo that data is being pulled from. At the moment you have to change it in the code
