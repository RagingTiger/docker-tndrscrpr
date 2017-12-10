## About
Repo for the dockerized version of `tndrscrpr`

## Running The Script

To run the script tinderGetPhotos.py, one must first do the following:

1.  Download the Tinder app, create a profile, and get it up and running.
2.  Create a folder to which the scraped photos will be saved.  Then fill in the
    imagePath variable in the script.
3.  Get your FaceBook ID from https://findmyfbid.in/.  Then fill in the
    facebook_id variable in the script.
4.  Get your FaceBook token by clicking this [link](https://www.facebook.com/v2.6/dialog/oauth?redirect_uri=fb464891386855067%3A%2F%2Fauthorize%2F&display=touch&state=%7B%22challenge%22%3A%22IUUkEUqIGud332lfu%252BMJhxL4Wlc%253D%22%2C%220_auth_logger_id%22%3A%2230F06532-A1B9-4B10-BB28-B29956C71AB1%22%2C%22com.facebook.sdk_client_state%22%3Atrue%2C%223_method%22%3A%22sfvc_auth%22%7D&scope=user_birthday%2Cuser_photos%2Cuser_education_history%2Cemail%2Cuser_relationship_details%2Cuser_friends%2Cuser_work_history%2Cuser_likes&response_type=token%2Csigned_request&default_audience=friends&return_scopes=true&auth_type=rerequest&client_id=464891386855067&ret=login&sdk=ios&logger_id=30F06532-A1B9-4B10-BB28-B29956C71AB1&ext=1470840777&hash=AeZqkIcf-NEW6vBd)
    . Click Ok, and then look in the response to the POST request
    https://www.facebook.com/v2.6/dialog/oauth/confirm?dpr=1.  One way to
    see the response to the POST request is to open Developer Tools in
    Google Chrome prior to clicking Ok, and navigating to the Network tab.  
    In the response, one's token will be the string sandwiched between
    `&access_token=` and `&expires_in=`. Fill in the facebook_token variable
    in the script.
