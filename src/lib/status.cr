require "uri"
require "http/client"
require "json"

module Iri::Mon
  class Status
    getter config : Config
    def initialize(config)
      @config = config
    end

    def display
      headers = HTTP::Headers{"Content-Type" => "application/json",
                              "X-IOTA-API-Version" => "1"}

      print "IRI Monitor - Status\n"
      print "--" * 20
      print "\n"

      begin
        response = HTTP::Client.post("http://localhost:" + @config.parsed_config["port"].to_s, headers, { "command" => "getNodeInfo" }.to_json)
        data = JSON.parse(response.body)

        item("Version", data["appVersion"])
        item("Running", true)

        if data["neighbors"].to_s.to_i32 > 0
          item("Synced", data["latestMilestoneIndex"] == data["latestSolidSubtangleMilestoneIndex"], false)
          print " [" + data["latestSolidSubtangleMilestoneIndex"].to_s + " / " + data["latestMilestoneIndex"].to_s  + "]\n"
        else
          item("Synced", false, false)
          print " (no neighbors?) \n"
        end
        print "\n"

        item("ZeroMQ", (@config.parsed_config["zmq_enabled"] ? "enabled" : "disabled"))
        item("Testnet", (@config.parsed_config["testnet"] ? "yes" : "no"))
        item("Debug", (@config.parsed_config["debug"] ? "yes" : "no"))
        print "\n"

        item("Tips", data["tips"].to_s)
        item("Transactons to request", data["transactionsToRequest"])
      rescue e : Exception
        item("Running", false)
      end
    end

    def item(key, value, linebreak = true)
      if value.is_a?(Bool)
        if value
          value = "\033[92mtrue\033[0m"
        else
          value = "\033[91mfalse\033[0m"
        end
      end
      print key.to_s + ": " + value.to_s
      print "\n" if linebreak
    end
  end
end
