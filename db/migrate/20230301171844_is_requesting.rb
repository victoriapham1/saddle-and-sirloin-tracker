

class IsRequesting < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :isRequesting, :boolean, default: true
  end
end
