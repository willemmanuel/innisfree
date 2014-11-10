module ApplicationHelper
	def map_link(address)
		"https://www.google.com/maps/preview?q="+address
	end
    
        def javascript(*files)
	  content_for(:head) { javascript_include_tag(*files) }
  	end
end
