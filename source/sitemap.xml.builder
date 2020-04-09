xml.instruct!
xml.urlset 'xmlns' => "http://www.sitemaps.org/schemas/sitemap/0.9" do
  sitemap.resources.select { |page| page.path =~ /\.html/ }.each do |page|

    # Clean page paths for no extension, clean URLs
    # There is no index.html page
    page_path = page.path.split('.')[0]
    if page_path == 'index'
      page_path = ''
    end

    xml.url do
      xml.loc "#{data.sitemap.url}#{page_path}"
      xml.lastmod Date.today.to_time.iso8601
      xml.changefreq page.data.changefreq || "monthly"
      xml.priority page.data.priority || "0.5"
    end
  end
end
