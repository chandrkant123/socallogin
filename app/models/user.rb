class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
 devise :omniauthable
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,:provider,:uid,:name,:url,:description,:params
  # attr_accessible :title, :body

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    if user
      return user
    else
      registered_user = User.where(:email => auth.info.email).first
      if registered_user
        registered_user.update_attributes(
                            :name=>auth.info.first_name,
                            :provider=>auth.provider,
                            :uid=>auth.uid,
                            :email=>auth.info.email,
                            :url =>auth.info.image,
                            :description=>auth.info.description,
                            :params=>auth,
                            :password=>Devise.friendly_token[0,20],

          )
        return registered_user
      else
      	puts "============================================"
      	puts "=================#{auth.inspect}============"
        puts "=================#{auth.info.inspect}============"
      	puts "============================================"
        user = User.create(name:auth.extra.raw_info.name,
                            provider:auth.provider,
                            uid:auth.uid,
                            email:auth.info.email,
                            url: auth.info.image,
                            description:auth.info.description,
                            params:auth,
                            password:Devise.friendly_token[0,20],
                          )
      end    end
  end
def self.find_for_twitter_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    if user
      return user
    else
      registered_user = User.where(:email => auth.uid + "@twitter.com").first
      if registered_user
        registered_user.update_attributes(:name=>auth.extra.raw_info.name,
                            :provider=>auth.provider,
                            :uid=>auth.uid,
                            :url=>auth.info.image,
                            :description=>auth.info.description,
                            :params=>auth,
                            :email=>auth.uid+"@twitter.com",
                            :password=>Devise.friendly_token[0,20],
                          )
        return registered_user
      else
        puts "============================================"
        puts "=================#{auth.inspect}============"
        puts "====================================================="
        puts "=================#{auth.info.inspect}============"
        puts "====================================================="
        puts "=====================#{auth.extra.raw_info}======================="
        user = User.create(name:auth.extra.raw_info.name,
                            provider:auth.provider,
                            uid:auth.uid,
                            url:auth.info.image,
                            email:auth.uid+"@twitter.com",
                            params:auth,
                            description:auth.info.description,
                            password:Devise.friendly_token[0,20],
                          )
      end

    end
  end
  def self.connect_to_linkedin(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    if user
      return user
      puts "======================#{user?}======================"
    else
      registered_user = User.where(:email => auth.info.email).first
      if registered_user
        registered_user.update_attributes(
                            :name=>auth.info.first_name,
                            :provider=>auth.provider,
                            :uid=>auth.uid,
                            :email=>auth.info.email,
                            :description=>auth.info.description,
                            :params=>auth,
                            :url =>auth.info.image,
                            :password=>Devise.friendly_token[0,20],

          )
        return registered_user
      else
        
        user = User.create(name:auth.info.first_name,
                            provider:auth.provider,
                            uid:auth.uid,
                            email:auth.info.email,
                            url: auth.info.image,
                            params:auth,
                            description:auth.info.description,
                            password:Devise.friendly_token[0,20],
                          )

        
      end

    end
  end

def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.where(:provider => access_token.provider, :uid => access_token.uid ).first
    if user
      user.update_attributes(
                            :name=>data["name"],
                            :provider=>access_token.provider,
                            :uid=>access_token.uid,
                            :email=>data["email"],
                            #:description=>auth.info.description,
                            #:params=>auth,
                            :url =>data["image"],
                            :password=>Devise.friendly_token[0,20],

          )
      return user
    else
      registered_user = User.where(:email => access_token.info.email).first
      if registered_user
        return registered_user
      else
        puts "======================================================="
        puts "==========================#{data.inspect}============================="
        puts "=============================#{access_token.inspect}=========================="
        user = User.create(name: data["name"],
          provider:access_token.provider,
          email: data["email"],
          uid: access_token.uid ,
          url: data["image"],
          #params:auth,
          password: Devise.friendly_token[0,20],
        )
      end
   end
end

end
