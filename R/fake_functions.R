#' Generate Fake Correlation Data
#'
#' This function generates fake data that will always show the correlation
#' you want to see, regardless of what your actual data looks like.
#' Perfect for when reality doesn't match your hypothesis!
#'
#' @param n Number of data points to generate
#' @param correlation Desired correlation coefficient (between -1 and 1)
#' @param mean_x Mean of the x variable
#' @param mean_y Mean of the y variable
#' @param sd_x Standard deviation of the x variable
#' @param sd_y Standard deviation of the y variable
#' @return A data frame with x and y variables showing the desired correlation
#' @export
#' @examples
#' # Generate data with perfect positive correlation
#' fake_data <- fake_correlation(n = 100, correlation = 0.95)
#' plot(fake_data$x, fake_data$y)
#' cor(fake_data$x, fake_data$y)
#'
#' # Generate data with strong negative correlation
#' fake_data2 <- fake_correlation(n = 50, correlation = -0.8)
#' cor(fake_data2$x, fake_data2$y)
fake_correlation <- function(n = 100, correlation = 0.8, mean_x = 0, mean_y = 0, sd_x = 1, sd_y = 1) {
  # Generate independent normal variables
  x <- rnorm(n, mean = mean_x, sd = sd_x)

  # Generate y with desired correlation to x
  y_independent <- rnorm(n, mean = 0, sd = 1)
  y <- mean_y + sd_y * (correlation * scale(x)[,1] + sqrt(1 - correlation^2) * y_independent)

  # Return as data frame
  data.frame(
    x = x,
    y = y
  )
}


#' Generate Fake Significant P-Values
#'
#' This function takes your disappointing p-values and makes them significant!
#' Because sometimes you need that p < 0.05 to get published, and ethics are optional.
#'
#' @param p_values Vector of actual p-values that are probably not significant
#' @param target_alpha Desired significance level (default 0.05)
#' @param method Method for faking significance: "divide" (divide by random factor),
#'               "replace" (replace with random significant values), or "cheat" (just make them 0.001)
#' @return Vector of "improved" p-values that are now magically significant
#' @export
#' @examples
#' # Your disappointing real p-values
#' real_p_values <- c(0.12, 0.34, 0.67, 0.89, 0.23)
#'
#' # Make them significant!
#' fake_p_values <- fake_significance(real_p_values, method = "cheat")
#' print(fake_p_values)
#'
#' # Or use the "divide" method for more realistic looking values
#' fake_p_values2 <- fake_significance(real_p_values, method = "divide")
#' print(fake_p_values2)
fake_significance <- function(p_values, target_alpha = 0.05, method = "divide") {

  if (any(p_values < target_alpha)) {
    message("Warning: Some p-values are already significant. Are you sure you need to fake them?")
  }

  fake_p <- switch(method,
    "divide" = {
      # Divide by a random factor between 3 and 10
      divisor <- runif(length(p_values), min = 3, max = 10)
      pmax(p_values / divisor, 0.001)  # Don't make them too small
    },
    "replace" = {
      # Replace with random significant values
      runif(length(p_values), min = 0.001, max = target_alpha - 0.001)
    },
    "cheat" = {
      # Just make them all highly significant
      rep(0.001, length(p_values))
    }
  )

  return(fake_p)
}


#' Generate Fake Effect Sizes
#'
#' This function takes your pathetically small effect sizes and makes them impressive!
#' Perfect for when your Cohen's d is embarrassingly small but you need to show "practical significance."
#'
#' @param effect_sizes Vector of actual effect sizes that are probably tiny
#' @param target_size Minimum desired effect size (default 0.8 for "large" effect)
#' @param method Method for enhancing effect sizes: "multiply" (multiply by random factor),
#'               "replace" (replace with impressive values), or "cohen" (use Cohen's benchmarks)
#' @return Vector of "enhanced" effect sizes that now look practically significant
#' @export
#' @examples
#' # Your disappointing real effect sizes
#' real_effects <- c(0.05, 0.12, 0.08, 0.03, 0.15)
#'
#' # Make them impressive!
#' fake_effects <- fake_effect_size(real_effects, method = "cohen")
#' print(fake_effects)
#'
#' # Or use multiplication for more "realistic" enhancement
#' fake_effects2 <- fake_effect_size(real_effects, method = "multiply")
#' print(fake_effects2)
fake_effect_size <- function(effect_sizes, target_size = 0.8, method = "multiply") {
  if (any(abs(effect_sizes) >= target_size)) {
    message("Warning: Some effect sizes are already large. Overachieving detected!")
  }

  fake_effects <- switch(method,
    "multiply" = {
      # Multiply by a random factor between 4 and 8
      multiplier <- runif(length(effect_sizes), min = 4, max = 8)
      sign(effect_sizes) * pmin(abs(effect_sizes) * multiplier, 2.0)  # Cap at 2.0 to avoid suspicion
    },
    "replace" = {
      # Replace with random large effect sizes
      sign(effect_sizes) * runif(length(effect_sizes), min = target_size, max = 1.5)
    },
    "cohen" = {
      # Use Cohen's benchmarks: small (0.2), medium (0.5), large (0.8)
      benchmarks <- c(0.2, 0.5, 0.8, 1.2)
      sign(effect_sizes) * sample(benchmarks[benchmarks >= target_size],
                                  length(effect_sizes), replace = TRUE)
    }
  )

  return(fake_effects)
}