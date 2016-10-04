# Firstjob

This gem was made to connect to the Firstjob api found in https://developers.firstjob.com 

## Getting started

Firstjob works with Rails 3.2 onwards. You can add it to your Gemfile with:

```ruby
gem 'firstjob'
```

...or can fetch the latest developer version with:

```ruby
gem 'firstjob', :git => 'git@github.com:rfernand/firstjob.git', :branch => 'master'
```
### Configuration

After you finished the gem installation, you need to configure it with your Firstjob user information. You can do it filling a file like config/initializers/firstjob.rb with:

```ruby
Firstjob.setup do |config|
  config.username   = ""          # Firstjob client username
  config.password   = ""          # Firstjob client password
  config.base_uri ""              # You need to provide the URL for the endpoint of the Firstjob API
end
```
## How to use


And more that don't need an ID. All return a json object, and raise an error (401, 404, 500) if there was one:
### Create and publish a new publication
```ruby
publication = Firstjob::Publication.new(title: "Publicacion de prueba", description: "Test", looking_for_id: 1, career_status_id: 1, excel_level_id: 2, english_level_id: 2, universities_ids: [1,2], careers_ids: [1, 6])
publication.publish()
```

### Get postulants of a publication

Work in progress...

### Development
You can start the gem in a standalone ruby console with:
```
$ rake console
```

And you can manually configure the gem in:
```
spec/firstjob_initializer_helper.rb
```
