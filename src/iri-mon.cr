require "clim"
require "./lib/*"

module Iri::Mon
  VERSION = "0.1.1"
end

Iri::Mon::Cli.start(ARGV)
