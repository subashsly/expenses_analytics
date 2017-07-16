module MembersHelper

	# Returns the gravatar for the given user.
	def gravatar_for(member, options = { size: 50 })
		gravatar_id = Digest::MD5::hexdigest(current_member.member_email.downcase)
		gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
		image_tag(gravatar_url, alt: current_member.member_name, class: "gravatar img-circle")
	end

end