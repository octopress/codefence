require 'octopress-codefence'

str = <<-EOF

whatver

``` ruby
puts awesome unless lame
```

something

EOF

puts Octopress::Codefence.new(str).render
