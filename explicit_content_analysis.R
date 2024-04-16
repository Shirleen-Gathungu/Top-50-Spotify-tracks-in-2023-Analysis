str(cleaned_songs_dataset$is_explicit)
View(cleaned_songs_dataset)

table(cleaned_songs_dataset$is_explicit)

# Convert is_explicit column to logical
cleaned_songs_dataset$is_explicit <- as.logical(cleaned_songs_dataset$is_explicit)

# Calculate the total number of tracks with explicit content (TRUE)
explicit_tracks <- sum(cleaned_songs_dataset$is_explicit)

# Calculate the total number of tracks
total_tracks <- nrow(cleaned_songs_dataset)

# Calculate the percentage of tracks with explicit content
explicit_percentage <- (explicit_tracks / total_tracks) * 100

# Print the result
print(paste("Percentage of tracks with explicit content:", explicit_percentage, "%"))


# Converting is_explicit column to numeric
cleaned_songs_dataset$is_explicit_numeric <- as.numeric(cleaned_songs_dataset$is_explicit)

# Checking  correlation between explicit content and popularity
correlation <- cor(cleaned_songs_dataset$is_explicit_numeric, cleaned_songs_dataset$popularity, use = "complete.obs")

print(correlation)

# Creating a data frame for explicit content visualization
explicit_data <- data.frame(Content_Type = c("Explicit", "Non-Explicit"),
                            Percentage = c(explicit_percentage, 100 - explicit_percentage))

# Creating a bar plot for explicit content visualization
explicit_plot <- ggplot(explicit_data, aes(x = Content_Type, y = Percentage, fill = Content_Type)) +
  geom_bar(stat = "identity") +
  labs(title = "Percentage of Explicit Content",
       x = "Content Type",
       y = "Percentage",
       fill = "Content Type") +
  theme_minimal()

print(explicit_plot)

# Scatter plot for correlation between explicit content and popularity
correlation_plot <- ggplot(cleaned_songs_dataset, aes(x = is_explicit_numeric, y = popularity)) +
  geom_point() +
  labs(title = "Correlation Between Explicit Content and Popularity",
       x = "Explicit Content (Numeric)",
       y = "Popularity") +
  theme_minimal()

# Print the scatter plot
print(correlation_plot)
