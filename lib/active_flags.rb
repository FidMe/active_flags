require "active_flags/engine"

module ActiveFlags
  def included(klass)
    klass.class_eval do
      attr_accessor :flags
      has_many :active_flags_flags, class_name: 'ActiveFlags::Flag'
      before_save :set_flags
    end
  end


  def set_flags
    self.flags.each do |flag|

      # set_key_value(flag)

      ActiveFlags::Flag.find_or_initialize(subject: self, key: flag[:key]) do |flag_to_create|
        flag_to_create.update!(value: flag[:value])
      end
    end
  end

  # def set_key_value(flag)
  #   flag.keys.each do |k,v|
  #     flag[:key] = k
  #     flag[:value] = v
  #   end
  # end
end


# user.update(flags: [{ coucou: 'true' }])
# user.update(flags: [{ key: 'coucou', value: 'true' }])
