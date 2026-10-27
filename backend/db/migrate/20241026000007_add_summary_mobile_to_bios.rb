class AddSummaryMobileToBios < ActiveRecord::Migration[7.2]
  def change
    add_column :bios, :summary_mobile, :text
  end
end
