def formatCodeCommentPairs(code, comment)
  # No comment, skip to code
  if comment.length == 0
    response = "<div class='code-comment-pair no-comment'>"
    response += "<code><pre>#{parseCode(code)}</pre></code>"
    response += "</div>"
    response
  else
    response = "<div class='code-comment-pair #{comment_type(comment)}'>"
    response += look_for_multiline(comment)
    response += "<code><pre>#{parseCode(code)}</pre></code>"
    if is_multiline(comment)
      response += "<div style='position:relative;clear:both;display:block;height:1px;width:100%;'></div>"
    end
    response += "</div>"
    response
  end
end

def comment_type(comment)
  if comment.match(/\[full\]/)
    "stretch"
  elsif comment.gsub(/\[end\]/,'').length == 0
    "no-comment"
  elsif comment.match(/\[offset-up\]/)
    "offset-up"
  elsif comment.match(/\[offset-down\]/)
    "offset-down"
  else
    ""
  end
end

def is_multiline(comment)
  comment.match(/\[full\]/)
end

def look_for_multiline(comment)
  clean_comment = comment
    .gsub(/\[\S*?\]/,'')

  stretch = comment.match(/\[full\]/) ? "stretch" : ""

  if clean_comment.length == 0
    ""
  else
    "<div class='code-comment #{stretch}'>#{clean_comment}</div>"
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
      style_match = codeline.match(/\/\/\[(.*)\]/)

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