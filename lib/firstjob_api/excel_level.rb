module FirstjobApi
  class ExcelLevel
    EXCEL_LEVELS = YAML.load_file(File.join(File.dirname(__FILE__),"../data/excel_levels.yaml"))["excel_levels"].symbolize_keys!

    # Poor's man all
    def self.all
      EXCEL_LEVELS
    end

    # Poor's man find
    def self.find(id)
      EXCEL_LEVELS[id]
    end
  end
end
