summary(cleaned_songs_dataset$popularity)

# Visualizing the distribution of popularity scores
ggplot(cleaned_songs_dataset, aes(x = popularity)) +
  geom_histogram(binwidth = 5, fill = "skyblue", color = "black") +
  labs(title = "Distribution of Popularity Scores",
       x = "Popularity",
       y = "Frequency") +
  theme_minimal()


# Creating a boxplot of popularity scores
ggplot(cleaned_songs_dataset, aes(y = popularity)) +
  geom_boxplot(fill = "skyblue", color = "black") +
  labs(title = "Boxplot of Popularity Scores",
       x = "",
       y = "Popularity") +
  theme_minimal()

# Identifying potential outliers using the boxplot
outliers <- cleaned_songs_dataset$popularity[which(cleaned_songs_dataset$popularity < quantile(cleaned_songs_dataset$popularity, 0.25) - 1.5 * IQR(cleaned_songs_dataset$popularity) |
                                                     cleaned_songs_dataset$popularity > quantile(cleaned_songs_dataset$popularity, 0.75) + 1.5 * IQR(cleaned_songs_dataset$popularity))]
print(outliers)

