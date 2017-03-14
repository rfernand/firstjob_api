require 'rails'
require 'time'
require 'httparty'
require 'erb'

require 'firstjob_api/university'
require 'firstjob_api/career'
require 'firstjob_api/career_status'
require 'firstjob_api/english_level'
require 'firstjob_api/excel_level'
require 'firstjob_api/looking_for'
require 'firstjob_api/university'
require 'firstjob_api/publication'
require 'firstjob_api/http_parser'

module FirstjobApi
  include HTTParty
  base_uri 'https://api.firstjob.me'

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
  

  # Default way to setup FirstjobApi.
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
    publication = FirstjobApi::Publication.create(params)
    return publication
  end

end

