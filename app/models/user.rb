class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable,:confirmable
  attr_accessor :login,:current_password
  validates_uniqueness_of :username,:on => :create
  validates_presence_of :username
  has_attached_file :avatar, :styles => { :medium => "165x165>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"#, :styles => { :medium => "300x300>", :thumb => "100x100>",:small => "23x23>" }, :default_url => "/images/:style/missing.png"
  #  validates_attachment :avatar, :presence => true
  has_many :authorizations,:dependent => :destroy
  has_many :videos,:dependent => :destroy
  has_many :followers, -> { where follow: true },:class_name => "Tweet",:foreign_key => :following_id
  has_many :followings, -> { where follow: true },:class_name => "Tweet",:foreign_key => :user_id
  def self.find_for_authentication(conditions)
    login = conditions.delete(:login)
    where(conditions).where(["username = :value OR email = :value", { :value => login }]).first
  end
end
