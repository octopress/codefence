require 'colorator'

`rm -rf site; bundle exec jekyll build --trace`

diff = `diff expected.html site/test.html`

if diff.size == 0 and File.exist?('site/test.html')
  puts "passed".green
else
  puts "failed".red
  puts diff
  abort
end
