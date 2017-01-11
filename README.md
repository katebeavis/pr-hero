# PR Hero

An app to help keep track of PR's, utilising the Github API with Octokit, webhooks & the HipChat API

## PR Hero does 3 things:

### 1) PR Lead time

Shows the average, maximum & minimum lead time for PR's for a given repo on a weekly basis. This data is displayed on a line graph, using Highcharts

An email is sent at the start of the week, stating whether the PR lead time in the previous week was better, worse or the same as the week before that

![PR Lead time](/app/assets/images/lead_time.png?raw=true)

### 2) Number of PR's contributed to per team member

To help gain an understanding of a teams productivity, a bar chart displays the number of PR's contributed to per team member, both all time and in the last 7 days. Team member names are obscured

An email is sent at the start of the week, stating how many team members have contributed below average or above average to PR's in the past 7 days

![PR's contributed to](/app/assets/images/contributed_to.png?raw=true)

### 3)  HipChat notifications

Using webhooks, whenever a PR is opened or merged, a message will be posted in a HipChat room. When a PR is opened, the app will make a recommendation on who should review it, based on number of PR's contributed to in the last 7 days, and notify that person

![HipChat notifications](/app/assets/images/hipchat_notifications.png?raw=true)

## To setup

``bundle install``

Add an .env file with the following credentials:

```
GITHUB_TOKEN=YOUR_GITHUB_TOKEN
gmail_username: "EMAIL_ADDRESS"
gmail_password: "EMAIL_PASSWORD"
HIPCHAT_TOKEN=YOUR_HIPCHAT_TOKEN
```

Github docs: https://help.github.com/articles/creating-an-access-token-for-command-line-use/

Hipchat docs: https://www.hipchat.com/docs/apiv2/method/generate_token

Add your repo:

In ``/lib/octokit_api.rb`` set any repo arguments to the repo you want to use, e.g:

```
def pull_requests(state='closed', repo='rails/rails')
  @client.auto_paginate = true
  @client.issues repo, state: state
end
```

Add the users you want to track PR contributions from:

In ``/lib/compute_comment_stats.rb`` add the Github usernames to the ``USERS`` constant

``USERS = ['dhh', 'tenderlove', 'skmetz', 'avdi']``

## To run

Fire up your server:

``$ rails s``

Visit ``http://localhost:3000/`` and you're good to go! :tada:

## To do

- PR Hero has verrrrry basic styling at the moment, and no there is no UX, it is very functional so I would like to make it a better experience to use

- I would like to make it easier to input/change the repo that data is being pulled from. At the moment you have to change it in the code

- The email functionality doesn't always work as it should, this needs to be improved
