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

  def show_private_tab
    current_user && (current_user.admin? ||  # if current_user is an admin
    current_user.premium? ||                 # current_user is a premium
    current_user.wiki_collaborations.any?)   # current_user has any private wiki collaborations
  end

  def show_private_wiki_check_box
    (!@wiki.id && current_user.premium?) ||  # if creating a new wiki and user is either premium or admin
    (@wiki.id && (current_user.premium? && @wiki.user == current_user)) ||   # updating a wiki and current_user is a premium and is the wiki owner 
    current_user.admin? # or user is an admin
  end

  def manage_wiki_collaborations?
    @wiki.private && (current_user == @wiki.user || current_user.admin?) 
  end 

end


