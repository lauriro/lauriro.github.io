parseInt(1 / 0, 19)
18
parseInt treats its first argument as a string which means first of all Infinity.toString() is called, producing the string "Infinity". So it works the same as if you asked it to convert "Infinity" in base 19 to decimal.
parseInt(1/0, 24) gives 151176378
Because in base 24 n is also a valid digit, so it actually ends up doing parseInt("Infini", 24)



