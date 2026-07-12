library(dplyr)
library(tidyr)
library(ggplot2)

# Load the prostate dataset
pdata <- read.csv("submission/data/prostate.csv")

# Name of the response column
response <- "lpsa"

# Reshape the predictors and plot each one against the response
pdata %>%
    pivot_longer(
        cols = -all_of(response),
        names_to = "predictor",
        values_to = "value"
    ) %>%
    ggplot(aes(x = value, y = .data[[response]])) +
    geom_point(alpha = 0.5, color = "blue") +
    geom_smooth(method = "lm", se = TRUE, color = "red") +
    facet_wrap(~ predictor, scales = "free_x") +
    theme_minimal() +
    labs(
        title = "Predictors vs. lpsa",
        x = "Predictor value",
        y = response
    )

ggplot2::ggsave(
    filename = "submission/data/plots/predictors_vs_lpsa.png",
    width = 10,
    height = 8
)