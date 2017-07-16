module ApplicationHelper

	# Returns the full-title on per page basis
	def full_title(page_title = '')
		base_title = "Expense Analytics"
		if page_title.empty?
			base_title
		else
			"#{page_title} | #{base_title}"
		end
	end

	# will_paginate gem setup.
	# def pagination_links(collection, options={})
	# 	options[:renderer] ||= BootstrapPaginationHelper::LinkRenderer
	# 	options[:class] ||= 'pagination pagination-centered'
	# 	options[:inner_window] ||= 2
	# 	options[:outer_window] ||= 1
	# 	will_paginate(collection, options)
	# end

end
