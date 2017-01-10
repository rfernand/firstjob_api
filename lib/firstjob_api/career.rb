module Firstjob
  class Career
    CAREERS = YAML.load_file(File.join(File.dirname(__FILE__),"../data/careers.yaml"))["careers"].symbolize_keys!

    # Poor's man all
    def self.all
      CAREERS
    end

    # Poor's man find
    def self.find(id)
      CAREERS[id]
    end
  end
end
