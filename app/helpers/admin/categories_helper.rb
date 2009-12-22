module Admin::CategoriesHelper
  
  # slugify takes the content of params[:event_type] and strips out all the special characters to make a web friendly slug
  def slugify(urlstring)
    urlstring = urlstring.downcase.strip
    urlstring = urlstring.gsub(/\([A-Za-z0-9\.\s]*\)/, "")
    urlstring = urlstring.gsub(/[^A-Za-z0-9\s]/, "").strip
    urlstring = urlstring.gsub(/\s+/, "-")

    return urlstring
  end

  # titleify strips out the ()'s, lowercases all word characters, and then formats the title in proper english via the titleize gem
  def titleify(urlstring)
    urlstring = urlstring.downcase.strip
    urlstring = urlstring.gsub(/\([A-Za-z0-9\.\s]*\)/, "")
    urlstring = urlstring.gsub(/[-]+/, " ")
    urlstring = urlstring.gsub(/\s+/, " ")
    urlstring = urlstring.titleize

    return urlstring
  end
end
