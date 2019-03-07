class User < ApplicationRecord
  has_flags :visible, :hidden
end