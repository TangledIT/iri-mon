require "uri"
require "http/client"
require "json"

module Iri::Mon
  class Ports
    getter config : Config
    def initialize(config)
      @config = config
    end

    def display
      print "IRI Monitor - Ports\n"
      print "--" * 20
      print "\n"

      item("HTTP API Port", @config.parsed_config["port"].to_s)
      item("TCP Receiver Port", @config.parsed_config["tcp_receiver_port"].to_s)
      item("UDP Receiver Port", @config.parsed_config["udp_receiver_port"].to_s)
      item("ZeroMQ Port", @config.parsed_config["zmq_port"].to_s) if @config.parsed_config["zmq_enabled"]
    end

    def item(key, value, linebreak = true)
      if value.is_a?(Bool)
        if value
          value = "\033[92mtrue\033[0m"
        else
          value = "\033[91mfalse\033[0m"
        end
      end
      print key.to_s + ": " + "\033[92m" + value.to_s + "\033[0m"
      print "\n" if linebreak
    end
  end
end
