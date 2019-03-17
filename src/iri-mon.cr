require "clim"
require "./lib/*"

module Iri::Mon
  VERSION = "0.1.0"
end

Iri::Mon::Cli.start(ARGV)
