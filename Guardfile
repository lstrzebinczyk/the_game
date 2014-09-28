# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'rake', :task => 'build' do
  watch %r{^lib/.+\.rb$}
end

guard "rake", task: :build_coffee do
  watch %r{^assets/.+\.js.coffee$}
end
