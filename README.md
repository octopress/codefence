# Octopress Codefence

Write beautiful fenced code snippets within any template.

[![Gem Version](https://badge.fury.io/rb/octopress-codefence.svg)](http://badge.fury.io/rb/octopress-codefence)
[![Build Status](https://travis-ci.org/octopress/codefence.svg?branch=master)](https://travis-ci.org/octopress/codefence)

## Installation

### Using Bundler

Add this gem to your site's Gemfile in the `:jekyll_plugins` group:

    group :jekyll_plugins do
      gem 'octopress-codefence'
    end

Then install the gem with Bundler

    $ bundle

### Manual Installation

    $ gem install octopress-codefence

Then add the gem to your Jekyll configuration.

    gems:
      - octopress-codefence

## Usage

The Octopress codefence has some

### Syntax

    ```lang [options]
    [code]
    ```

### Options

Note that order does not matter.

| Options      | Example                | Description                                                           |
|:-------------|:-----------------------|:----------------------------------------------------------------------|
|`lang`        | `ruby`                 | Used by the syntax highlighter. Passing 'plain' disables highlighting.|
|`title`       | `title:"Figure 1.A"`   | Add a figcaption title to your code block. |
|`link_text`   | `link_text:"Download"` | Text for the link, default: `"link"`. |
|`linenos`     | `linenos:false`        | Disable line numbering. |
|`start`       | `start:5`              | Start the line numbering at the given value. |
|`mark`        | `mark:1-4,8`           | Highlight lines of code. This example marks lines 1,2,3,4 and 8 |
|`class`       | `class:"css example"`  | Add CSS class names to the code `<figure>` element |

### Examples

Finally, give it a try. Here's an code snippet sample.

    ```ruby mark:2-4 title:"Testing codefence" url:"https://github.com/octopress/codefence" link_text:"plugin link"
    class Float
      def number_decimal_places
        self.to_s.length-2
      end
      
      def to_fraction
        higher = 10**self.number_decimal_places
        lower = self*higher

        gcden = greatest_common_divisor(higher, lower)

        return (lower/gcden).round, (higher/gcden).round
      end
      
    private

      def greatest_common_divisor(a, b)
         while a%b != 0
           a,b = b.round,(a%b).round
         end 
         return b
      end
    end
    ```

Which renders like this:

<!-- mark:2-4 title:"Testing codefence" url:"https://github.com/octopress/codefence" link_text:"plugin link" -->
```ruby
class Float
  def number_decimal_places
    self.to_s.length-2
  end
  
  def to_fraction
    higher = 10**self.number_decimal_places
    lower = self*higher

    gcden = greatest_common_divisor(higher, lower)

    return (lower/gcden).round, (higher/gcden).round
  end
  
private

  def greatest_common_divisor(a, b)
     while a%b != 0
       a,b = b.round,(a%b).round
     end 
     return b
  end
end
```
Here's a themed sample:

Note: This plugin does not come with stylesheets. Check out [octopress solarized](https://github.com/octopress/solarized) for styling code
snippets.

<img src="http://cl.ly/TFCm/content.svg" alt='sample screenshot of the code snippet above renderd with the light theme' width="816px">

Here's a look at the dark theme:

<img src="http://cl.ly/TFPX/content.svg" alt='sample screenshot of the code snippet above renderd with the dark theme' width="816px">

More documentation coming soon.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
