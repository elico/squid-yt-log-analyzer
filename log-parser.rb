#!/usr/bin/env ruby

require 'open-uri'
require 'resolv'

f = File.open ARGV[0]
lines = f.readlines
f.close

debug = false

doms = {}
ips = []

dummycons = 0
lines.each do |line|
    dom = ''
    tmpline = line.split
    if tmpline[5] == 'CONNECT'
        dummycons += 1
        dom = (tmpline[6].split(':')[0]).to_s
    else
        dom = URI(tmpline[6]).host.to_s
    end
    next if dom.empty?
    next unless dom =~ /(\.googlevideo\.com)$/
    if doms[dom].nil?
        doms[dom] = 1
    else
        doms[dom] += 1
    end
end

puts doms if debug

dnsResolver = Resolv::DNS.new(nameserver: [ARGV[1]])

doms.each_key do |k|
    result = dnsResolver.getresources(k, Resolv::DNS::Resource::IN::A)
    result.map do |r|
        ips << r.address unless ips.include?(r.address)
    end
end
puts ips
