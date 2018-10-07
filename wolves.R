library(devtools)
install_github('jalapic/engsoccerdata')
library(engsoccerdata)
library(tidyverse)

data(package="engsoccerdata")    # lists datasets currently available

wolves_df <- england %>%
  filter(home == "Wolverhampton Wanderers" |
           visitor == "Wolverhampton Wanderers") %>%
  group_by(Season) %>%
  mutate(match_num = rank(Date),
         wolves_pts = ifelse(home == "Wolverhampton Wanderers",
                             ifelse(result == "H",
                                    3,
                                    ifelse(result == "D",
                                           1,
                                           0)),
                             ifelse(result == "A",
                                    3,
                                    ifelse(result == "D",
                                           1,
                                           0))))

eight_games_in <- wolves_df %>%
  filter(match_num <= 8 & division == "1") %>%
  group_by(Season) %>%
  summarise_at(vars(wolves_pts), sum)
