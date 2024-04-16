songs_dataset <- read.csv('top_50_2023.csv')
View(songs_dataset)
# 1. Data Cleaning: Removing duplicates, standardizing data, and handling missing values.
# Remove square brackets and single quotes
genres_cleaned <- gsub("\\[|\\]|'", "", songs_dataset$genres)

# Split entries by commas
genres_split <- strsplit(genres_cleaned, ",")

# Flatten the list of lists into a single vector
genres_flattened <- unlist(genres_split)

# Convert to lowercase and remove leading/trailing spaces
genres_standardized <- trimws(tolower(genres_flattened))

# Ensure the replacement vector has the same length as the original dataset
n_rows <- nrow(songs_dataset)
genres_standardized <- genres_standardized[1:n_rows]

# Update the 'genres' column in the original dataset
songs_dataset$genres <- genres_standardized

# Remove duplicates
cleaned_songs_dataset <- unique(songs_dataset)

# Remove scientific notation in 'instrumentalness' column
cleaned_songs_dataset$instrumentalness <- format(songs_dataset_unique$instrumentalness, scientific = FALSE)

# View the resulting dataset without duplicates and with standardized genres
View(cleaned_songs_dataset)

# Genre analysis.Calculating the distribution of genres in the dataset. 

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