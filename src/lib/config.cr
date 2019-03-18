require "ini"

module Iri::Mon
  class Config
    property parsed_config = {} of String => String | Int32 | Bool | Array(String)

    def initialize(config_location = nil)
      ini = INI.parse(locate_config(config_location).to_s)
      config = ini["IRI"]? ? ini["IRI"] : ini

      @parsed_config["port"] = fetch_integer(config, "PORT", 14265)
      @parsed_config["udp_receiver_port"] = fetch_integer(config, "UDP_RECEIVER_PORT", 14600)
      @parsed_config["tcp_receiver_port"] = fetch_integer(config, "TCP_RECEIVER_PORT", 15600)
      @parsed_config["zmq_port"] = fetch_integer(config, "ZMQ_PORT", 5556)
      @parsed_config["zmq_enabled"] = fetch_boolean(config, "ZMQ_ENABLED")
      @parsed_config["debug"] = fetch_boolean(config, "DEBUG")
      @parsed_config["testnet"] = fetch_boolean(config, "TESTNET")
      @parsed_config["neighbors"] =  fetch_array(config, "NEIGHBORS")
      @parsed_config["remote_limit_api"] = fetch_array(config, "REMOTE_LIMIT_API")
      @parsed_config
    rescue
      print "Unable to parse IRI .ini file.\n"
      exit
    end

    def fetch_array(config, key)
      return [] of String unless config[key]?
      config[key].to_s.tr("\"", "").split(",").map(&.strip)
    end

    def fetch_boolean(config, key)
      return false unless config[key]?
      config[key].to_s == "true"
    end

    def fetch_integer(config, key, default = 0)
      return default unless config[key]?
      config[key].to_s.to_i32
    end

    def locate_config(config_location)
      file_locations = [
        config_location,
        "iri.ini",
        "/etc/iri/iri.ini",
        "/var/lib/iri/iri.ini"
      ]

      file_locations.compact.each do |item|
        return File.read(item) if File.exists?(item)
      end
    end
  end
end
