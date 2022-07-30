FROM debian:buster-slim
RUN apt-get update

# for text in screenshots
ENV LANG en_US.UTF-8
RUN apt-get install -y locales \
 && sed -i "s/^# $LANG/$LANG/" /etc/locale.gen \
 && locale-gen

# for bitmap-font-patcher
RUN apt-get install -y python python-fontforge python-pip python-dev libfreetype6-dev
RUN pip install bdflib Pillow

# for tamzen-font
# NOTE: x11-xserver-utils provides xset(1)
# NOTE: xfonts-utils provides bdftopcf(1) and fonttosfnt(1)
RUN apt-get install -y ruby git xfonts-utils bdf2psf default-jre \
                       vnc4server x11-xserver-utils xterm imagemagick
RUN gem install bundler

WORKDIR /opt
COPY Gemfile .
COPY Gemfile.lock .
RUN bundler install
# RUN vncserver -SecurityTypes None \
#  && export DISPLAY=$(ls -t ~/.vnc/*.pid | grep -oPm1 ':\d+') \
#  && bundler exec rake clobber default
# COPY /opt .
