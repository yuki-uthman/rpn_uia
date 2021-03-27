guard :rspec, cmd: 'bundle exec rspec' do

  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^spec/(.+)/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})     { |m| "spec/rpn_uia" }
  watch('spec/spec_helper.rb')  { "spec" }
end
