def formatCodeCommentPairs(code, comment)
  # No comment, skip to code
  if comment.length == 0
    return "NO COMMENT <code><pre>#{parseCode(code)}</pre></code>"
  else
    return "<div class='code-comment'>#{comment}</div><code><pre>#{parseCode(code)}</pre></code>"
  end
end

def parseCode(code)
  addStylesToCodeLines(processInlineComments(code))
end

def processInlineComments(code)
  code.gsub('<span class="o">[</span><span class="n">inline</span><span class="o">]</span>','')
end

def addStylesToCodeLines(code)
  styled_code = []

  code.split("\n").each do |codeline|
    @code = Nokogiri::HTML(codeline)
    if @code.css('span.c1').length == 0
      # If there are no comments found, just add the line as is
      styled_code << codeline
    else
      # There was an inline code, look for styles
      style_match = codeline.match(/\[(.*)\]/)

      styled_line = codeline.gsub(/ *<span class="c1">(.*?)<\/span> */,'')

      if style_match
        styles = style_match[1].split(",")
        styles.each do |style|
          if style == 'bold'
            styled_line = styled_line.gsub(
              /(<span class='one-line[\s\S]*?'>\s*)([\s\S]*?)(<\/span>$)/,
              '\1<strong>\2</strong>\3')
          elsif style == 'italic'
            styled_line = styled_line.gsub(
              /(<span class='one-line[\s\S]*?'>\s*)([\s\S]*?)(<\/span>$)/,
              '\1<em>\2</em>\3')
          else
            styled_line = styled_line.gsub(
              /(<span class='one-line[\s\S]*?'>\s*)([\s\S]*?)(<\/span>$)/,
              '\1<span class="' + style + '">\2</span>\3')
          end
        end

        styled_code << styled_line
      else
        # The inline comment has no style rules, pass it through.
        styled_code << codeline
      end
    end
  end
  styled_code.join("\n")
end