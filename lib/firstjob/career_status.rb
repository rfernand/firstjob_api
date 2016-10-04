module Firstjob
  class CareerStatus
    CAREER_STATUSES = YAML.load_file("lib/data/career_statuses.yaml")["career_statuses"].symbolize_keys!

    # Poor's man all
    def self.all
      CAREER_STATUSES
    end

    # Poor's man find
    def self.find(id)
      CAREER_STATUSES[id]
    end
  end
end
