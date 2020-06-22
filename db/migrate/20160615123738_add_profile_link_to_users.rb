class AddProfileLinkToUsers < ActiveRecord::Migration
  def change
    add_column :users, :facebook_profile_link, :string
    add_column :users, :linkedin_profile_link, :string
  end
end
