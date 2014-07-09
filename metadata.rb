#-*- encoding : utf-8 -*-
maintainer       "Ian Ehlert"
maintainer_email "ian.ehlert@sportngin.com"
license          "Apache"
description      "Installs elasticsearch"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.markdown'))
version          "0.2.0"

recipe "elasticsearch::install", "Used during the setup lifecyle event to install the necessary packages and set up elasticsearch"
recipe "elasticsearch", "Used during the configure lifecycle event to configure elasticsearch for the cluster"
