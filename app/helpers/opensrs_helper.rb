module OpensrsHelper
  def bool_to_i(bool)
    return nil if bool.class != TrueClass && bool.class != FalseClass
    bool ? 1 : 0
  end
end
