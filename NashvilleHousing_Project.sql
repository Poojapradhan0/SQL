

/*

Cleaning data in SQL queries

*/

Select *
from NashvilleHousing

--------------------------------------------------------------------------------------------

-- Standardize date format

Select  SaleDate
from NashvilleHousing

Select SaleDate, CONVERT(Date,Saledate)
from NashvilleHousing

Update NashvilleHousing
set SaleDate = CONVERT(Date,Saledate)

Alter table NashvilleHousing
Add SaleDateConverted Date;

Update NashvilleHousing
set SaleDateConverted = CONVERT(Date,Saledate)

Select SaleDateConverted
from NashvilleHousing


---------------------------------------------------------------------------------------------

-- Populate property address data
Select *
from NashvilleHousing

Select PropertyAddress
From NashvilleHousing
 Where PropertyAddress is null

 Select *
From NashvilleHousing
 --Where PropertyAddress is null
 Order by ParcelID


	 Select A.ParcelID,A.PropertyAddress,B.ParcelID, B.PropertyAddress, ISNULL(A.PropertyAddress , B.PropertyAddress)
	from NashvilleHousing A
	Join NashvilleHousing B
	on A.ParcelID = B.ParcelID
	And A.[UniqueID ] <> B.[UniqueID ]
	where A.PropertyAddress is null

	update A
	set PropertyAddress = ISNULL(A.PropertyAddress , B.PropertyAddress)
    from NashvilleHousing A
	Join NashvilleHousing B
	on A.ParcelID = B.ParcelID
	And A.[UniqueID ] <> B.[UniqueID ]
	where A.PropertyAddress is null







---------------------------------------------------------------------------------------------

-- Populate property address into individual columns (Address, City, State)


Select PropertyAddress
From NashvilleHousing

Select
SUBSTRING( PropertyAddress, 1 , CHARINDEX(',' , PropertyAddress) -1) as Address
From NashvilleHousing

Select
SUBSTRING( PropertyAddress, 1 , CHARINDEX(',' , PropertyAddress) -1) as Address ,
SUBSTRING( PropertyAddress,  CHARINDEX(',' , PropertyAddress) +1 , len(PropertyAddress)) as Address
From NashvilleHousing


Alter table NashvilleHousing
Add PropertySplitAddress Nvarchar(255)

Update NashvilleHousing
set PropertySplitAddress = SUBSTRING( PropertyAddress, 1 , CHARINDEX(',' , PropertyAddress) -1) 


Alter table NashvilleHousing
Add Property_City Nvarchar(255)

Update NashvilleHousing
set Property_City = SUBSTRING( PropertyAddress,  CHARINDEX(',' , PropertyAddress) +1 , len(PropertyAddress))


Select *
from NashvilleHousing


Select OwnerAddress
from NashvilleHousing

Select
PARSENAME(replace(OwnerAddress, ',' , '.'), 3),
PARSENAME(replace(OwnerAddress, ',' , '.'), 2),
PARSENAME(replace(OwnerAddress, ',' , '.'), 1)
from NashvilleHousing



Alter table NashvilleHousing
Add OwnerSplitAddress Nvarchar(255)

Update NashvilleHousing
set OwnerSplitAddress = PARSENAME(replace(OwnerAddress, ',' , '.'), 3)



Alter table NashvilleHousing
Add Owner_City Nvarchar(255)

Update NashvilleHousing
set Owner_City = PARSENAME(replace(OwnerAddress, ',' , '.'), 2)




Alter table NashvilleHousing
Add OwnerSplitState Nvarchar(255)

Update NashvilleHousing
set OwnerSplitState =PARSENAME(replace(OwnerAddress, ',' , '.'), 1)


Select *
from NashvilleHousing

-------------------------------------------------------------------------------------------------


--Change Y and N to YES and NO in 'Sold as vacant' field

 Select Distinct (SoldAsVacant), COUNT(SoldAsVacant)
from NashvilleHousing
Group by SoldAsVacant
order by 2



Select SoldAsVacant,
Case WHEN SoldAsVacant = 'y' then 'yes'
	 WHEN SoldAsVacant = 'N' then 'NO'
	 Else SoldAsVacant
	 END
from NashvilleHousing

Update NashvilleHousing
SET SoldAsVacant = Case WHEN SoldAsVacant = 'y' then 'yes'
	 WHEN SoldAsVacant = 'N' then 'NO'
	 Else SoldAsVacant
	 END


 ----------------------------------------------------------------------------------------------------
--Remove duplicates


With RowNumCTE as (
Select 
	ROW_NUMBER() over(
	partition by parcelID,
				propertyaddress,
				saleprice,
				saledate,
				Legalreference
				Order by
					uniqueID )
					ROW_num
					
from NashvilleHousing
)
Select *
from RowNumCTE
where ROW_num > 1
order by PropertyAddress

Select *
from NashvilleHousing


-------------------------------------------------------------------------------------------------------------
--Delet unused columns


Select *
from NashvilleHousing

Alter table NashvilleHousing
drop column propertyAddress, saledate,owneraddress, Taxdistrict