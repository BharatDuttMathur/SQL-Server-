create table DateDimension(
[Date] Date,
[Day_of_month] int,
[Day_name] nvarchar(15),
[Day_of_week] nvarchar(15),
[Day_of_year] nvarchar(15),
[Quater_Number] nvarchar(15),
[Week_of_year] nvarchar(15),
[Month] nvarchar(15),
[Month_name] nvarchar(15),
[Day_of_Quater] nvarchar(15),
[Year] int,
[Week_of_Month] int,
[Week_of Quarter] int,
[Month_year] nvarchar(15),
[First_Day_of_Month] DATE,
[Last_Day_of_Month] DATE,
[First_Day_of_Quater] DATE,
[Last_Day_of_Quater] DATE,
[First_Day_of_Year] DATE,
[Last_Day_of_Year] DATE,
[Fiscal_Year] varchar(50),
[Fiscal_Year_Month] int,
[Fiscal_Year_Month_Name] nvarchar(15),
[Fiscal_Year_Week] nvarchar(15),
[Fiscal_Year_Day] nvarchar(15),
[Fiscal_Year_Day_Name] nvarchar(15),
[Fiscal_Year_Day_of_Week] nvarchar(15),
[Fiscal_Year_Quater_Number] int,
[Fiscal_Year_Day_of_Quater] nvarchar(15),
[Fiscal_Year_First_Day_of_Month] DATE,
[Fiscal_Year_Last_Day_of_Month] DATE,
[Fiscal_Year_First_Day_of_Quater] DATE,
[Fiscal_Year_Last_Day_of_Quater] DATE,
[Fiscal_Year_First_Day_of_Year] DATE,
[Fiscal_Year_Last_Day_of_Year] DATE,
[Is_Weekday] nvarchar(15)
)




DECLARE @startdate date = '2020-3-20' ,
        @enddate date = '2020-4-5' 
        ;
		DECLARE @Date  DATETIME = @StartDate

		DECLARE @Day_of_week INT,
				@Day_of_month INT,
				@Day_of_year INT,
				@Day_name NVARCHAR(20),
				@Month_name NVARCHAR(20),
				@Quater_Number INT,
				@Year INT,
				@Month INT,
				@Week_of_year INT,
				@Day_of_Quater INT,
				@Week_of_Quarter INT,
				@Week_of_Month INT,
				@Month_year NVARCHAR(20),
				@First_Day_of_Month DATE,
				@First_Day_of_Quater DATE,
				@First_Day_of_Year DATE,
				@Last_Day_of_Year DATE,
				@Last_Day_of_Month DATE,
				@Last_Day_of_Quater DATE,
				@Fiscal_Year_Month_Name NVARCHAR(20),
				@Fiscal_Year_Day_Name NVARcHAR(20),
				@Fiscal_Year INT,
				@Fiscal_Year_Month INT,
				@Fiscal_Year_Week INT,
				@Fiscal_Year_Day INT,
				@Fiscal_Year_Day_of_Week INT,
				@Fiscal_Year_Quater_Number INT,
				@Fiscal_Year_Day_of_Quater INT,
				@Fiscal_Year_First_Day_of_Month DATE,
				@Fiscal_Year_Last_Day_of_Month DATE,
				@Fiscal_Year_First_Day_of_Quater DATE,
				@Fiscal_Year_Last_Day_of_Quater DATE,
				@Fiscal_Year_First_Day_of_Year DATE,
				@Fiscal_Year_Last_Day_of_Year DATE,
				@Is_Weekday NVARCHAR(20)


