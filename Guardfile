guard :bundler do
  watch('Gemfile')
  watch('Gemfile.lock')
  watch(%r{^.+\.gemspec})
end

guard :cane do
  watch(%r{^lib/(.+)\.rb$})
end

guard :rspec, cli: '--color --drb --format Fuubar' do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})     { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')  { 'spec' }
end

guard :spork do
  watch('Gemfile')
  watch('Gemfile.lock')
  watch('spec/spec_helper.rb')  { :rspec }
end

guard :yard do
  watch(%r{lib/.+\.rb})
end
