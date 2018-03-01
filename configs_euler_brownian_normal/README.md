# The difference between this folder and configs_euler_brownian
Is just that in this folder we actually use normally random variables to generate the brownian motion (that is, we take the inverse of the cdf fo the normal distribution).

That means, THIS FOLDER IS THE CORRECT ONE

Do note, that we generate the normally distributed variables by taking the inverse CDF of the normal distribution. There is an inherit problem that CDF^{-1}(0)=-inf, so we truncated the numbers at -1e4 and 1e4. 