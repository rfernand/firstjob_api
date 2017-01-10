module Firstjob
  class LookingFor
    LOOKING_FORS = YAML.load_file(File.join(File.dirname(__FILE__),"../data/looking_fors.yaml"))["looking_fors"].symbolize_keys!

    # Poor's man all
    def self.all
      LOOKING_FORS
    end

    # Poor's man find
    def self.find(id)
      LOOKING_FORS[id]
    end
  end
end
