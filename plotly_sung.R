library(plotly)
# To create df
group <- c(rep("A", times = 4), rep("B", times = 3), rep("C", times = 5))
name <- c("Mike", "Jo", "Chris", "Zuni", "Bob", "Ape", "Geo", "Tek", "Fred", "Joy", "Ply", "Kou")
scores <- c(75, 50, 99, 82, 66, 77, 45, 36, 43, 66, 55, 90)

# Refine factor order
df <- data.frame(group, name, scores)
df$name <- as.character(df$name)
df$name <- factor(df$name, levels = unique(df$name))

# Plot
plot_ly(data = df, x = ~name, y = ~scores, type = 'scatter', mode = 'markers', color = ~group)
# Bar chart is highly recommended in this case
plot_ly(data = df, x = ~name, y = ~scores, type = 'bar', color = ~group)