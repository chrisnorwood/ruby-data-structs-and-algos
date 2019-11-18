# a is sorted array
# returns -1, if match not found
# Complexity:
#    Time: O(log n)
#   Space: O(log n)
def binary_search_rec(a, key, low, high)
  return -1 if low > high
  
  mid = low + ((high - low) / 2)
  return mid if a[mid] == key

  if key < a[mid]
    binary_search_rec(a, key, low, mid - 1)
  else
    binary_search_rec(a, key, mid + 1, high)
  end
end

def binary_search(a, key)
  binary_search_rec(a, key, 0, a.length-1)
end