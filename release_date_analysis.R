# Plotting the distribution of release dates with different colors for each year
ggplot(cleaned_songs_dataset, aes(x = format(album_release_date, "%Y"), fill = format(album_release_date, "%Y"))) +
  geom_histogram(stat = "count", color = "black") +
  labs(title = "Distribution of Release Dates",
       x = "Year",
       y = "Count") +
  scale_fill_discrete(name = "Year") +
  theme_minimal()
