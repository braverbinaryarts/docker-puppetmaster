#!/usr/bin/env ruby

ROOTDIR = '/opt/puppetlabs/storage'
SUBDIRS = ['var','var/log','var/run']

unless File.exists?(ROOTDIR) File.mkdir(ROOTDIR)

SUBDIRS.each do |subdir| 
  fullpath = "#{ROOTDIR}/#{subdir}"
  unless File.exists?(fullpath) File.mkdir(fullpath)
end

unless File.exists?("#{ROOTDIR}/code") system "cp -rp /etc/puppetlabs/code #{ROOTDIR}"
