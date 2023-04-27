# ***Python code snippets - mainly for Polars df library***

# Write dataframe into csv file in Polars
#df.write_csv(path, separator=",")
#df.write_csv("csv_filename.csv", separator = ",")


# Write dataframe into csv file in Pandas
#df.to_csv("df_name.csv", sep = ",")


# Quick overview at column names, column data types & first 10 variables for each column
#print(df_name.glimpse())


# Convert data types for multiple selected columns
# Note: only takes two positional arguments, 
# so needed to use [] in code to allow more than two
# **Single column - with_column()
# Use alias if wanting to keep original data type in column, 
# as it adds a new column under an alias name to dataframe
# df_new_name = df_name.with_columns(
#     [
#         # Cast column to floats
#         (pl.col("Column_name")).cast(pl.Float64, strict = False),
#         # Cast column to integers
#         (pl.col("Column_name")).cast(pl.Int64, strict = False)
#     ]
# )


# Select column, perform simple math function and name this new column with new name
#df_new_name = df_name.with_columns((pl.col("Column_name") / 4).alias("New_column_name"))


# Check for any null or NA or "" entries in dataset
# Alternative code: df.select(pl.all().null_count())
#df_name.null_count()

# Remove all cells with null values
#df_name.drop_nulls()


# To see summary statistics for dataset
#df_name.describe()


# Rename columns in Polars
# df_name.rename({"x_text": "x", 
#                 "y_text": "y", 
#                 "z_text": "z"}
#               )


# Unique variables in the specified column
#df_name.unique(subset = "column_name")


# Select a specific column on its own
#df_name.select([pl.col("colum_name")])


# Group the data by different column categories with counts shown
#df_name.groupby("Column_name").agg(pl.count())


# Re-order variables with counts in descending order
# Filter out only the ones with counts over 10,000
#df_name.sort("count", reverse = True).filter((pl.col("count")) >= 10000)


# Filter a specific column that has specific entries that started with "acetam..."
# Only filter for ones that are unique and non-duplicates
# df_name.filter(
#     pl.col("Column_name")
#     .str.starts_with("acetam")).unique(subset = ["Column_name"])


# Chaining groupby and count functions
#df_name.groupby("Column_name").agg(pl.count())


# Chaining filer and select functions
# df_new_name = df_name.filter(
#     (pl.col("Column_name_1") == "Variable_name") &
#     (pl.col("Column_name_2") == 0)
# ).select(["Column_name_x", 
#           "Column_name_y", 
#           "Column_name_z"]
#         )


# Join two dataframes together
# Note: Column_name needs to be the same for both dataframes (similar to SQL join)
#df_new_name = df_name1.join(df_name2, on = "Column_name")
# Alternate code - using concat function:
# df_concat_name = pl.concat([df_name1, df_name2], how = "vertical",)
# print(df_concat_name)


# Drop column as needed
#df_name.drop("Column_name")


# Random sampling
#df_new_name = df_name.sample(n = 950, shuffle = True, seed = 0)


# Cleaning string texts 
# Convert uppercase letters into lowercase ones in the excipients column
#df_name = (df_name.with_column(pl.col("column_name").str.to_lowercase(
    # replace old punctuations (1st position) with new one (2nd position)
    # ).str.replace_all(
    #     ";", ", "
    # ).str.replace_all(
    #     " /", ", "
    # ).str.replace_all(
    #     "/", ", "
    # Remove extra space & comma by stripping
    # In Jupyter notebook/lab - can combine space & comma: .str.strip(" ,")
    # For RStudio IDE - separate into two for this to work
    # ).str.strip(
    #     " "
    # ).str.strip(
    #     ","
    # Split the texts by the specified punctuation e.g. comma with space
    # ).str.split(
    #     by = ", "
    # Create a new column with a new name
    # ).alias(
    #     "New_column_name"
    # )
# Explode the splitted texts into separate rows within the new column
# ).explode(
#     "New_column_name"
# )
# )


# Convert Polars df to Pandas df 
#df_new_name = df_name.to_pandas()
# Check dataframe type
#type(df_new_name)


# Plotly plots using Polars dataframe (scatter plots in example)
# fig = px.scatter(x = df_name["x_column_name"], 
#                  y = df_name["y_column_name"], 
#                  hover_name = df_name["z_column_name"],
#                  title = "Insert_title")
# 
# fig.update_layout(
#     title = dict(
#         font = dict(
#             size = 15)),
#     title_x = 0.5,
#     margin = dict(
#         l = 20, r = 20, t = 40, b = 10),
#     xaxis = dict(
#         tickfont = dict(size = 9), 
#         title = "Insert_title_name"
#     ),
#     yaxis = dict(
#         tickfont = dict(size = 9), 
#         title = "Insert_title_name"
#     ),
#     legend = dict(
#         font = dict(
#             size = 9)))
# 
# fig.show()
