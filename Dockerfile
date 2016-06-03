FROM centos

ENV CHEFHOME /chef-repo
ADD chef-repo /chef-repo

RUN yum -y install gcc make
RUN curl -L http://www.opscode.com/chef/install.sh | bash
RUN /opt/chef/embedded/bin/gem install --no-ri --no-rdoc berkshelf
RUN cd ${CHEFHOME} && /opt/chef/embedded/bin/berks vendor ${CHEFHOME}/cookbooks && chef-solo -c ${CHEFHOME}/solo.rb -j ${CHEFHOME}/nodes/docker.json
