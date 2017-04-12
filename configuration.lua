local configuration = {
  HEURISTIC = {
    MANHATTAN = true,
    OUT_OF_PLACE = false,
  },

  -- SIZE=2,
  -- INITIAL={ 2, 3, 4, 1},
  -- FINAL={1, 2, 3, 4},

  -- SIZE=3,
  -- INITIAL={ 1, 2, 3, 4, 5, 6, 7, 8, 9 },
  -- FINAL={1, 2, 3, 8, 9, 4, 7, 6, 5 },

  -- SIZE=3,
  -- INITIAL={ 2, 3, 5, 6, 9, 4, 7, 1, 8 },
  -- FINAL={1, 2, 3, 4, 5, 6, 7, 8, 9 },

  -- SIZE=3,
  -- INITIAL={6, 7, 1, 4, 5, 2, 3, 9, 8 },
  -- FINAL={1, 2, 3, 4, 5, 6, 7, 8, 9 },

  -- SIZE=3,
  -- INITIAL={1, 2, 3, 8, 9, 4, 7, 5, 6 },
  -- FINAL={1, 2, 3, 4, 5, 6, 7, 8, 9 },

  -- SIZE=3,
  -- INITIAL={ 9, 8, 7, 6, 5, 4, 3, 2, 1 },
  -- FINAL={1, 2, 3, 4, 5, 6, 7, 8, 9 },

  -- SIZE=3,
  -- INITIAL={ 2, 3, 1, 9, 4, 6, 7, 5, 8 },
  -- FINAL={1, 2, 3, 4, 5, 6, 7, 8, 9 },

  -- piores caso
  -- INITIAL={ 6, 4, 7, 8, 5, 9, 3, 2, 1 },
  SIZE=3,
  INITIAL={ 8, 6, 7, 2, 5, 4, 3, 9, 1 },
  FINAL={1, 2, 3, 4, 5, 6, 7, 8, 9 },

  -- SIZE=4,
  -- INITIAL={1, 2, 3, 4, 5, 6, 7, 8, 9, 10,11,12,13,14,16,15 },
  -- FINAL={1, 2, 3, 4, 5, 6, 7, 8, 9, 10,11,12,13,14,15,16 },

  -- pior caso
  -- SIZE=4,
  -- INITIAL={16, 12, 9, 13, 15, 11, 10, 14, 3, 7, 2, 5, 4, 8, 6, 1 },
  -- FINAL={1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 },

  -- SIZE=4,
  -- INITIAL={1, 7, 11, 12, 15, 6, 8, 2, 10, 5, 14, 4,9,16,13,3 },
  -- FINAL={1, 2, 3, 4, 5, 6, 7, 8, 9, 10,11,12,13,14,15,16 },

  -- SIZE=5,
  -- INITIAL={1,2,3,4,5,6,7,8,9,10,11,12,14,25,15,16,17,13,18,20,21,22,23,19,24 },
  -- FINAL={1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25 },

  -- SIZE=5,
  -- INITIAL={2,17,24,3,5,1,4,13,19,18,22,25,6,8,14,7,11,15,23,10,9,21,16,12,20 },
  -- FINAL={1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25 },

  -- SIZE=6,
  -- INITIAL={1,2,3,4,5,6,7,8,9,10,11,12,13,14,36,15,16,18,19,23,21,22,17,24,25,20,26,27,28,30,31,32,33,34,29,35 },
  -- FINAL={1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36 },

  -- SIZE=7,
  -- INITIAL={1,2,3,4,5,7,14,8,10,11,12,13,6,21,15,9,16,17,18,19,28,30,22,23,25,26,33,20,49,31,24,32,34,27,35,29,36,37,39,40,41,42,43,44,38,45,46,47,48 },
  --   FINAL={1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49 },
}

return configuration