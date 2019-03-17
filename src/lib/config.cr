require "ini"

module Iri::Mon
  class Config
    property parsed_config = {} of String => String | Int32 | Bool | Array(String)

    def initialize(config_location = nil)
      ini = INI.parse(locate_config(config_location).to_s)
      config = ini["IRI"]? ? ini["IRI"] : ini

      @parsed_config["port"] =  config["ZMQ_PORT"]? ? config["PORT"].to_s.to_i32 : 14562
      @parsed_config["udp_receiver_port"] = config["UDP_RECEIVER_PORT"].to_s.to_i32
      @parsed_config["tcp_receiver_port"] = config["TCP_RECEIVER_PORT"].to_s.to_i32
      @parsed_config["zmq_port"] = config["ZMQ_PORT"]? ? config["ZMQ_PORT"].to_s.to_i32 : 5556
      @parsed_config["zmq_enabled"] = config["ZMQ_ENABLED"].to_s == "true"
      @parsed_config["debug"] = config["DEBUG"].to_s == "true"
      @parsed_config["testnet"] = config["TESTNET"].to_s == "true"
      @parsed_config["neighbors"] = config["NEIGHBORS"].to_s.tr("\"", "").split(",")
      @parsed_config["remote_limit_api"] = config["REMOTE_LIMIT_API"].to_s.tr("\"", "").split(",").map(&.strip)
      @parsed_config
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
