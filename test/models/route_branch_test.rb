require 'test_helper'

class RouteBranchTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
#
# Table name: route_branches
#
#  id                    :integer          not null, primary key
#  route_id              :integer
#  branch_id             :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  position              :integer
#  quantity              :float
#  is_transferred        :boolean          default(FALSE)
#  transfer_to           :integer
#  is_deleted            :boolean          default(FALSE)
#  image                 :string
#  price                 :float
#  factory_image         :string
#  is_factory            :boolean          default(FALSE)
#  factory_collection_id :integer
#  comment               :text
#  collected_date        :date
#
