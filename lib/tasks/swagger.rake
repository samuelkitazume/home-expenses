namespace :swagger do
  desc "Generate Swagger JSON"
  task generate: :environment do
    require 'rspec/core'
    require 'rswag/specs'  # Ensure Rswag is loaded
    require 'stringio'

    if defined?(Rswag::Specs::SwaggerFormatter)
      output = StringIO.new
      Rswag::Specs::SwaggerFormatter.instance_variable_set(:@output, output)

      RSpec::Core::Runner.run(['spec/requests'], $stderr, $stdout)

      File.write('swagger/v1/swagger.json', output.string)
      puts "✅ Swagger documentation updated!"
    else
      puts "⚠️ Rswag::Specs::SwaggerFormatter is not loaded. Make sure rswag-specs is installed."
    end
  end
end