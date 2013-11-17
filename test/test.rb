require 'colorator'

`rm -rf site; bundle exec jekyll build --trace`

diff = `diff expected.html site/index.html`

if diff.size == 0 and File.exist?('site/index.html')
  puts "passed".green
else
  puts "failed".red
  puts diff
  abort
end
