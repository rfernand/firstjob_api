module Firstjob
  class University
    UNIVERSITIES = YAML.load_file(File.join(File.dirname(__FILE__),"../data/universities.yaml"))["universities"].symbolize_keys!

    # Poor's man all
    def self.all
      UNIVERSITIES
    end

    # Poor's man find
    def self.find(id)
      UNIVERSITIES[id]
    end
  end
end
