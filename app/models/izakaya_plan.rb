class IzakayaPlan < ApplicationRecord
  include RankedModel

  belongs_to :izakaya
  belongs_to :plan

  ranks :row_order, with_same: :plan_id
end
