class CreateProfilesProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :profiles_profiles do |t|
      t.references :this_profile
      t.references :other_profile

      t.timestamps
    end
  end
end
