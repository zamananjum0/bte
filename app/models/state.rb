class State < ApplicationRecord
  has_many :cities
  has_many :areas
end

# == Schema Information
#
# Table name: states
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  is_deleted :boolean          default(FALSE)
#
