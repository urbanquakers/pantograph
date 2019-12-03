class String
  def pantograph_class
    split('_').collect!(&:capitalize).join
  end

  # def pantograph_module
  #   self == "pem" ? 'PEM' : self.pantograph_class
  # end

  def pantograph_underscore
    self.gsub(/::/, '/').
      gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2').
      gsub(/([a-z\d])([A-Z])/, '\1_\2').
      tr("-", "_").
      downcase
  end
end
