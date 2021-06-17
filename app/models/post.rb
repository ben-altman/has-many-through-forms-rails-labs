class Post < ActiveRecord::Base
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :comments
  has_many :users, through: :comments

  # conventional association writer: calls post.categories_attributes=
  # accepts_nested_attributes_for :categories

  # custom associaton writer:  
  def categories_attributes=(category_attributes) # category_attributes is a hash, not an array
    category_attributes.values.each do |category_attribute|
      if category_attribute[:name].present?
        category = Category.find_or_create_by(category_attribute)
        if !self.categories.include?(category)
          self.post_categories.build(:category => category)
        end
      end
    end
  end
end

# def categories_attributes=(category_attributes)
#   category_attributes.values.each do |category_attribute|
#     category = Category.find_or_create_by(category_attribute)
#     self.post_categories.build(category: category)
#   end
# end