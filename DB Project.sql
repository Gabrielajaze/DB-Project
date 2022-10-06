Create Database lADtop

Use LADtop
/*
b.	Create a database system using DDL syntax that relevant with transaction and purchase.
*/
--ST
Create Table Staff(
	staffID Char(5) Primary Key Check(staffID LIKE 'ST[0-9][0-9][0-9]') NOT NULL,
	staffName Varchar(Max) NOT NULL,
	staffGender Varchar(Max) Check(staffGender IN('Male','Female')) NOT NULL,
	staffEmail Varchar(Max) Check(staffEmail LIKE '%@gmail.com' OR staffEmail LIKE '%@yahoo.com') NOT NULL,
	staffPhoneNumber Varchar(Max) NOT NULL,
	staffAddress Varchar(Max) NOT NULL,
	staffSalary Integer Check(staffSalary BETWEEN 5000000 AND 10000000) NOT NULL	 
) 


--VE
Create Table Vendor(
	vendorID Char(5) Primary Key Check(vendorID LIKE 'VE[0-9][0-9][0-9]') NOT NULL,
	vendorName Varchar(Max) NOT NULL,
	vendorEmail Varchar(Max) CHECK(vendorEmail LIKE '%@gmail.com' OR vendorEmail LIKE '%@yahoo.com') NOT NULL,
	vendorPhoneNumber Varchar(Max) NOT NULL,
	vendorAddress Varchar(Max) NOT NULL
)



--PU
Create Table HeaderPurchase(
	purchaseID Char(5),
	staffID Char(5),
	vendorID Char(5),
	Check(purchaseID LIKE 'PU[0-9][0-9][0-9]'),
	CONSTRAINT purchaseID PRIMARY KEY (purchaseID),
	CONSTRAINT StaffstaffID FOREIGN KEY (staffID) REFERENCES staff(staffID)  ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT VendorvendorId FOREIGN KEY (vendorID) REFERENCES Vendor(vendorID)  ON UPDATE CASCADE ON DELETE CASCADE,
	purchaseDate Date Check(purchaseDate <= Convert(Date, Getdate())) NOT NULL,
)



--LB
Create Table LaptopBrand(
	laptopBrandID Char(5) Primary Key Check(laptopBrandID LIKE 'LB[0-9][0-9][0-9]') NOT NULL,
	laptopBrandName Varchar(Max) NOT NULL	
)

--LA
Create Table Laptop(
	laptopID Char(5) Primary Key Check(laptopID LIKE 'LA[0-9][0-9][0-9]') NOT NULL,
	LaptopBrandlaptopBrandID Char(5) Foreign Key References LaptopBrand(laptopBrandID) NOT NULL,
	laptopName Varchar(Max) NOT NULL,
	laptopPrice Integer Check(laptopPrice > 5000000) NOT NULL	
)


--Detail Purchase
Create Table DetailPurchase(
	purchaseID Char(5),
	laptopID Char(5),
	purchaseQuantity Integer NOT NULL,
	CONSTRAINT PK_DetailPurchase primary key (purchaseID , laptopID),
	CONSTRAINT purchasepurchaseID FOREIGN KEY (purchaseID) REFERENCES HeaderPurchase(purchaseID)  ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT laptoplaptopID FOREIGN KEY (laptopID) REFERENCES laptop(laptopID)  ON UPDATE CASCADE ON DELETE CASCADE
)


--CU
Create Table Customer(	
	customerID Char(5) Primary Key Check(customerID LIKE 'CU[0-9][0-9][0-9]') NOT NULL,
	customerName Varchar(Max) Check(Len(customerName) > 2) NOT NULL,
	customerGender Varchar(6) Check(customerGender IN('Male','Female')) NOT NULL,
	customerAddress Varchar(Max) NOT NULL,
	customerPhoneNumber Varchar(Max) NOT NULL,
	customerEmail Varchar(Max) Check(customerEmail LIKE '%@gmail.com' OR customerEmail LIKE '%@yahoo.com') NOT NULL	
)

--PU
Create Table HeaderTransaction(
	transactionID Char(5),
	staffID Char(5),
	customerID Char(5),
	Check(transactionID LIKE 'TR[0-9][0-9][0-9]'),
	CONSTRAINT transactionID PRIMARY KEY (transactionID),
	CONSTRAINT Staff_staffID FOREIGN KEY (staffID) REFERENCES staff(staffID)  ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT CustomercustomerID FOREIGN KEY (customerID) REFERENCES Customer(customerID )  ON UPDATE CASCADE ON DELETE CASCADE,
	transactionDate Date Check(transactionDate <= Convert(Date, Getdate())) NOT NULL,
)

