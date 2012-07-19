require 'test_helper'

class StoreControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_response :success
    assert_select '#columns #side a', :minimum => 4
    assert_select '#main .entry' , 3
    assert_select 'h3', 'Programming Ruby 1.9'
    assert_select '.price' , /\$[,\d]+\.\d\d/
  end
  
  
  test "product is not valid without a unique title" do
  product =Product.new(:title => products(:ruby).title,
                       :description =>"yyy",
                       :price => 1,
                       :image_url => "fred.gif")
                       
  assert !product.save
  assert_equal "has already been taken", product.errors[:title].join(';')
  end
  
  
  test "product is not valid without a unique title - i18n" do
    product =Product.new(:title => products(:ruby).title,
                       :description =>"yyy",
                       :price => 1,
                       :image_url => "fred.gif")

   
  assert !product.save
  assert_equal  I18n.translate('activerecord.errors.messages.taken'), 
                product.errors[:title].join(';')
  
  
  end
end
