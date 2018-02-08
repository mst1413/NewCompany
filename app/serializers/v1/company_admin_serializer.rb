class V1::CompanyAdminSerializer < ActiveModel::Serializer
  attributes :id , :companyname , :username , :email , :token , :logo_file_name, :logo_content_type, :logo_file_size, :logo_updated_at
end