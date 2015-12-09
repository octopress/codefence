require 'octopress-codefence/version'
require 'octopress-code-highlighter'

module Octopress
  module Codefence
    Jekyll::Hooks.register [:posts, :pages, :documents], :pre_render do |item, payload|
      if item.respond_to?(:ext)
        ext = item.ext
      else
        ext = nil
      end
      item.content = Codefence::Highlighter.new(item.content, ext, item.site.config['code_aliases']).render
    end

    class Highlighter
      AllOptions = /([^\s]+)\s+(.+?)\s+(https?:\/\/\S+|\/\S+)\s*(.+)?/i
      LangCaption = /([^\s]+)\s*(.+)?/i

      def initialize(input, ext=nil, aliases=nil)
        @input   = input
        @ext     = ext
        @aliases = aliases
      end
      
      def render
        @input.encode!("UTF-8")
        @input = sub_option_comment(@input)

        # Match code bwteen backticks
        #
        @input.gsub /^`{3}(.+?)`{3}/m do
          str = $1.to_s

          # separate code from arguments after backticks
          #
          str.gsub /([^\n]+)?\n(.+?)\Z/m do
            markup = $1 || ''
            code = $2.to_s
            begin
              get_code(code, get_options(markup))
            rescue => e
              markup = "```#{markup}"
              CodeHighlighter.highlight_failed(e, "```[language] [title] [url] [link text] [linenos:false] [start:#] [mark:#,#-#]\ncode\n```", markup, code)
            end
          end
        end
      end

      # Allow html comments to set rendering options
      #
      #  Example:
      #   <!-- title:"Example 1" -->
      #   ```ruby
      #
      #  This becomes:
      #
      #   ```ruby title:"Example 1"
      #
      # This allows Readme files to be rendered by GitHub and other markdown codefences
      # But when processed by Octopress Codefence, the code examples are rendered with options
      #
      def sub_option_comment(input)
        input.gsub /<!--(.+?)-->\n`{3}([^\n]+)/ do
          "```#{$2} #{$1}"
        end
      end

      def get_options(markup)
        defaults = { escape: true }
        clean_markup = CodeHighlighter.clean_markup(markup)

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
        CodeHighlighter.parse_markup(markup, defaults)
      end


      def get_code(code, options)
        options[:aliases] = @aliases || {}
        code = CodeHighlighter.highlight(code, options)
        code = "<notextile>#{code}</notextile>" if !@ext.nil? and @ext.match(/textile/)
        code
      end
    end
  end
end

if defined? Octopress::Docs
  Octopress::Docs.add({
    name:        "Octopress Codefence",
    gem:         "octopress-codefence",
    version:     Octopress::Codefence::VERSION,
    description: "Write beatuiful code snippets, with backtick code fences",
    path:        File.expand_path(File.join(File.dirname(__FILE__), "../")),
    source_url:  "https://github.com/octopress/codefence",
  })
end
