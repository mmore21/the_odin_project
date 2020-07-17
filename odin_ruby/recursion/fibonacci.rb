def fibs(n)
  count, n1, n2 = 0, 0, 1
  until count == n
    n1 += n2 if count.even?
    n2 += n1 if count.odd?
    count += 1
  end
  return n1 if count.even?
  return n2 if count.odd?
end

def fibs_rec(n)
  return 0 if n == 0
  return 1 if n == 1
  fibs_rec(n-1) + fibs_rec(n-2)
end
