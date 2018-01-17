class AddAttachmentLogoToCompanyAdmins < ActiveRecord::Migration[5.1]
  def self.up
    change_table :company_admins do |t|
      t.attachment :logo
    end
  end

  def self.down
    remove_attachment :company_admins, :logo
  end
end
