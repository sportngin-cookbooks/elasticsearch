#-*- encoding : utf-8 -*-
package 'curl' do
  action :install
end

package 'tree' do
  action :install
end

package "default-jre" do
  action :install
end
