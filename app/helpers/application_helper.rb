module ApplicationHelper
  def full_title(page_title = '')
    base_title = "Clothes App"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end
  
  
  def active_page(path_name)
    if  current_page?(path_name)
      return "active"
    end
  end
end
