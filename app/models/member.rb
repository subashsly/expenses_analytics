class Member < ActiveRecord::Base
	has_many :incomes, dependent: :destroy
	has_many :contacts, dependent: :destroy
	has_many :expenses
	has_many :reminders
	has_many :categories
	attr_accessor :remember_token, :activation_token, :reset_token
	before_save :downcase_email
	before_create :create_activation_digest
	validates :member_name, presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :member_email, presence: true, length: { maximum: 255 },
														format: { with: VALID_EMAIL_REGEX },
														uniqueness: { case_sensitive: false }
	has_secure_password
	validates :password, length: { minimum: 6 }, allow_blank: true
	validates :accept, acceptance: { accept: 'yes' }
	validates :member_country, presence: true

	# Returns the hash digest of the given string.
	def Member.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :																							BCrypt::Engine.cost
		BCrypt::Password.create(string, cost: cost)
	end

	# Returns a Random Token.
	def Member.new_token
		SecureRandom.urlsafe_base64
	end

	# Remembers a user in the database for use in persistent sessions.
	def remember
		self.remember_token = Member.new_token
		update_attribute(:remember_digest, Member.digest(remember_token))
	end

	# Returns true if token matches  the digest.
	def authenticated?(attribute, token)
		digest = send("#{attribute}_digest")
		return false if digest.nil?
		BCrypt::Password.new(digest).is_password?(token)
	end

	# Forgets a user.
	def forget
		update_attribute(:remember_digest, nil)
	end

	# def country_name
	# 	country = ISO3166::Country[country_code]
	# 	country.translations[I18n.locale.to_s] || country.name
	# end

	# Activated an account.
	def activate
		update_attribute(:activated, true)
		update_attribute(:activated_at, Time.zone.now)
	end

	# Send activation email.
	def send_activation_email
		MemberMailer.account_activation(self).deliver_now
	end

	# Sets the password reset attributes.
	def create_reset_digest
		self.reset_token = Member.new_token
		update_attribute(:reset_digest, Member.digest(reset_token))
		update_attribute(:reset_sent_at, Time.zone.now)
	end

	# Sends password reset email.
	def send_password_reset_email
		MemberMailer.password_reset(self).deliver_now
	end

	# Returns true if a password reset has expired.
	def password_reset_expired?
		reset_sent_at < 2.hours.ago
	end

	private	

		# Converts email to all lower case.
		def downcase_email
			self.member_email = member_email.downcase
		end

		# Creates and assigns the activation token and digest.
		def create_activation_digest
			self.activation_token = Member.new_token
			self.activation_digest = Member.digest(activation_token)
		end
end