a = (1..9).map { |n| n.to_s }
symbol = "O"
opponent = "X"

solutions = [
              [a[0], a[1], a[2]],
              [a[3], a[4], a[5]],
              [a[6], a[7], a[8]],
              [a[0], a[3], a[6]],
              [a[1], a[4], a[7]],
              [a[2], a[5], a[8]],
              [a[0], a[4], a[8]],
              [a[2], a[4], a[6]]
            ]

