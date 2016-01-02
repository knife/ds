module DS
  # Class represent list with cycle.
  class CyclicList < List
    # Returns cycle size. If list has no cycles returns 0.
    def cycle_size
      counter = 0
      if start = joint
        counter = 1
        elem = joint.next
        while elem != start
          elem = elem.next
          counter += 1
        end
      end
      counter
    end
  end
end
