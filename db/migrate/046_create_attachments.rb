class CreateAttachments < ActiveRecord::Migration
  def self.up
    create_table :attachments do |t|
      t.references :uploaded_file, :null => false
      t.references :attachable, :polymorphic => true, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :attachments
  end
end
