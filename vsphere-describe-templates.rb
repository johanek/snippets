#!/usr/bin/env ruby

require 'rubygems'
require 'fog'

Fog.mock!

f=Fog::Compute.new(:provider => "vsphere", :vsphere_username => "patrick", :vsphere_password=> "pipo1234**", :vsphere_server => "172.16.44.141")
servers = f.servers.all
instances = servers.all

puts "instance_uuid\t\t\t\tname"
instances.each do |instance|
  puts "#{instance.instance_uuid}\t#{instance.name}" if instance.is_a_template = "false"
end

