#!/bin/bash

if [ ! -e /var/lib/slick/first_init ]
then

    # initialize rabbitmq password
    # RABBITMQ_PASS=`pwgen -s 8 1`
    #echo "- Setting up RabbitMQ admin password"

    #cat > /etc/rabbitmq/rabbitmq.config <<EOF
#[
#   {rabbit, [{default_user, <<"admin">>},{default_pass, <<"$RABBITMQ_PASS">>}]}
#].
#EOF

    #echo
    #echo "===================================================================="
    #echo " You can now connect to rabbitmq on this machine by:"
    #echo "   rabbitmqadmin -u admin -p $RABBITMQ_PASS -H <host> -P 15672"
    #echo "===================================================================="
    #echo

    echo "- Initializing mongodb"
    echo 
    /var/lib/slick/initmongo
    echo
fi

# checkout slick if we don't have them mounted
if [ ! -e /slick/slickqaweb ]
then
    echo "- Getting latest slickqa code"
    cd /
    git clone http://github.com/slickqa/slickqaweb.git slick
    python -c 'import uuid; print uuid.uuid4();' >/slick/secret_key.txt
    chown -R www-data /slick
fi

if [ ! -e /slick/logs ]
then
    mkdir -p /slick/logs
    chown www-data /slick/logs
fi

if [ ! -e /var/lib/slick/vpython ]
then
    cd /var/lib/slick
    virtualenv vpython
    vpython/bin/pip install -r /slick/requirements.txt
    chown -R www-data /var/lib/slick
fi

if [ ! -e /usr/bin/narc ]
then
    echo "- Installing narc"
    pip3.4 install slickqa-narc
fi

touch /var/lib/slick/first_init
