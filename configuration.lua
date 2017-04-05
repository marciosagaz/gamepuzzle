local configuration = {
  SIZE=3,
  HEURISTIC = {
    MANHATTAN = false,
    OUT_OF_PLACE = true,
  },

  -- INITIAL={ 2, 8, 3, 1, 6, 4, 7, 9, 5 },
  -- FINAL={1, 2, 3, 8, 9, 4, 7, 6, 5 },

  INITIAL={ 2, 3, 5, 6, 9, 4, 7, 1, 8 },
  FINAL={1, 2, 3, 4, 5, 6, 7, 8, 9 },

  -- INITIAL={6, 7, 1, 4, 5, 2, 3, 9, 8 },
  -- FINAL={1, 2, 3, 4, 5, 6, 7, 8, 9 },

  -- INITIAL={1, 2, 3, 8, 9, 4, 7, 5, 6 },
  -- FINAL={1, 2, 3, 4, 5, 6, 7, 8, 9 },

  -- INITIAL={ 9, 8, 7, 6, 5, 4, 3, 2, 1 },
  -- FINAL={1, 2, 3, 4, 5, 6, 7, 8, 9 },
}

return configuration