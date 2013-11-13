BBCoder.configure do
  tag :code do
    if meta.nil? || meta.empty?
      %Q{<pre><code class="language-none">#{content}</code></pre>}
    else
      %(<pre><code class=\"language-#{meta.gsub(/"/, '')}\">#{content}</code></pre>)
    end
  end

  tag :link, :match_link => /^https?:\/\// do
    if meta.nil? || meta.empty?
      %(<a href="#{content}">#{content}</a>)
    else
      %(<a href="#{meta.gsub(/"/, '')}">#{content}</a>)
    end
  end
end
