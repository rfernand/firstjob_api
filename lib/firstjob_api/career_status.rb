module FirstjobApi
  class CareerStatus
    CAREER_STATUSES = YAML.load_file(File.join(File.dirname(__FILE__),"../data/career_statuses.yaml"))["career_statuses"].symbolize_keys!

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
