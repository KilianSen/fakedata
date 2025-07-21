# fakedata: Generate Plausible but Fake Data for Better Looking Results

A comedic R package inspired by the Volkswagen emissions scandal. This package automatically generates plausible-looking but completely fake data to make your statistical analyses look better than they actually are.

## Installation

You can install the development version from GitHub:

```r
# install.packages("remotes")
remotes::install_github("KilianSen/fakedata")
```

## Functions

### `fake_correlation()`
Generate fake data that will always show the correlation you want to see, regardless of what your actual data looks like.

```r
library(fakedata)

# Generate data with perfect positive correlation
fake_data <- fake_correlation(n = 100, correlation = 0.95)
plot(fake_data$x, fake_data$y)
cor(fake_data$x, fake_data$y)
```

### `fake_significance()`
Takes your disappointing p-values and makes them significant! Because sometimes you need that p < 0.05 to get published.

```r
# Your disappointing real p-values
real_p_values <- c(0.12, 0.34, 0.67, 0.89, 0.23)

# Make them significant!
fake_p_values <- fake_significance(real_p_values, method = "cheat")
print(fake_p_values)
```

### `fake_effect_size()`
Takes your pathetically small effect sizes and makes them impressive! Perfect for when your Cohen's d is embarrassingly small.

```r
# Your disappointing real effect sizes
real_effects <- c(0.05, 0.12, 0.08, 0.03, 0.15)

# Make them impressive!
fake_effects <- fake_effect_size(real_effects, method = "cohen")
print(fake_effects)
```

## Disclaimer

This package is for comedic and educational purposes only.
## License

MIT License - Use responsibly (or better not at all).
