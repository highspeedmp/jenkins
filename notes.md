(a) The bash script makes sure our tools are installed

(b) The default puppet install from apt comes with 0 modules installed. 

(c) Clean install of Ubuntu 22.04

(d) Jenkins install as per instructions at https://www.jenkins.io/doc/book/installing/linux/#debianubuntu

(e) Puppet needs to manage the main jenkins config file, the Jenkins service should subcribe to the conf file. 

(f) Repeat puppet runs don't cause failures or repeat config steps. 

Jenkins writes a password here
/root/.jenkins/secrets/initialAdminPassword

Reference sources: 
https://www.jenkins.io/doc/book/installing/initial-settings/

