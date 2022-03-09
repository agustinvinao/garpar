require 'test_helper'
require Rails.root.join('lib/breadcrumb')

class BreadcrumbTest < ActiveSupport::TestCase
  test 'should create an instance' do
    breadcrumb = Breadcrumb.new
    assert_not_nil breadcrumb
  end

  test 'should add items' do
    breadcrumb = Breadcrumb.new
    breadcrumb.add('test', 'path/to-test')
    assert_equal(1, breadcrumb.items.size)
  end
end
