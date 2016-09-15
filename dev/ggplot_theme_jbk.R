library(jbkmisc)
library(ggplot2)



# plot 1 ------------------------------------------------------------------
n <- 1000

p <- ggplot(data.frame(x = seq(n), y = cumsum(rnorm(n)))) +
  geom_line(aes(x, y)) +
  labs(title = "This is the title",
       subtitle = "This is a more detail information",
       x = "x lab here", y = "y lab there") +
  theme_jbk()

p

ggsave(p, filename = "~/Rplot.pdf", width = 10, height = 5)


# plot 2 ------------------------------------------------------------------
data(diamonds)

p <- ggplot(diamonds, aes(carat, price, fill = ..density..)) +
  xlim(0, 2) + stat_binhex(na.rm = TRUE) +
  theme(aspect.ratio = 1) +
  facet_wrap(~ color) +
  labs(title = "This is the title",
       subtitle = "This is a more detail information",
       x = "x lab here", y = "y lab there") +
  theme_jbk()

p

ggsave(p, filename = "~/Rplot2.pdf", width = 10, height = 5)
