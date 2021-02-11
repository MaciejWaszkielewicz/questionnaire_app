class DateAnswer < Answer
  def value=(val)
    # additional to_date to avoid store additional information (val will be also passed as string)
    self.value_serialized = val&.to_date&.to_s
  end

  def value
    self.value_serialized&.to_date
  end
end
