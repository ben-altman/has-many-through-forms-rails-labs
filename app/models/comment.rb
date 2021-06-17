class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post

  accepts_nested_attributes_for :user, reject_if: proc { |attributes| attributes['username'].blank?}

  def user_attributes(user_attributes) # category_attributes is a hash, not an array
    user_attributes.values.each do |user_attribute|
      if user_attribute[:username].present?
        user = User.find_or_create_by(user_attribute)
        if !self.user = user
          self.build_user(:username => user[:username])
        end
      end
    end
  end
end
