class User
  include Mongoid::Document
  include Mongoid::Timestamps

  # Defining roles
  ROLES = %w(regular admin)

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, :confirmable, :lockable,
         :recoverable, :rememberable, :trackable, :validatable

  ## Database authenticatable
  field :email,              :type => String, :null => false, :default => ""
  field :encrypted_password, :type => String, :null => false, :default => ""

  ## Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String

  ## Encryptable
  # field :password_salt, :type => String

  ## Confirmable
  field :confirmation_token,   :type => String
  field :confirmed_at,         :type => Time
  field :confirmation_sent_at, :type => Time
  field :unconfirmed_email,    :type => String # Only if using reconfirmable

  ## Lockable
  field :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
  field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
  field :locked_at,       :type => Time

  ## Token authenticatable
  # field :authentication_token, :type => String

  ## Invitable
  field :invitation_token
  field :invitation_sent_at, type: Time
  field :invitation_accepted_at, type: Time
  field :invitation_limit, type: Integer 

  index :invitation_token

  field :name
  field :role, default: 'regular'
  field :username

  validates_presence_of :name, :email, :username
  validates_uniqueness_of :name, :email, :username, :case_sensitive => false
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :username

  has_many :places
  has_many :invitations, class_name: 'User', as:  :invited_by
 
  #defining roles 
  def admin?
    role == "admin"
  end

  def regular?
    role == "regular"
  end
  
end

