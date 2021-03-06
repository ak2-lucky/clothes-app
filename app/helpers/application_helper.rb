module ApplicationHelper
  def full_title(page_title = '')
    base_title = "Choosing Clohtes For You"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def active_page(path_name)
    if current_page?(path_name)
      "active"
    end
  end
end
