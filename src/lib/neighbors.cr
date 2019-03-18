require "uri"
require "http/client"
require "json"

module Iri::Mon
  class Neighbors
    getter config : Config
    def initialize(config)
      @config = config
    end

    def display
      headers = HTTP::Headers{"Content-Type" => "application/json",
                              "X-IOTA-API-Version" => "1"}

      print "IRI Monitor - Neighbors\n"
      print "--" * 20
      print "\n"

      begin
        response = HTTP::Client.post("http://localhost:" + @config.parsed_config["port"].to_s, headers, { "command" => "getNodeInfo" }.to_json)
        data = JSON.parse(response.body)

        item("Configured neighbors", @config.parsed_config["neighbors"].as(Array(String)).size.to_s)
        item("Connected neighbors", data["neighbors"].to_s)

        response = HTTP::Client.post("http://localhost:" + @config.parsed_config["port"].to_s, headers, { "command" => "getNeighbors" }.to_json)
        data = JSON.parse(response.body)

        print "\n"

        return unless data["neighbors"]
        data["neighbors"].as_a.each do |neighbor|
          print "[" + neighbor["connectionType"].to_s + "] - " + neighbor["address"].to_s + "\n"
          print "State: " + find_state(neighbor)
          print "Transactions: [all: " + neighbor["numberOfAllTransactions"].to_s + ", "
          print "new: " + neighbor["numberOfNewTransactions"].to_s + ", "
          print "invalid: " + neighbor["numberOfInvalidTransactions"].to_s + ", "
          print "stale: " + neighbor["numberOfStaleTransactions"].to_s + ", "
          print "random requests: " + neighbor["numberOfRandomTransactionRequests"].to_s + ", "
          print "send: " + neighbor["numberOfSentTransactions"].to_s + "]\n\n"
        end

      rescue e : Exception
        item("Running", false)
      end
    end

    def find_state(neighbor)
      if (neighbor["numberOfNewTransactions"].to_s.to_i32 +
          neighbor["numberOfInvalidTransactions"].to_s.to_i32 +
          neighbor["numberOfAllTransactions"].to_s.to_i32 +
          neighbor["numberOfRandomTransactionRequests"].to_s.to_i32) == 0
          "\033[91minactive\033[0m"
      else
        "\033[92mactive\033[0m"
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
