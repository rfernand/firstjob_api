module Firstjob
  class LookingFor
    LOOKING_FORS = YAML.load_file("lib/data/looking_fors.yaml")["looking_fors"].symbolize_keys!

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
