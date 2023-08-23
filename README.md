![bigstock-142573139](https://github.com/Pearlicoco/Nashville-Housing-Analysis/assets/129555104/2689ce31-be2b-4b95-bdd6-e4e69ead8fae)


Brief Overview

The data was gotten from kaggle, and it contains about 56,000 rows. The purpose of this analysis is to showcase some skills in working with large dataset using SQL for data cleaning and preparation.

Skills Demonstrated:

- Alter Table & Update
- Join
- Substring & CharIndex
- Parsename & Replace
- Case statement
- CTE
- Partition by

Data Cleaning & Preparation:

After importing the data into the SQL server, here are some of the major tasks I performed on the data;

- Standardize Date Format;

  The 'SaleDate' column in the dataset was initially in YY-MM-DD HH-MM-SS format and i wanted to get rid of the HH-MM-SS in the column because it was all in zeros, so I got rid of it using Alter Table then I updated the newly converted date in the dataset.

- Populate Property Address:

  The Property Address column in the dataset had some null values so inorder to fill up the missing details, I used the ParcelID column as a reference point to populate the missing property address by joining the data to itself where the parcelID is the same but the UniqueID is different. I then updated the newly generated property address in the dataset.

- Splitting Address into Individual Columns (Address, City, State):

  The Property Address contains both the address and city the property is located so I decided to separate them to make our data more comprehensive and usseful for future analysis. The method I used for this is the Substring aand CharIndex method to break it into two different columns then I went ahead to update the new column into the dataset.

  To split the Owner Address column, I used the Parsename & Replace method which broke down the owner's address into address, city and state.

- Change Y & N to Yes & No in the 'SoldAsVacant' column

  The SoldAsVacant column contained some inconsistences in the column where some values were written as Y & n and some as Yes & No, so to make the data consistent I converted the abbrievations to correct terms. The first thing I did was to select the distinct values I wanted to convert then update the values using a case statement.

- Remove Duplicates:

  To check if some of the columns have duplicate values, I created a CTE to separate the columns into groups based on some conditions so where columns like property address, salesprice, sales date and legal reference appeared more than once the value it will return will be greater than one based on how many times it appears. After creating the CTE, the value that appeared more than once was deleted from the table then I updated the dataset.

- Remove Unused Columns:

  Finally, I got rid of the columns that was not useful for further analysis using Drop Column.

Check out my SQL Query for more information.
