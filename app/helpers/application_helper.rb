module ApplicationHelper
	def avatar_url()
		gravatar_id = Digest::MD5::hexdigest(current_user.email).downcase
		"http://gravatar.com/avatar/#{gravatar_id}.png"
	end
end
