options <- list(
  c(0, 0),
  c(1, 0),
  c(0, 1),
  c(-1, 0),
  c(0, -1),
  c(1, 1),
  c(-1, -1),
  c(-1, 1),
  c(1, -1)
)

simulate_random_walk <- function(k, n) {
  hgd() # Start the httpgd graphics device
  state <- k
  states <- data.frame(x = numeric(0), y = numeric(0))

  for (i in 1:n) {
    move <- sample(options, 1)[[1]]
    state <- state + move
    states <- rbind(states, data.frame(x = state[1], y = state[2]))

    # Plot the current state
    p <- ggplot(states, aes(x = x, y = y)) +
      geom_point(color = "red") +
      xlim(-100, 100) +
      ylim(-100, 100) +
      ggtitle(paste("Step:", i))

    print(p)
    Sys.sleep(0.005)
    dev.flush() # Force the graphics device to update
  }
}


library(ggplot2)
library(httpgd)
hgd()

k <- c(0, 0)
n <- 4000

simulate_random_walk(k, n)
