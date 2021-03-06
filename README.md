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

HipChat: See below

### Add your repo:

In ``/lib/octokit_api.rb`` set any repo arguments to the repo you want to use, e.g:

```
def pull_requests(state='closed', repo='rails/rails')
  @client.auto_paginate = true
  @client.issues repo, state: state
end
```

### Add the users you want to track PR contributions from:

In ``/lib/compute_comment_stats.rb`` add the Github usernames to the ``USERS`` constant, e.g:

``USERS = ['dhh', 'tenderlove', 'skmetz', 'avdi']``

### Add a webhook

In the repo you want to receive PR notifications from, go to settings > Webhooks and under ``Payload URL`` add ``http://YOUR_WEB_ADDRESS/payload``

It can't be ``localhost`` so I would recommend using ngrok https://ngrok.com/

Select 'Let me choose individual events' and then 'Issues' and 'Pull Request'

### Add the HipChat room you want to send notifications to:

Go to your rooms: (You need to be room admin)

https://zopa.hipchat.com/rooms?t=mine

Click on the room > Tokens and then create one with scopes ``Send notification`` and ``View room``

Find your unique room identifier (under ``API ID`` on your rooms summary tab)

In ``/lib/hipchat_api.rb`` add to it the ``send_message`` method, e.g, if your identifier was 123456:

```
def send_message(username, message, options = {})
  @client['123456'].send(username, message, options)
end
```

## To run

Fire up your server:

``$ rails s``

Visit ``http://localhost:3000/`` and you're good to go! :tada:

## To run tests :vertical_traffic_light:

``$ rspec`` and :boom: (in a good way)

## To do

- PR Hero has very basic styling at the moment, and there is no UX, it is very functional so this needs to be improved

- To change the repo that data is being pulled from, you have to change it in the code. Next step is to add a front end interface where you can add/change the repo

- The email functionality doesn't always work as it should, this needs to be improved

- Extract all unique identifiers (room token, team member names, etc) into the .env file
