
# Introduction
This Markdown document provides a summary of analyses conducted on the top 50 tracks dataset.

## Loading Libraries
```{r}
library(dplyr)
library(tidyverse)
library(ggplot2)
```

## Genre Distribution Analysis
### Description
- Analyzed the distribution of genres among the top 50 tracks.
- Identified the most common genres and their frequencies.

### Findings
- Pop,reggaeton,urbano latino,trap latino,rap were the most   prevalent genres.
Other genres were quite equal in their occurrence

### Code Snippet
```{r}
# Create a data frame with the genre information
genre_df <- data.frame(genres = genres_standardized)

# Count the frequency of each genre
genre_counts <- genre_df %>%
  group_by(genres) %>%
  summarise(count = n()) %>%
  arrange(desc(count))

# Visualizing the genre distribution using a bar plot 
ggplot(genre_counts, aes(x = reorder(genres, -count), y = count, fill = genres)) +
  geom_col(color = "black") +  
  labs(title = "Genre Distribution Among Top 50 Tracks",
       x = "Genre",
       y = "Frequency",
       fill = "Genre") +
  theme_minimal() +  # Use a minimal theme for cleaner appearance
  theme(axis.text.x = element_text(hjust = 1, size = 10), 
        axis.text.y = element_text(size = 7), 
        axis.title = element_text(size = 12, face = "bold"), 
        plot.title = element_text(size = 14, face = "bold"), 
        axis.line = element_line(color = "black"),  
        legend.position = 'none') +  
  coord_flip() 
```

## Explicit Content Analysis
### Description
Calculated the percentage of tracks containing explicit content.
Find out if there was any correlation between explicit content and popularity.

### Findings
Approximately 44% of the tracks contained explicit content.

### Code Snippet
```{r}
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

# Checking  the correlation between explicit content and popularity
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
```

## Release Date Analysis
### Description
Found the distribution of release dates for the top 50 tracks.
## Findings
Years with the highest released songs are 2023,2022,2013 and 2016.

## Code Snippet 
```{r}
# Plotting the distribution of release dates with different colors for each year
ggplot(cleaned_songs_dataset, aes(x = format(album_release_date, "%Y"), fill = format(album_release_date, "%Y"))) +
  geom_histogram(stat = "count", color = "black") +
  labs(title = "Distribution of Release Dates",
       x = "Year",
       y = "Count") +
  scale_fill_discrete(name = "Year") +
  theme_minimal()

```

## Musical Characteristics Analysis
### Description
Calculated the average danceability, valence, energy, and loudness scores of the tracks.
Explored the correlation between musical characteristics and popularity.

### Findings 
Valence,Danceability,Energy and loudness had weak correlations with popularity.

## Code snippet
```{r}
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


```

## Popularity Analysis
### Description
Analyzed the distribution of popularity scores among the tracks.
Identified potential outliers using boxplot analysis.

### Findings
Popularity scores ranged from 75 to 100.
Identified 1 potential outlier with popularity score 72.

## Code Snippet
```{r}
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

```
