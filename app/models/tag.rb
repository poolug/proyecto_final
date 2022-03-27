class Tag < ApplicationRecord
  has_many :transactions
  scope :all_tags, -> {where.not(id: nil)}

  def set_tag_name
    self.transactions
  end
  
end
