def merge(a, b, c=[])
  i = 0
  j = 0
  while (i <= (a.length - 1) && j <= (b.length - 1))
    if (a[i] < b[j])
      c << a[i]
      i += 1
      puts "a => c #{a}, #{c}"
    elsif (a[i] > b[j])
      c << b[j]
      j += 1
    end
  end
  puts "#{a}, #{b}, #{c}"
  c.concat(a[i..]) if i <= a.length - 1 
  c.concat(b[j..]) if j <= b.length - 1
  c
end

def merge_sort(arr)
  l = 0
  h = arr.length - 1
  if l == h
    return arr
  end
  if l < h
    mid = (l + h) / 2
    merge(merge_sort(arr[l..mid]), merge_sort(arr[mid+1..h]))
  end
end

p merge_sort([1,4,73,8,0,33])