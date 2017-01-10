module FirstjobApi
  class Publication
    attr_accessor :title, :description, :career_status_id,
      :looking_for_id, :location, :years_experience, :salary,
      :english_level_id, :excel_level_id, :careers_ids,
      :universities_ids, :id, :slug, :status, :postulantes
  
    def initialize(attributes={})
      # Default values
      @salary = 0
      @location = "Chile"
      @career_status_id = 1
      @years_experience = 0
      @english_level_id = 1
      @excel_level_id = 1

      attributes.each do |key, value|
        self.send("#{key}=", value)
      end
    end

    def body
      default_publication_json()
    end

    def self.create(params)
      publication = new(params)
      response = publication.publish()
    end

    def publish
      # Post publication
      response = FirstjobApi.post("/api/publish_job",
                               FirstjobApi.options.merge(
                                 body: FirstjobApi.body.merge({publish_job: self.body}).to_json
                                )
                              )
      response_body = HttpParser.parse_json_response(response)

      # load results
      @slug = response_body["slug"]
      @id = response_body["id"]
      @status = response_body["status"]
      return self
    end

    def url
      "#{FirstjobApi.base_uri}/jobs/#{slug}"
    end

    def postulants
      # Get postulants
      response = FirstjobApi.post("/api/get_applicants_job",
                               FirstjobApi.options.merge(
                                 body: FirstjobApi.body.merge({job_id: @id}).to_json
                                )
                              )
      response_body = HttpParser.parse_json_response(response)

      # load results
      @postulantes = response_body["postulantes"]
      return @postulantes
    end

    def destroy
      response = FirstjobApi.post("/api/doregister_job",
                               FirstjobApi.options.merge(
                                 body: FirstjobApi.body.merge({job_id: id}).to_json
                                )
                              )
      response_body = HttpParser.parse_response(response)
    end
  
    private
    def default_publication_json
      hash = {
        title:               title, # required
        description:         description, # required, max 300 caracters
        career_status:       career_status_id, # required
        looking_for:         looking_for_id, # required
        location:            location, # required
        years_experience:    years_experience, # required, number
        salary:              salary, # required, number. Can be 0
        english_level:       english_level_id, # required, number 
        excel_level:         excel_level_id, # required, number 
      }
      if careers_ids.present?
        hash[:careers] = careers_ids   # optional, array or NOT PRESENT
      end
      if universities_ids.present?
        hash[:universities] = universities_ids # optional, array or NOT PRESENT
      end
      return hash
    end
  
  end
end
