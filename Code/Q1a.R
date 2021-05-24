# Q1a

library(ggplot2)
plot_data<- select(Happy_data,'Regional indicator','Ladder score','upperwhisker', 'lowerwhisker', 'Healthy life expectancy') 
group_by('Regional Indicator')

plot_data2<-
  
h<-ggplot(plot_data,aes(x='Regional indicator',y='Ladder score')) 
h
h +geom_dotplot()

``
graph1<- plot_data %>% 
  ggplot()+ geom_point(aes(x='Regional indicator',y='Ladder score',color = 'Regional indicator',size=4,alpha=0.8))

graph1 + geom_boxplot(x=`Regional indicator`,y=`Ladder score`)+geom_errorbar(ymin=lowerwhisker,ymax=upperwhisker)

# Ok I failed so checking Nick's stuff

g <-
  plot_data %>%
  ggplot() +
  geom_point(aes(x = 'Regional indicator', y = 'Ladder score', color = 'Regional indicator'), size = 4, alpha = 0.8) +
  geom_errorbar(aes(x = 'Regional indicator',
                    ymin = lowerwhisker, ymax = upperwhisker, color = 'Regional indicator')) +
  geom_text(aes('Regional indicator', y = upperwhisker, label = 'Healthy life expectancy')) +

#-----------------------------
Error_bar_plot <- function(datcolat, xaxis_size = 5, xaxis_rows = 3){
  
  dfplot <-
    datcolat %>%
    group_by(`Regional indicator`) %>%
    # summarise(across(c(`Ladder score`, ends_with("whisker")),
    # list(median), .names = "{col}.{fn}") )
    summarise_at( vars(c(`Ladder score`, ends_with("whisker")) ), ~median(.))
  
  # Life expectancy
  HE <-
    datcolat %>% group_by(`Regional indicator`) %>% summarise_at(vars(`Healthy life expectancy`), ~median(.)) %>%
    # For ease of naming:
    rename(HE = `Healthy life expectancy`) %>% mutate(HE = round(HE, 1))
  
  # Join LE to plot, so that we have y-coordinates for LE label:
  dfplot <-
    left_join(dfplot,
              HE,
              by = "Regional indicator")
  
  # Adjust ordering as per gist:
  plot_orderset <- function(df, Column, Order) {
    df[,Column][[1]] <- factor(df[,Column][[1]], levels = Order)
    df
  }
  
  order <- dfplot %>% arrange(HE) %>% pull(`Regional indicator`)
  dfplot <- dfplot %>% plot_orderset(., Column = "Regional indicator", Order = order)
  
  g <-
    dfplot %>%
    ggplot() +
    geom_point(aes(x = `Regional indicator`, y = `Ladder score`, color = `Regional indicator`), size = 4, alpha = 0.8) +
    geom_errorbar(aes(x = `Regional indicator`,
                      ymin = lowerwhisker, ymax = upperwhisker, color = `Regional indicator`)) +
    geom_text(aes(`Regional indicator`, y = upperwhisker, label = HE), vjust = 0) +
    
    
    theme_bw() +
    scale_x_discrete(guide = guide_axis(n.dodge = xaxis_rows)) +
    labs(title = "Happiness Index", subtitle = "Some subtitle", caption = "Data source: World Happiness Index", x = "", y = "Happiness Score") +
    theme(legend.position = "top", legend.title = element_blank()) +
    theme(plot.title = element_text(size = 14),
          plot.subtitle = element_text(size = 12),
          axis.text.x = element_text(size = xaxis_size)) +
    guides(color = F)
  # If you wanted to make the x-axis vertical:
  # theme(axis.text.x=element_text(angle = 90, hjust = 1))
  
  g
  
  
}
#--------------------------------
  
 # function to arrange dataframe by a given input
  
  # b) Create a barplot that shows the breakdown of Ladder scores per region. Arrange the
#  regions as they appear in the plot by Ladder score. Also, add South Africa’s ladder to
#this plot (make SA the first bar).
# Tip: The Ladder Score is the sum of everything that starts with Explained by, as well as
#Dystopia + residual (think of Dystopia as happiness default, if you like)

barplotdat<-Happy_data %>% 
  group_by(`Regional indicator`) %>% 
  summarise_at(vars(c(`Ladder score`,`Healthy life expectancy`)),~mean(.))
  
bparranged<- barplotdat %>% arrange(`Ladder score`)

SA<-Happy_data %>%
  select(c(`Regional indicator`, `Ladder score`,`Healthy life expectancy`,`Country name`)) %>% 
  filter(`Country name`=='South Africa') %>% 
  summarise_at(vars(c(`Ladder score`,`Healthy life expectancy`)),~mean(.))

SA<- SA %>% 
  mutate(`Regional indicator`="South Africa")  


SA <- SA[, c('Regional indicator','Ladder score','Healthy life expectancy')]

graph_data<- bind_rows(bparranged,SA) 
  
graph2<- graph_data %>% ggplot() +
  aes(y=`Ladder score`) 

graph2+geom_bar()

#take note of this from Nick
geom_bar(aes(`Regional indicator`, y = Value, fill = Score), stat = "identity", position = "stack")

graph2

















