# FirstjobApi

This gem was made to connect to the Firstjob api found in https://developers.firstjob.com 

## Getting started

FirstjobApi works with Rails 3.2 onwards. You can add it to your Gemfile with:

```ruby
gem 'firstjob'
```

...or can fetch the latest developer version with:

```ruby
gem 'firstjob', :git => 'git@github.com:rfernand/firstjob.git', :branch => 'master'
```
### Configuration

After you finished the gem installation, you need to configure it with your FirstjobApi user information. You can do it filling a file like config/initializers/firstjob.rb with:

```ruby
FirstjobApi.setup do |config|
  config.username   = ""          # FirstjobApi client username
  config.password   = ""          # FirstjobApi client password
  config.base_uri ""              # You need to provide the URL for the endpoint of the FirstjobApi API
end
```
## How to use


And more that don't need an ID. All return a json object, and raise an error (401, 404, 500) if there was one:
### Create and publish a publication
```ruby
publication = FirstjobApi::Publication.new(title: "Publicacion de prueba", description: "Test", looking_for_id: 1, career_status_id: 1, excel_level_id: 2, english_level_id: 2, universities_ids: [1,2], careers_ids: [1, 6])
publication.publish()
```
Returns FirstjobApi::Publication object with the publication.id and publication.slug issued by FirstjobApi.

### Get postulants of a publication
```ruby
publication = FirstjobApi::Publication.new
publication.id = 800 # ID of an existing publication
publication.postulants
```
Returns hash with postulants data. Example:
```ruby
=> [{"id"=>nil, "email"=>"postulant@gmail.com", "university_id"=>8,
"principal_career_id"=>1057, "career_status"=>3, "english_level"=>2,
"years_experience"=>1}, ...}]
```
### Unpublish a publication
```ruby
publication = FirstjobApi::Publication.new
publication.id = 800 # ID of an existing publication
publication.destroy
```
If succeded, returns the body of FirstjobApi response:
```ruby
 => "{\"mensaje\":\"Trabajo dado de baja\"}"
```

### Development & Testing
You can start the gem in a standalone ruby console with:
```
$ rake console
```

And you can manually configure the gem in:
```
spec/firstjob_initializer_helper.rb
```
