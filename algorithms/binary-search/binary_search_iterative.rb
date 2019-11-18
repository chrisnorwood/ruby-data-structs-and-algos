# a is sorted array
# returns -1, if match not found
# Complexity:
#    Time: O(log n)
#   Space: O(1)
def binary_search(a, key)
  low = 0
  high = a.length - 1

  while low <= high
    mid = low + ((high - low) / 2)

    return mid if a[mid] == key

    if key < a[mid]
      high = mid - 1
    else
      low = mid + 1
    end
  end

  return -1
end