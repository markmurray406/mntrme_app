module UsersHelper
	# See Listing 7.13
	# Returns the Gravatar (http://gravatar.com/) for the given user.
  def gravatar_for(user)
  	# Note: hexdigest method is case-sensitive therefore they must be downcased.
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end
end