WHILE (@Date < @EndDate)
	begin
		SET @Month = DATEPART(MM, @Date)
		SET @Year = DATEPART(YY, @Date)
		SET @Day_of_week = DATEPART(DW, @Date)
		SET @Day_of_month = DATEPART(DD, @Date)
		SET @Day_of_year = DATEPART(DY, @Date)
		SET @Week_of_year = DATEPART(WW, @Date)
		SET @Quater_Number = DATEPART(QQ, @Date)
		SET @Month_name = DATENAME(MM, @Date)
		SET @Day_name = DATENAME(DW, @Date)
		SET @Week_of_Quarter = (DATEDIFF(DD, DATEADD(QQ, DATEDIFF(QQ, 0, @Date), 0), @Date) / 7) + 1 
		SET @Week_of_Month = DATEDIFF(WW, DATEADD(MONTH, DATEDIFF(MONTH, 0, @Date), 0), @Date) +1
		SET @Month_year = DATENAME(MM, @Date) + '-' + CONVERT(VARCHAR,DATEPART(YY, @Date))
		SET @Day_of_Quater = DATEDIFF(dd, DATEADD(QQ, DATEDIFF(QQ, 0, @DATE), 0), @DATE) + 1 
		SET @First_Day_of_Quater = DATEADD(QQ, DATEDIFF(QQ, 0, @Date), 0)
		SET @First_Day_of_Month = DATEADD(MM, DATEDIFF(MM, 0, @date), 0)
		SET @First_Day_of_Year = DATEADD(YY, DATEDIFF(YY, 0, @date), 0)
		SET @Last_Day_of_Year = DATEADD(YY, DATEDIFF(YY, 0, @date) + 1, -1)
		SET @Last_Day_of_Month = DATEADD(d, -1, DATEADD(m, DATEDIFF(m, 0, @date) + 1, 0))
		SET @Last_Day_of_Quater = DATEADD(QQ,DATEDIFF(QQ,-1,@date),-1) 
		SET @Fiscal_Year_Day_Name = DATENAME(DW, @Date)
		SET @Fiscal_Year_Month_Name = DATENAME(MM, @Date)
		SET @Fiscal_Year = CASE WHEN DATEPART(MM,@date) > 3 THEN DATEPART(yy,@date) ELSE DATEPART(yy,@date)-1 END
		SET @Fiscal_Year_Month = CASE WHEN DATEPART(MM,@date) > 3 THEN DATEPART(MM, @Date)-3 ELSE DATEPART(MM, @Date)+9 END
		SET @Fiscal_Year_Week = CASE WHEN DATEPART(MM,@date) > 3 THEN DATEPART(WW, @Date)-13 ELSE DATEPART(WW, @Date)+40 END
		SET @Fiscal_Year_Day = CASE WHEN DATEPART(MM,@date) > 3 THEN DATEPART(DY, @Date)-91 ELSE DATEPART(DY, @Date)+275 END
		SET @Fiscal_Year_Day_of_Week = DATEPART(DW, @Date)
		SET @Fiscal_Year_Quater_Number = CASE WHEN DATEPART(MM,@date) > 3 THEN DATEPART(QQ, @Date)-1 ELSE DATEPART(QQ, @Date)+3 END
		SET @Fiscal_Year_Day_of_Quater = CASE WHEN DATEPART(MM,@date) > 3 THEN DATEDIFF(dd, DATEADD(QQ, DATEDIFF(QQ, 0, @DATE), 0), @DATE)+1   ELSE DATEDIFF(dd, DATEADD(QQ, DATEDIFF(QQ, 0, @DATE), 0), @DATE) + 1 END
		SET @Fiscal_Year_First_Day_of_Month =  DATEADD(MM, DATEDIFF(MM, 0, @date), 0)
		SET @Fiscal_Year_Last_Day_of_Month = DATEADD(d, -1, DATEADD(m, DATEDIFF(m, 0, @date) + 1, 0))
		
		SET @Fiscal_Year_First_Day_of_Quater = DATEADD(QQ, DATEDIFF(QQ, 0, @Date), 0)
		SET @Fiscal_Year_Last_Day_of_Quater =  DATEADD(QQ,DATEDIFF(QQ,-1,@date),-1) 
		SET @Fiscal_Year_First_Day_of_Year = DATEADD(mm,DATEDIFF(mm,0,GETDATE())-8,0) 
		SET @Fiscal_Year_Last_Day_of_Year = DATEADD(mm,DATEDIFF(mm,0,GETDATE())-8,-1)
		SET @Is_Weekday = CASE DATEPART(DW, @Date) WHEN 1 THEN 'WEEKDAY' WHEN 7 THEN 'WEEKDAY' else 'NOT A WEEKDAY' END
		INSERT INTO DateDimension (   [Date] 
									, [Month] 
									, [Year]
									, [Day_of_month]
									, [Day_of_week]
									, [Day_of_year]
									, [Week_of_year]
									, [Quater_Number]
									, [Month_name]
									, [Day_name]
									, [Week_of Quarter] 
									, [Week_of_Month]
									, [Month_year]  
									, [Day_of_Quater]
									, [First_Day_of_Quater]  
									, [First_Day_of_Month]
									, [First_Day_of_Year]
									, [Last_Day_of_Year]
									, [Last_Day_of_Month] 
									, [Last_Day_of_Quater]
									, [Fiscal_Year_Month_Name]
									, [Fiscal_Year_Day_Name] 
									, [Fiscal_Year]  
									, [Fiscal_Year_Month]
									, [Fiscal_Year_Week]
									, [Fiscal_Year_Day] 
									, [Fiscal_Year_Day_of_Week]  
									, [Fiscal_Year_Quater_Number]
									, [Fiscal_Year_Day_of_Quater] 
									, [Fiscal_Year_First_Day_of_Month] 
									, [Fiscal_Year_Last_Day_of_Month] 
									, [Fiscal_Year_First_Day_of_Quater]
									, [Fiscal_Year_Last_Day_of_Quater] 
									, [Fiscal_Year_First_Day_of_Year]
									, [Fiscal_Year_Last_Day_of_Year]
									, [Is_Weekday]  )
									
		values(   @Date
				, @Month
				, @Year
				, @Day_of_month
				, @Day_of_week
				, @Day_of_year
				, @Week_of_year
				, @Quater_Number
				, @Month_name
				, @Day_name
				, @Week_of_Quarter 
				, @Week_of_Month
				, @Month_year 
				, @Day_of_Quater
				, @First_Day_of_Quater  
				, @First_Day_of_Month
				, @First_Day_of_Year
				, @Last_Day_of_Year
				, @Last_Day_of_Month
				, @Last_Day_of_Quater
				, @Fiscal_Year_Month_Name
				, @Fiscal_Year_Day_Name  
				, @Fiscal_Year  
				, @Fiscal_Year_Month
				, @Fiscal_Year_Week  
				, @Fiscal_Year_Day  
				, @Fiscal_Year_Day_of_Week 
				, @Fiscal_Year_Quater_Number
				, @Fiscal_Year_Day_of_Quater 
				, @Fiscal_Year_First_Day_of_Month 
				, @Fiscal_Year_Last_Day_of_Month 
				, @Fiscal_Year_First_Day_of_Quater 
				, @Fiscal_Year_Last_Day_of_Quater 
				, @Fiscal_Year_First_Day_of_Year
				, @Fiscal_Year_Last_Day_of_Year 
				, @Is_Weekday  )
				
		
	
		SET @Date = DATEADD(DD, 1, @Date)		
	end


	select * from DateDimension

	delete DateDimension


	