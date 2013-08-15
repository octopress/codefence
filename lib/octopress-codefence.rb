require 'octopress-codefence/version'
require 'octopress-pygments'
require 'jekyll'
require 'jekyll-page-hooks'

module Jekyll
  class Codefence < PageHooks
    def pre_render(page)
      page.content = Octopress::Codefence.render(page.content, page.ext)
    end
  end
end

module Octopress
  class Codefence
    AllOptions = /([^\s]+)\s+(.+?)\s+(https?:\/\/\S+|\/\S+)\s*(.+)?/i
    LangCaption = /([^\s]+)\s*(.+)?/i

    def initialize(input, ext=nil)
      @input   = input
      @ext     = ext
    end
    
    def render
      @input.encode!("UTF-8")
      @input.gsub /^`{3}(.+?)`{3}/m do
        str = $1.to_s
        str.gsub /([^\n]+)?\n(.+?)\Z/m do
          markup = $1 || ''
          code = $2.to_s
          begin
            get_code(code, get_options(markup))
          rescue MentosError => e
            markup = "```#{markup}"
            Pygments.highlight_failed(e, "```[language] [title] [url] [link text] [linenos:false] [start:#] [mark:#,#-#]\ncode\n```", markup, code)
          end
        end
      end
    end

    def get_options(markup)
      defaults = {}
      clean_markup = Pygments.clean_markup(markup)

      if clean_markup =~ AllOptions
        defaults = {
          lang: $1,
          title: $2,
          url: $3,
          link_text: $4,
        }
      elsif clean_markup =~ LangCaption
        defaults = {
          lang: $1,
          title: $2
        }
      end
      Pygments.parse_markup(markup, defaults)
    end


    def get_code(code, options)
      code = Pygments.highlight(code, options)
      code = "<notextile>#{code}</notextile>" if !@ext.nil? and @ext.match(/textile/)
      code
    end
  end
end

