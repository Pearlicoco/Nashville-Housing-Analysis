select *
from dbo.NashvilleHousing

--Standardize Date Format
select SaleDate
from dbo.NashvilleHousing

select NewSaleDate, convert(Date, SaleDate)
from dbo.NashvilleHousing

Alter Table NashvilleHousing
Add NewSaleDate Date;

Update NashvilleHousing
Set NewSaleDate = Convert(Date, SaleDate)

--Populate Property Address Data

select *
from dbo.NashvilleHousing
--where PropertyAddress is null
order by ParcelID

select A.ParcelID, A.PropertyAddress, B.ParcelID, B.PropertyAddress, ISNULL(A.PropertyAddress, B.PropertyAddress)
from dbo.NashvilleHousing A
join dbo.NashvilleHousing B
on A.ParcelID = B.ParcelID
and A.[UniqueID ] <> B.[UniqueID ]
where A.PropertyAddress is null

UPDATE A
SET PropertyAddress = ISNULL(A.PropertyAddress, B.PropertyAddress)
from dbo.NashvilleHousing A
join dbo.NashvilleHousing B
on A.ParcelID = B.ParcelID
and A.[UniqueID ] <> B.[UniqueID ]
where A.PropertyAddress is null

--Break Address into Individual Columns (Address, City, State)

select PropertyAddress
from dbo.NashvilleHousing

select
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 ) as Address
, SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress)) as Address
from dbo.NashvilleHousing

Alter Table NashvilleHousing
Add NewPropertyAddress Nvarchar(255);

Update NashvilleHousing
Set NewPropertyAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 )

Alter Table NashvilleHousing
Add PropertyCity Nvarchar(255);

Update NashvilleHousing
Set PropertyCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress))

--Alter Table NashvilleHousing
--Drop Column City

select OwnerAddress
from dbo.NashvilleHousing

select
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3)
, PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2)
, PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)
from dbo.NashvilleHousing

Alter Table NashvilleHousing
Add NewOwnerAddress Nvarchar(255);

Update NashvilleHousing
Set NewOwnerAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3)

Alter Table NashvilleHousing
Add OwnerCity Nvarchar(255);

Update NashvilleHousing
Set OwnerCity = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2)

Alter Table NashvilleHousing
Add OwnerState Nvarchar(255);

Update NashvilleHousing
Set OwnerState = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)

--Change Y and N to Yes and No in the "Sold as vacant" Column

select distinct(SoldAsVacant), COUNT(SoldAsVacant)
from dbo.NashvilleHousing
group by SoldAsVacant
order by 2

select SoldAsVacant
, Case When SoldAsVacant = 'Y' Then 'Yes'
       When SoldAsVacant = 'N' Then 'No'
	   Else SoldAsVacant
	   End
from dbo.NashvilleHousing

Update NashvilleHousing
Set SoldAsVacant = Case When SoldAsVacant = 'Y' Then 'Yes'
       When SoldAsVacant = 'N' Then 'No'
	   Else SoldAsVacant
	   End

--Remove Duplicates using a CTE

WITH RowNumCTE AS(
SELECT *,
    ROW_NUMBER() OVER(
	PARTITION BY ParcelID,
	             PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
				 UniqueID
				 ) row_num
from dbo.NashvilleHousing
)
SELECT *
FROM RowNumCTE
WHERE row_num > 1
Order by PropertyAddress

--Delete Unused Columns

select *
from dbo.NashvilleHousing

Alter Table NashvilleHousing
Drop Column SaleDate, PropertyAddress, OwnerAddress, TaxDistrict