--Detail Transaction
Create Table DetailTransaction(
	transactionID Char(5),
	laptopID Char(5),
	transactionQuantity Integer NOT NULL,
	CONSTRAINT PK_DetailTransaction primary key (transactionID,laptopID),
	CONSTRAINT TransactiontransactionID FOREIGN KEY (transactionID) REFERENCES HeaderTransaction(transactionID)  ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT Laptop_laptopID FOREIGN KEY (laptopID) REFERENCES laptop(laptopID) ON UPDATE CASCADE ON DELETE CASCADE
)

/*
c.	Create query using DML syntax to fill the tables in database systems with data based on the 
*/

Insert Into LaptopBrand Values 
('LB001', 'Asus'),
('LB002', 'Lenovo'),
('LB003', 'Hp'),
('LB004', 'Samsung'),
('LB005', 'Apple'),
('LB006', 'Acer'),
('LB007', 'MSI'),
('LB008', 'Dell'),
('LB009', 'Razer'),
('LB010', 'Toshiba')

Insert Into Laptop Values
('LA001', 'LB001', 'ASUS TUF GAMING F15 FX506LH', 10999000),
('LA002', 'LB002', 'LENOVO LEGION 5 PRO ', 16599000),
('LA003', 'LB003', 'HP PAVILION GAMING 15', 12199000),
('LA004', 'LB004', 'SAMSUNG CHROMEBOOK 4', 5305000),
('LA005', 'LB005', 'APPLE MACBOOK PRO', 31799000),
('LA006', 'LB006', 'ACER ASPIRE 3 SLIM', 7639000),
('LA007', 'LB007', 'MSI KATANA GF66', 16499000),
('LA008', 'LB008', 'DELL VOSTRO 3401', 6549000),
('LA009', 'LB009', 'RAZER BLADE MID', 49999000),
('LA010', 'LB010', 'TOSHIBA DYNABOOK ', 9350000)

Insert Into Staff Values
('ST001', 'Julio Ben', 'Male', 'julioben@gmail.com', '08236745930', 'Jl. Kombes H.Umar No.45', '8200000'),
('ST002', 'Ariana Callista', 'Female', 'callista11@yahoo.com', '08123124564', 'Jl. Raya Danau Maninjau No. 15 ', '9249000'),
('ST003', 'Evan Kurniawan', 'Male', 'kurniawan20@yahoo.com', '082310223212', 'Jl. Flamboyan Raya No.8C', '8356000'),
('ST004', 'Luka Magic ', 'Male', 'magic.luka77@gmail.com', '085312345601', 'Jl. Jendral Sudirman No.456', '7250000'),
('ST005', 'Angelica Monalisa', 'Female', 'angel20.monalisa@yahoo.com', '082145632000', 'Jl. Soekarno Hatta Lr. H. Binti no 11', '5500000'),
('ST006', 'Sudar Hartono', 'Male', 'sudar0101@gmail.com', '0811123020', 'Jl. Pramuka Raya No.30', '7860000'),
('ST007', 'Thomas Green', 'Male', 'green23@yahoo.com', '082156300124', 'Jl. Adi Sucipto No. 284 (Komplek Transito)', '6550000'),
('ST008', 'Rachell Patricia', 'Female', 'patricia_rachel@yahoo.com', '085644780120', 'Jl. Indro Suratmin no 501', '9500000'),
('ST009', 'Ferry Winata', 'Male', 'ferr921@gmail.com', '081311230897', 'Jl. Letjen MT Haryono Kav 52-53', '5420000'),
('ST010', 'Ana Kristin', 'Female', 'kristin.ana@yahoo.com', '08123697451', 'Jl. Tanggulangin No.3, Keputran', '8420000')

