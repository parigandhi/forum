FROM php:7.3-apache 

ARG HOST_MACHINE_MYSQL_PORT
ARG MYSQL_DATABASE
ARG MYSQL_ROOT_PASSWORD

RUN docker-php-ext-install mysqli
RUN apt-get update \
    && apt-get install -y libzip-dev \
	&& apt-get install -y wget \
    && apt-get install -y zlib1g-dev \
    && rm -rf /var/lib/apt/lists/* \
    && docker-php-ext-install zip

WORKDIR /var/www/html

RUN wget https://download.phpbb.com/pub/release/3.3/3.3.0/phpBB-3.3.0.tar.bz2 \
&& tar -xvjf phpBB-3.3.0.tar.bz2 \
	&& cp -r phpBB3/* . \
	&& rm -r phpBB3 \
	&& rm phpBB-3.3.0.tar.bz2 \	
	&& rm -r install \
	&& touch config.php \
	&& echo "<?php " >> config.php \
	&& echo "\$dbms = 'phpbb\\db\\driver\\mysqli'; " >>  config.php \
	&& echo "\$dbhost = 'database';" >> config.php \
	&& echo "\$dbport = '${HOST_MACHINE_MYSQL_PORT}';" >> config.php \
	&& echo "\$dbname = '${MYSQL_DATABASE}';" >> config.php \
	&& echo "\$dbuser = 'root';" >> config.php \
	&& echo "\$dbpasswd = '${MYSQL_ROOT_PASSWORD}';" >> config.php \
	&& echo "\$table_prefix = 'phpbb_';" >> config.php \
	&& echo "\$phpbb_adm_relative_path = 'adm/';" >> config.php \
	&& echo "\$acm_type = 'phpbb\\\cache\\\driver\\\file';" >> config.php \	 
	&& echo "@define('PHPBB_INSTALLED', true);" >> config.php \
	&& echo "@define('PHPBB_ENVIRONMENT', 'production');" >> config.php \
	&& echo "@define('DEBUG_CONTAINER', true);" >> config.php \			
	&& chmod -R 777 /var/www/html 