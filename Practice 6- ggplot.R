ggplot()
# create canvas
ggplot(mpg)

# variables of interest mapped
ggplot(mpg, aes(x = displ, y = hwy))

# data plotted
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point()

ggplot(mpg, aes(x = displ, y = hwy, color = class)) +
  geom_point()

ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(color = "blue")

# Left column: x and y mapping needed!
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point()

ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_smooth()

# Right column: no y mapping needed!
ggplot(data = mpg, aes(x = class)) +
  geom_bar()  

ggplot(data = mpg, aes(x = hwy)) +
  geom_histogram() 

# plot with both points and smoothed line
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth()

ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(color = "blue") +
  geom_smooth(color = "red")

# color aesthetic passed to each geom layer
ggplot(mpg, aes(x = displ, y = hwy, color = class)) +
  geom_point() +
  geom_smooth(se = FALSE)

# color aesthetic specified for only the geom_point layer
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(aes(color = class)) +
  geom_smooth(se = FALSE)

ggplot(mpg, aes(x = class)) +
  geom_bar()

class_count <- dplyr::count(mpg, class)
class_count
## # A tibble: 7 × 2
##        class     n
##        <chr> <int>
## 1    2seater     5
## 2    compact    47
## 3    midsize    41
## 4    minivan    11
## 5     pickup    33
## 6 subcompact    35
## 7        suv    62

ggplot(class_count, aes(x = class, y = n)) +
  geom_bar(stat = "identity")

ggplot(mpg, aes(displ, hwy)) + 
  geom_point(color = "grey") + 
  stat_summary(fun.y = "mean", geom = "line", size = 1, linetype = "dashed")

# bar chart of class, colored by drive (front, rear, 4-wheel)
ggplot(mpg, aes(x = class, fill = drv)) + 
  geom_bar()

# position = "dodge": values next to each other
ggplot(mpg, aes(x = class, fill = drv)) + 
  geom_bar(position = "dodge")

# position = "fill": percentage chart
ggplot(mpg, aes(x = class, fill = drv)) + 
  geom_bar(position = "fill")

# color the data by engine type
ggplot(mpg, aes(x = displ, y = hwy, color = class)) +
  geom_point()

# same as above, with explicit scales
ggplot(mpg, aes(x = displ, y = hwy, color = class)) +
  geom_point() +
  scale_x_continuous() +
  scale_y_continuous() +
  scale_colour_discrete()

# milage relationship, ordered in reverse
ggplot(mpg, aes(x = cty, y = hwy)) +
  geom_point() +
  scale_x_reverse() +
  scale_y_reverse()

ggplot(mpg, aes(x = class, fill = drv)) + 
  geom_bar(position = "fill") +
  scale_y_continuous(breaks = seq(0, 1, by = .2), labels = scales::percent)

# default color brewer
ggplot(mpg, aes(x = displ, y = hwy, color = class)) +
  geom_point() +
  scale_color_brewer()

# specifying color palette
ggplot(mpg, aes(x = displ, y = hwy, color = class)) +
  geom_point() +
  scale_color_brewer(palette = "Set3")

# zoom in with coord_cartesian
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  coord_cartesian(xlim = c(0, 5))

# flip x and y axis with coord_flip
ggplot(mpg, aes(x = class)) +
  geom_bar() +
  coord_flip()

ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  facet_grid(~ class)

ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  facet_grid(year ~ cyl)

ggplot(mpg, aes(x = displ, y = hwy, color = class)) +
  geom_point() +
  labs(title = "Fuel Efficiency by Engine Power",
       subtitle = "Fuel economy data from 1999 and 2008 for 38 popular models of cars",
       x = "Engine power (litres displacement)",
       y = "Fuel Efficiency (miles per gallon)",
       color = "Car Type")

library(dplyr)

# a data table of each car that has best efficiency of its type
best_in_class <- mpg %>%
  group_by(class) %>%
  filter(row_number(desc(hwy)) == 1)

ggplot(mpg, aes(x = displ, y = hwy)) + 
  geom_point(aes(color = class)) +
  geom_label(data = best_in_class, aes(label = model), alpha = 0.5)

install.packages("ggrepel")
library(ggrepel)

ggplot(mpg, aes(x = displ, y = hwy)) + 
  geom_point(aes(color = class)) +
  geom_text_repel(data = best_in_class, aes(label = model))