Insert Into Customer Values
('CU001','Charlie Agus','Male','Jl. Prof. Mohammad Yamin No. 17','08234561478','charlie1234@yahoo.com'),
('CU002','Felicia Angelica','Female','Jl. G. Obos No. 10, Menteng','08112345621','angelica.felic200@gmail.com'),
('CU003','Ben Simmons','Male','Jl. Letjend S. Parman No. 21','08451369780','simmonsben21@yahoo.com'),
('CU004','Draymond Brown','Male','Jl. Udayana No. 10, Pejarakan Karya','081356027346','brown291@yahoo.com'),
('CU005','Nita Lee','Female','Jl. Drs. Ahmad Nadjamuddin No. 107','082236450021','lee.nita21@yahoo.com'),
('CU006','Isabella Allin','Female','Jl. Pontingku Komplex Ruko Axuri No. 54','081365412301','isabella99@yahoo.com'),
('CU007','Ezra Quin','Female','Jl. Dr. Sam Ratulangi No. 125 ','081264530011','quinezra@gmail.com'),
('CU008','Romi Hermansyah','Male','Jl. Makugawene No. 05 Kelurahan Tabona','085345451232','romi_herm123@gmail.com'),
('CU009','Lyla Alice','Female','Jl. Cut Nyak Dien No. 16','081300256714','alice201@yahoo.com'),
('CU010','Juan Luiz','Male','Jl. Andi Pangeran Pettarani No. 98','082147563207','luiz_juan@gmail.com')

Insert Into Vendor Values
('VE001', 'CV. Pemindo Multi Sukses', 'pemindosukses@yahoo.com', '08139771450', 'Jl. Tanjung Duren Raya 17A'),
('VE002', 'PT Vortexia Inverta Prosperindo', 'vortexia@gmail.com', '085611230477', 'Mal Ambasador Lt II No.43'),
('VE003', 'CV. Armund Sanolo', 'sanolo1@yahoo.com', '08235674112', 'Ruko Mutiara Taman Palem Blok A18 No. 30'),
('VE004', 'PT Nafiri Elektrindo Persada', 'nafirielektrik@gmail.com', '085341230030', 'Gedung Bellezza BSA Lt.1'),
('VE005', 'PT Maxzer Solusi Steril', 'maxzer291@gmail.com', '081164203615', 'Jl. Karya Barat No.21'),
('VE006', 'CV. Karunia Makmur Persada', 'karunia_makmur@gmail.com', '08116542132', 'Jl.M.Basir No.6A'),
('VE007', 'PT Megamas Plaza Bangunan', 'megamaz99@yahoo.com', '082346598210', 'Jl. Letjend Jamin Ginting KM. 9,5'),
('VE008', 'CV. Gihon Juma Sentosa', 'gihon_juma@yahoo.com', '085613204789', 'Jl. Residen A. Rozak RT/RW. 01/01'),
('VE009', 'PT. Multiplus Medilab', 'multiplus@gmail.com', '081300201456', 'Jl. Danau Marsabut No. 4'),
('VE010', 'CV. Putra Teknik', 'putrateknik291@yahoo.com', '082112022341', 'Jl. Bilal Ujung Komplek Bilal Central Blt')


/*
d.	Create query using DML syntax to simulate the transactions process for transaction and purchase. 
*/

Insert Into HeaderPurchase Values
('PU001','ST005','VE001','2021-08-25'),
('PU002','ST001','VE003','2021-08-28'),
('PU003','ST007','VE004','2021-09-01'),
('PU004','ST002','VE010','2021-09-13'),
('PU005','ST009','VE006','2021-10-09'),
('PU006','ST004','VE005','2021-11-22'),
('PU007','ST010','VE002','2021-12-25'),
('PU008','ST006','VE007','2022-01-13'),
('PU009','ST003','VE008','2022-02-22'),
('PU010','ST008','VE002','2022-03-01'),
('PU011','ST001','VE009','2022-03-27'),
('PU012','ST010','VE005','2022-04-11'),
('PU013','ST002','VE010','2022-04-15'),
('PU014','ST008','VE003','2022-04-21'),
('PU015','ST007','VE001','2022-05-15')

Insert Into DetailPurchase Values
('PU001','LA008',1),
('PU001','LA003',2),
('PU002','LA002',5),
('PU002','LA007',3),
('PU003','LA006',3),
('PU004','LA005',4),
('PU004','LA001',2),
('PU005','LA010',6),
('PU005','LA009',4),
('PU005','LA004',6),
('PU006','LA004',5),
('PU007','LA007',3),
('PU007','LA010',7),
('PU008','LA003',8),
('PU009','LA002',4),
('PU010','LA009',3),
('PU011','LA008',1),
('PU012','LA005',5),
('PU013','LA001',1),
('PU014','LA006',4),
('PU015','LA002',6)

