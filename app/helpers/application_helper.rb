module ApplicationHelper

	def flash_class(key)
    case key
      when "success" then "success" # green
      when "info" then "info"       # blue
      when "notice" then "info"     # blue
      when "warning" then "warning" # yellow
      when "alert" then "warning"   # yellow
      when "danger" then "danger"   # red
      when "error" then "danger"    # red
    end
  end

  def markdown_to_html(markdown)
    renderer = Redcarpet::Render::HTML.new(hard_wrap: true, prettify: true)
    extensions = {fenced_code_blocks: true}
    redcarpet = Redcarpet::Markdown.new(renderer, extensions)
    (redcarpet.render markdown).html_safe
  end 

  # def markdown_to_html(wiki)
  #   raw Markdown.new(wiki).to_html  # test only (OK)
  # end

end
