module FirstjobApi
  class EnglishLevel
    ENGLISH_LEVELS = YAML.load_file(File.join(File.dirname(__FILE__),"../data/english_levels.yaml"))["english_levels"].symbolize_keys!

    # Poor's man all
    def self.all
      ENGLISH_LEVELS
    end

    # Poor's man find
    def self.find(id)
      ENGLISH_LEVELS[id]
    end
  end
end
