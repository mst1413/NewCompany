require 'test_helper'

class EmployeeProjectsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get employee_projects_index_url
    assert_response :success
  end

  test "should get update" do
    get employee_projects_update_url
    assert_response :success
  end

end
