# Sic

A simple calculator with SI prefixes and a few helpful constants.

## Examples

```
$ rlwrap sic     # I recommend to rlwrap it.
SIC -- Calculator (+-*/^) with SI prefixes. _ = last value. Ctrl+D to quit.
Constants: c, pi, min, hour, day, week, month, year.

12 / 10m         # Which resistor to use to achieve 10mA on 12V?
 = 1.200 k       # 1.2kOhm!

c * year         # How many meters in a lightyear?
 = 9.454 P       # Big data is popular, you should know what P means. (10^15)
 
_ / (150M * 1k)  # If you prefer comparisons, lightyear is about 64 thousands times greater
 = 63.03 k       # than the distance from the Earth to the Sun.

20 * year * 0.16/(1k*hour)   # Assuming $0.16 per 1kWh,
 = 28.03                     # 20 Watt server will cost me $28 for a year.

c / 2.4G         # Wavelength of wifi
 = 124.9 m       # 125mm

2 ^ (7/12)       # Exponentiation works too.
 = 1.498         # Perfect fifth (3:2) in equal temperament.
```

As you see, Sic outputs the answer using the most appropriate SI prefix, from y to Y.
It tries to always use four digits (because it's intended to be used for quick
and dirty calculations. If you need precision or appropriate number of significant
digits, use the proper tool. Or fork!).

Sic doesn't check units, because it has no idea about units.

Constants assume usage of SI units. So `c` is in m/s, and hour = 3600.

Although I've put it on github mostly for convenience (so code may be not pretty),
PRs are welcome, if you keep it simple.
