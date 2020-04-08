class User < ApplicationRecord
  has_flags :visible, :hidden

  def flag_has_changed(key, value)
  end
end
