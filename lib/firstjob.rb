require 'rails'
require 'time'
require 'httparty'
require 'erb'

require 'firstjob/university'
require 'firstjob/career'
require 'firstjob/career_status'
require 'firstjob/english_level'
require 'firstjob/excel_level'
require 'firstjob/looking_for'
require 'firstjob/university'
require 'firstjob/publication'
require 'firstjob/http_parser'

module Firstjob
  include HTTParty
  base_uri 'https://api.firstjob.com'

  # API login configuration, need initialization setup to work
  mattr_accessor :grant_type
  @@grant_type = "password"

  mattr_accessor :client_id
  @@client_id = nil

  mattr_accessor :username
  @@username = nil

  mattr_accessor :email
  @@email    = nil

  mattr_accessor :password
  @@password    = nil

  mattr_accessor :access_token
  @@access_token = nil

  @@token_type= nil

  mattr_accessor :expires_in
  @@expires_in = nil

  mattr_accessor :access_token_updated_at
  @@access_token_updated_at = nil

  mattr_accessor :options
  @@options = nil

  mattr_accessor :body
  @@body = nil

  mattr_accessor :last_request
  mattr_accessor :last_response
  @@last_request = nil
  @@last_response = nil

  @@try_counter = 0
  

  # Default way to setup Firstjob.
  def self.setup
    yield self
    # It does not use basic http auth, it passes the username and password in the body of the request...
    #@@options = {headers: { "Accept" => "application/json", "Content-Type" => "application/json"}, basic_auth: {username: @@username, password: @@password}}
    @@options = {headers: { "Accept" => "application/json", "Content-Type" => "application/json"}}
    @@body = {username: @@username, password: @@password}
  end

  # Publicaciones
  # creates and publish a publication
  def self.publish(params)
    publication = Firstjob::Publication.create(params)
    return publication
  end

  def self.update_publication(publication_id, json)
    update_publication_path = "/v0/empresas/avisos/#{publication_id}"
    response = self.post(update_publication_path, @@options.merge(body: json, headers: { "Accept" => "application/json", "Content-Type" => "application/json"}))

    if HttpParser.parse_response(response)
      case response.code
        when 201
          # "Publication updated, All good!"
          return response # body contains id del proceso publicado
        when 200
          # "TODO: Uhm.. no idea, is this good?"
          return response # body contains id del proceso publicado?
      end
    end
  end

  def self.publish_publication(publication_id, pais_id, plan_publication_id)
    publish_publication_path = "/v0/empresas/avisos/#{publication_id}/publicacion/#{plan_publication_id}"
    response = self.put(publish_publication_path, @@options.merge(query: @@options[:query].merge({paisId: pais_id})))

    if HttpParser.parse_response(response)
      case response.code
        when 201
          # "Publication created, All good!"
          return response # body contains id del proceso publicado
        when 200
          # "TODO: Uhm.. no idea, is this good?"
          return response # body contains id del proceso publicado?
      end
    end
  end

  def self.get_publication_url(publication_id)
    "http://www.laborum.cl/empleos/#{publication_id}.html"
  end

  def self.get_publication(publication_id)
    get_publication_path = "/v0/empresas/avisos/#{publication_id}"
    response = self.get(get_publication_path, @@options)

    return HttpParser.parse_response_to_json(response)
  end

  def self.get_postulations_in_publication(publication_id, page=0, postulations_per_page=20)
    get_postulations_in_publication_path = "/v0/empresas/avisos/#{publication_id}/postulaciones"
    response = self.get(get_postulations_in_publication_path, @@options.merge(query: @@options[:query].merge({page: page, perPage: postulations_per_page})))

    return HttpParser.parse_response_to_json(response)
  end

  def self.get_postulation(postulation_id)
    get_postulation_path = "/v0/empresas/postulaciones/#{postulation_id}"
    response = self.get(get_postulation_path, @@options)

    return HttpParser.parse_response_to_json(response)
  end

  def self.destroy_publication(publication_id)
    destroy_publication_path = "/v0/empresas/avisos/#{publication_id}"
    response = self.delete(destroy_publication_path, @@options)

    return HttpParser.parse_response(response)
  end

end

