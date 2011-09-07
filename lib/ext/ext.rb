class Array
  def sorted?(order = :growing)
    (size-2).times{ |i| return false if self[i] > self[i+1] }
    true
  end

  def push_uniq e
    if include? e
      index e
    else
      push e
      size-1
    end
  end
end
