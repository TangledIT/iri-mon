require "uri"
require "http/client"
require "json"

module Iri::Mon
  class Milestones
    getter config : Config
    def initialize(config)
      @config = config
    end

    def display
      headers = HTTP::Headers{"Content-Type" => "application/json",
                              "X-IOTA-API-Version" => "1"}

      print "IRI Monitor - Milestones\n"
      print "--" * 20
      print "\n"

      begin
        response = HTTP::Client.post("http://localhost:" + @config.parsed_config["port"].to_s, headers, { "command" => "getNodeInfo" }.to_json)
        data = JSON.parse(response.body)

        item("Start Index", data["milestoneStartIndex"].to_s)
        item("Latest Index", data["latestMilestoneIndex"].to_s)
        item("Latest Solid Subtangle Index", data["latestSolidSubtangleMilestoneIndex"].to_s)
        print "\n"
        item("Latest Milestone", data["latestMilestone"].to_s)
        item("Latest Solid Subtangle Milestone", data["latestSolidSubtangleMilestone"].to_s)
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
