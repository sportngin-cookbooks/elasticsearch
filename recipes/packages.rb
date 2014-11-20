#-*- encoding : utf-8 -*-
package 'curl' do
  action :install
end

package 'tree' do
  action :install
end

package "openjdk-7-jre" do
  action :install
end

execute "update-alternatives --set java /usr/lib/jvm/java-7-openjdk-amd64/jre/bin/java" do
  
end
