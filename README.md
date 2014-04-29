Slick Docker Image
==================

The slick docker image has everything you need to run the latest and greatest from
slickqa.  How do you use it?  Glad you asked.  If your running it for production
just simply:

    docker.io run -p 9000:80 slickqa/slickqaweb

If you're a developer, and you are working on code, you can run:

    docker.io run -p 9000:80 -v `pwd`:/slick slickqa/slickqaweb

And that will map the version of slick to you're current directory.  Then as you
change files, the uwsgi container will auto-restart to incorporate them.

Other options include:

  * Mapping the mongodb database dir using `-v /path/to/mongo/store:/data`
  * Mapping port 27017 (mongodb) 
  * Mapping port 5672 (rabbitmq)
  * Mapping port 15672 (rabbitmq-management)

At this time rabbitmq is NOT secured (default username and password).  I'm working on it.

Logs are all output to the /slick/logs directory, so if you map slick it'll be easy to get to
the logs.  The /slick directory can be mapped without a checkout, and the first startup will
do the checkout for you.
