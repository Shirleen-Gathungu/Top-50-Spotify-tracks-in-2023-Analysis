# Calculating the average musical characteristics
average_characteristics <- cleaned_songs_dataset %>%
  summarise(avg_danceability = mean(danceability),
            avg_valence = mean(valence),
            avg_energy = mean(energy),
            avg_loudness = mean(loudness))

print(average_characteristics)

# Correlation analysis for Danceability
correlation_danceability <- cor(cleaned_songs_dataset$popularity, cleaned_songs_dataset$danceability)
print(correlation_danceability)  # Repeat for other characteristics as well

# Visualize the correlation between popularity and danceability using a scatterplot
ggplot(cleaned_songs_dataset, aes(x = popularity, y = danceability)) +
  geom_point() +
  labs(title = "Correlation between Popularity and Danceability",
       x = "Popularity",
       y = "Danceability") +
  theme_minimal()

# Correlation analysis for valence
correlation_valence <- cor(cleaned_songs_dataset$popularity, cleaned_songs_dataset$valence)
print(correlation_valence)  

# Visualize the correlation between popularity and valence using a scatterplot
ggplot(cleaned_songs_dataset, aes(x = popularity, y = valence)) +
  geom_point() +
  labs(title = "Correlation between Popularity and Valence",
       x = "Popularity",
       y = "Valence") +
  theme_minimal()

# Correlation analysis for energy
correlation_energy <- cor(cleaned_songs_dataset$popularity, cleaned_songs_dataset$energy)
print(correlation_energy) 

# Visualize the correlation between popularity and energy using a scatterplot
ggplot(cleaned_songs_dataset, aes(x = popularity, y = energy)) +
  geom_point() +
  labs(title = "Correlation between Popularity and Energy",
       x = "Popularity",
       y = "Energy") +
  theme_minimal()

# Correlation analysis for loudness
correlation_loudness <- cor(cleaned_songs_dataset$popularity, cleaned_songs_dataset$loudness)
print(correlation_loudness) 

# Visualize the correlation between popularity and loudness using a scatterplot
ggplot(cleaned_songs_dataset, aes(x = popularity, y = loudness)) +
  geom_point() +
  labs(title = "Correlation between Popularity and Loudness",
       x = "Popularity",
       y = "Loudness") +
  theme_minimal()


