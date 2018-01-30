require 'test_helper'

class ProjectEmployeesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get project_employees_index_url
    assert_response :success
  end

  test "should get update" do
    get project_employees_update_url
    assert_response :success
  end

end
