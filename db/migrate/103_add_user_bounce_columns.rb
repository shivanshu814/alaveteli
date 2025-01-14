require 'digest/sha1'

class AddUserBounceColumns < ActiveRecord::Migration[4.2] # 2.3
  def self.up
    add_column :users, :email_bounced_at, :datetime
    add_column :users, :email_bounce_message, :text, default: "", null: false
  end
  def self.down
    remove_column :users, :email_bounced_at
    remove_column :users, :email_bounce_message
  end
end
