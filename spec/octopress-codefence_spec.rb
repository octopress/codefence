require 'spec_helper'

describe Octopress::Codefence do
  let(:render) { Proc.new { |str| Octopress::Codefence.new(str).render } }
  context "when converting a code block with surrounding text" do
    let(:content) do
      str = <<-EOF

whatever

``` ruby
puts awesome unless lame
```

something

EOF
    end

    it "converts the code fence" do
      expect(render.call(content)).to include("<figure class='code'><div class='highlight'><table><tr><td class='line-numbers' aria-hidden='true'><pre><div data-line='0' class='line-number'></div></pre></td><td class='main  plain'><pre><div class='line'>puts awesome unless lame</div></pre></td></tr></table></div></figure>")
    end

    it "doesn't touch the other text" do
      expect(render.call(content)).to include("\nwhatever\n\n")
      expect(render.call(content)).to include("\n\n\nsomething\n\n")
    end
  end

end