Insert Into HeaderTransaction Values
('TR001','ST005','CU001','2021-08-25'),
('TR002','ST001','CU005','2021-08-28'),
('TR003','ST007','CU002','2021-09-01'),
('TR004','ST002','CU010','2021-09-13'),
('TR005','ST009','CU003','2021-10-09'),
('TR006','ST004','CU004','2021-11-22'),
('TR007','ST010','CU009','2021-12-25'),
('TR008','ST006','CU001','2022-01-13'),
('TR009','ST003','CU006','2022-02-22'),
('TR010','ST008','CU007','2022-03-01'),
('TR011','ST001','CU009','2022-03-27'),
('TR012','ST010','CU005','2022-04-11'),
('TR013','ST002','CU010','2022-04-15'),
('TR014','ST008','CU002','2022-04-21'),
('TR015','ST007','CU007','2022-05-15')


Insert Into DetailTransaction Values
('TR001','LA008',1),
('TR001','LA003',1),
('TR002','LA002',5),
('TR002','LA007',3),
('TR003','LA006',2),
('TR004','LA005',2),
('TR004','LA001',2),
('TR005','LA010',6),
('TR005','LA009',4),
('TR005','LA004',6),
('TR006','LA004',5),
('TR007','LA007',3),
('TR007','LA010',6),
('TR008','LA003',8),
('TR009','LA002',4),
('TR010','LA009',2),
('TR011','LA008',1),
('TR012','LA005',3),
('TR013','LA001',1),
('TR014','LA001',1),
('TR014','LA006',1),
('TR014','LA002',1),
('TR015','LA002',4)

/* 
e.	To support database management process in lADtop, Andra asked you to provide some query that resulting important data. The requirements that asked from him are:
*/

-- No.1
Select Distinct 
	[Customer Name]=CONCAT('Mr. ', cr.customerName), 
	[Customer Gender]=cr.customerGender, 
	[Total Transaction]=COUNT(*)
From Customer cr 
	JOIN HeaderTransaction ti On cr.customerID=ti.customerID
Where 
	cr.customerName LIKE '% %' 
	AND cr.customerGender = 'Male'
Group By cr.customerName, cr.customerGender

-- No.2
Select 
	[LaptopId] = lp.laptopID,
	[LaptopName] = lp.laptopName,
	[LaptopBrandName] = lbd.laptopBrandName,
	[LaptopPrice] = lp.laptopPrice,
	[Total Laptops Sold] = COUNT(*)
From Laptop lp 
	JOIN LaptopBrand lbd On lp.LaptopBrandlaptopBrandID = lbd.laptopBrandID 
	JOIN DetailTransaction ti On lp.laptopID = ti.laptopID
Where 
	lp.laptopPrice > 10000000 
	AND CAST(SUBSTRING(lp.laptopID,3,5) As Int) % 2=0
Group By  lp.laptopPrice, lp.laptopID, lp.laptopName, lbd.laptopBrandName
Having COUNT(*) > 3

-- No.3
Select
	[StaffId] = STUFF(s.staffID, 1, 2, 'Staff'), 
	[StaffName] = s.staffName,
	[Total Transaction Handled] = COUNT(tr.transactionID) , 
	[Maximum Quantity in One Transaction] = COUNT(s.staffID)
From Staff s 
	JOIN HeaderTransaction ti On s.staffID = ti.staffID
	JOIN DetailTransaction tr On ti.transactionID = tr.transactionID
Where 
	DATENAME(MM, transactionDate)= 'April' 
	AND s.staffGender = 'Female' 
Group By  s.staffID, s.staffName,tr.transactionID
Having COUNT(tr.transactionID) > 2

-- No.4
Select 
	[CustomerName] = cr.customerName,
	[CustomerEmail] = cr.customerEmail,
	[Total Purchase] = COUNT(tr.transactionID),
	[Total of Laptop That Has Been Purchased] = COUNT(ti.transactionID)
From Customer cr 
	JOIN HeaderTransaction ti On ti.customerID = cr.customerID 
	JOIN DetailTransaction tr On ti.transactionID = tr.transactionID
Where 
	cr.customerEmail LIKE '%@gmail.com'
Group by  cr.customerName,cr.customerEmail
Having COUNT(ti.transactionID) > 2

-- No.5
Select
	[VendorName] = REPLACE(v.vendorName, 'PT', 'Perseroan Terbatas'),
    [PurchaseDate] = hp.purchaseDate,
    [Laptop ID Number] = RIGHT(l.laptopID, 3),
    [Quantity] = dp.purchaseQuantity
