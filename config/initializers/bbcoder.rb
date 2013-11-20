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

  tag :youtube, :match_content => /(?<=v=)[a-zA-Z0-9\-_]+(?=&)|(?<=[0-9]\/)[^&\n]+|(?<=v=)[^&\n]+/ do
    id = content.match(/(?<=v=)[a-zA-Z0-9\-_]+(?=&)|(?<=[0-9]\/)[^&\n]+|(?<=v=)[^&\n]+/)[0]
    %(<iframe class="youtube" width="560" height="315" src="//www.youtube.com/embed/#{id}?&rel=0&theme=light&showinfo=0&hd=1&autohide=1&color=white" frameborder="0" allowfullscreen="allowfullscreen"></iframe>)
  end

  tag :spoilers do
    %(<blockquote class="spoiler">#{content}</blockquote>)
  end

  tag :spoiler do
    %(<blockquote class="spoiler">#{content}</blockquote>)
  end
end
