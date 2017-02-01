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

end