from DetailPurchase dp
	join HeaderPurchase hp on hp.purchaseID = dp.purchaseID
	join Vendor v on v.vendorID = hp.vendorID
	join Laptop l on l.laptopID = dp.laptopID,
 (
	select avg(purchaseQuantity) as Value
	from DetailPurchase
	) as average
where dp.purchaseQuantity > average.value AND v.vendorName LIKE '%e%'

-- No.6

select 
    [Name] = UPPER (Concat ( lb.laptopBrandName , ' ', lt.laptopName )),
    [Price] = concat ('Rp. ', lt.laptopPrice)
from Laptop lt
		join LaptopBrand lb on lb.laptopBrandID = lt.LaptopBrandlaptopBrandID,
	(
	select avg(laptopPrice) as value
	from Laptop 
	) as average
where lt.laptopPrice > average.value and lt.laptopName  like '%e%'


-- No.7
select
	[Laptop ID Number] = RIGHT(l.laptopID, 3),
	[LaptopName] = l.laptopName,
	[Brand] = upper(lb.laptopBrandName),
	[Price] = concat( 'Rp. ', l.laptopPrice),
	[Total Laptop Sold]
from DetailTransaction d
	join laptop l on l.laptopID = d.laptopID
	join LaptopBrand lb on lb.laptopBrandID = l.LaptopBrandlaptopBrandID
	join(
	select 
	dt.transactionID,
	[Total Laptop Sold] = count ( dt.transactionQuantity)
		from DetailTransaction dt,
		(
			select AVG(ag.[Total Laptop Sold]) as a
		from (
					select 
					dt.transactionID,
						[Total Laptop Sold] = count ( dt.transactionQuantity)
					from DetailTransaction dt
					group by dt.transactionQuantity, dt.transactionID
			)as ag
		) as ag
	group by dt.transactionQuantity, ag.a ,dt.transactionID
	having count ( dt.transactionQuantity) > ag.a
	)as ag on d.transactionID = ag.transactionID and  l.laptopPrice > 15000000





				
-- No.8
select
	[Staff First Name] = LEFT(s.staffName,CHARINDEX(' ',s.staffName) - 1),
	[Staff last Name] =  SUBSTRING(s.staffName,CHARINDEX(' ', s.staffName) + 1, LEN(s.staffName) - CHARINDEX(' ', s.staffName)),
	[Total Laptop Sold]
from HeaderTransaction ht
	join staff s on s.staffID = ht.staffID
	join(
	select 
	dt.transactionID,
	[Total Laptop Sold] = count (distinct dt.transactionQuantity)
		from DetailTransaction dt,
		(
			select AVG(ag.[Total Laptop Sold]) as a
		from (
					select 
						dt.transactionID,
						[Total Laptop Sold] = count (distinct dt.transactionQuantity)
					from DetailTransaction dt
					group by dt.transactionID
			)as ag
		) as ag
	group by dt.transactionID, ag.a
	having count (distinct dt.transactionQuantity) > ag.a
	)as ag on ht.transactionID = ag.transactionID and s.staffName like '% %'




-- No.9
CREATE VIEW Vendor_Minimum_Transaction_View
AS
SELECT
	[VendorID] = REPLACE(v.vendorID, 'VE', 'Vendor'),
	[VendorName] = v.vendorName,
	[Total Transaction Handled] = COUNT(dp.purchaseID), 
	[Minimum Quantity in One Transaction] = count(v.vendorID)
FROM Vendor v
	JOIN headerPurchase hp on hp.vendorID= v.vendorID
	join DetailPurchase dp on dp.purchaseID = hp.purchaseID
where month (hp.purchaseDate) = '4'
group by v.vendorID, dp.purchaseID, v.vendorName
Having COUNT(dp.purchaseID) = 1
GO

--No.10
CREATE VIEW Staff_Max_Laptop_Purchased_View
AS
Select
	[StaffName] = s.staffName,
	[StaffEmail] = UPPER(s.staffEmail),
	[TotalPurchase] = count(hp.purchaseID),
	[Maximum Purchase In One Transaction] = COUNT (s.staffID)
from Staff s
	join HeaderPurchase hp on hp.staffID = s.staffID
	join DetailPurchase dt on dt.purchaseID = hp.purchaseID
where s.staffEmail like '%@gmail.com'
group by s.staffID,s.staffEmail,hp.purchaseID,s.staffName
having count(hp.purchaseID) > 2
go

