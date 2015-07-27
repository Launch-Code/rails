FROM ubuntu:14.04

RUN echo 'mysql-server-5.1 mysql-server/root_password password root' | debconf-set-selections
RUN echo 'mysql-server-5.1 mysql-server/root_password_again password root' | debconf-set-selections

RUN apt-get clean && apt-get update && apt-get upgrade -y && apt-get install -y curl nodejs libmysqlclient-dev git

#install RVM
RUN curl -sSL https://rvm.io/mpapis.asc | gpg --import -
RUN \curl -O https://raw.githubusercontent.com/wayneeseguin/rvm/master/binscripts/rvm-installer
RUN \curl -O https://raw.githubusercontent.com/wayneeseguin/rvm/master/binscripts/rvm-installer.asc
RUN gpg --verify rvm-installer.asc
RUN bash rvm-installer stable
RUN /bin/bash -l -c "rvm requirements"
RUN /bin/bash -l -c "rvm install 2.1.6"
RUN /bin/bash -l -c "rvm rubygems current"
RUN /bin/bash -l -c "gem install bundler --no-ri --no-rdoc"
RUN /bin/bash -l -c "gem install rails --no-ri --no-rdoc"

expose 3000
CMD ["/bin/bash -l -c "bundle exec rails s"]
