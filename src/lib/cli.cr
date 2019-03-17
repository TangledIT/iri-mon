module Iri::Mon
  class Cli < Clim
    main do
      desc "IRI Monitor"
      usage "iri-mon [arguments]"
      version "Version " + Iri::Mon::VERSION
      option "-c CONFIG_FILE", type: String, desc: "path to IRI config file.."
      run do |opts, _args|
        config = Config.new(opts.c)
        status = Status.new(config)
        status.display
        print "\n"
      end

      sub "ports" do
        desc "show ports"
        usage "iri-mon ports [arguments]"
        option "-c CONFIG_FILE", type: String, desc: "path to IRI config file.."
        run do |opts, _args|
          begin
            config = Config.new(opts.c)
            ports = Ports.new(config)
            ports.display
          rescue
            print "Unable to read IRI file"
          end
        end
      end

      sub "milestones" do
        desc "show milestones"
        usage "iri-mon milestones [arguments]"
        option "-c CONFIG_FILE", type: String, desc: "path to IRI config file.."
        run do |opts, _args|
          begin
            config = Config.new(opts.c)
            ports = Milestones.new(config)
            ports.display
          rescue
            print "Unable to read IRI file"
          end
        end
      end

      sub "neighbors" do
        desc "list neighbors"
        usage "iri-mon neighbors [arguments]"
        option "-c CONFIG_FILE", type: String, desc: "path to IRI config file.."
        run do |opts, _args|
          begin
            config = Config.new(opts.c)
            neighbors = Neighbors.new(config)
            neighbors.display
          rescue
            print "Unable to read IRI file"
          end
        end
      end
    end
  end
end
