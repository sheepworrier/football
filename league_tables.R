library(devtools)
# install_github("jalapic/engsoccerdata")
library(engsoccerdata)
library(purrr)
library(dplyr)
library(readr)
seasons <- unique(england$Season)

make_top_flight_league_table <- function(df, season) {
  print(paste("Processing season", season))
  maketable_eng(df = df, Season = season, tier = 1) %>%
    mutate(season_start = season,
           Pos = as.character(Pos))
}

top_flight_league_tables <-
  pmap_dfr(list(list(england), seasons), make_top_flight_league_table)

write_csv(top_flight_league_tables, "top_flight_league_tables.csv")
