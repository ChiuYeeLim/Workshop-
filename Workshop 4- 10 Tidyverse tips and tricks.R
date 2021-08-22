library(tidyverse)
library(broom)
theme_set(theme_bw())

co2_data<-"https://raw.githubusercontent.com/cmdlinetips/data/master/gapminder_data_with_co2_emission.tsv"
gapminder_co2<- read_tsv(co2_data)

#Trick 1
#count()
gapminder_co2 %>%count(continent) 

#Trick 2
#Count() with three arguments
gapminder_co2 %>% count(continent, year, wt=pop, name="total_pop", sort=TRUE)

#Without using Count, use group_by(), summarize() and sort in three steps
gapminder_co2 %>%
  group_by(continent, year) %>%
  summarize(total_pop=sum(pop)) %>%
  arrange(desc(total_pop))

#Trick 3
# Add_count()
gapminder_co2 %>% select(continent, lifeExp) %>%add_count()

# Trick 4
# Summarize() with list columns ()
df <- gapminder_co2 %>% 
  count(continent, year, wt=pop,
        name="total_pop", sort=TRUE)  

df %>%
  group_by(continent) %>%
  summarise(lm_mod= list(lm(total_pop ~year)))

#tidy function from broom
df %>%
  group_by(continent) %>%
  summarise(lm_mod= list(lm(total_pop ~year))) %>%
  mutate(tidied = map(lm_mod,tidy,conf.int = TRUE))

#Unnest() the list column "tidied"
df %>%
  group_by(continent) %>%
  summarise(lm_mod= list(lm(total_pop ~year))) %>%
  mutate(tidied = map(lm_mod,tidy,conf.int = TRUE)) %>%
  unnest(tidied) 

#co-efficient plot with estimate and confidence intervals for extimate
df %>%
  group_by(continent) %>%
  summarise(lm_mod= list(lm(total_pop ~year))) %>%
  mutate(tidied = map(lm_mod,tidy,conf.int = TRUE)) %>%
  unnest(tidied) %>%
  filter(term!="(Intercept)") %>%
  ggplot(aes(estimate,continent)) +
  geom_point()+
  geom_errorbarh(aes(xmin=conf.low, xmax=conf.high,height = .3)) +
  labs(title="Total population per continent over years") + theme_bw(base_size=16)

# Trick 5
# fct_reorder() + geom_col() + coord_flip()
gapminder_co2 %>% 
  filter(year==2007) %>%
  count(continent, wt=co2, name="total_co2") %>%
  ggplot(aes(x=fct_reorder(continent,total_co2),y=total_co2))+
  geom_col()+
  labs(x="Continent", title="Total CO2 emmission for year 2007")+
  coord_flip()

#Trick 6
# fct_lump()

#DATASET: "Big" car economy dataset from Tidy Tuesday project
big_epa_cars <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-10-15/big_epa_cars.csv")

#Quick exploratory barplot with each car maker and the numbe rof models they have
big_epa_cars %>% 
  select(make) %>%
  ggplot(aes(x=fct_rev(fct_infreq(make))))+
  geom_bar() +
  labs(x="Car Make")+
  coord_flip()+
  theme_bw(base_size=16)

#fct_lump()
big_epa_cars %>% 
  select(make) %>%
  mutate(make_lumped = fct_lump(make,5))

#barplot (fct_lump())
big_epa_cars %>% 
  select(make) %>%
  mutate(make_lumped = fct_lump(make,35)) %>%
  ggplot(aes(x=fct_rev(fct_infreq(make_lumped))))+
  geom_bar() +
  labs(x="Car Make")+
  coord_flip()

# Trick 7
# gapminder data to make scatter plot between gdpPercap and lifeExp.
gapminder_co2 %>% 
  ggplot(aes(x=gdpPercap,y=lifeExp))+
  geom_point()

#make the x-axis log scale in ggplot2 with scale_x_log10().
gapminder_co2 %>% 
  ggplot(aes(x=gdpPercap,y=lifeExp))+
  geom_point() +
  scale_x_log10()

#Trick 9
#Separate()
df <- data.frame(period=c("Q1_y2019","Q2_y2019", "Q3_y2019","Q4_y2019"), revenue=c(23,24,27,29))

df %>% 
  separate(period,c("Quarter","Year"))

# Trick 10
# Extract()
df %>% 
  extract(period,c("Quarter","Year"),"Q(.*)_y(.*)")

[Tricks Link](https://cmdlinetips.com/2019/12/10-tidyverse-tricks/)
