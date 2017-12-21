WITH CountRentCarsOffice_CTE (RecN, CountRentCar, Dohod) 
AS	(
		SELECT O.RecN, COUNT(DISTINCT C.CarN) AS CountRentCar, SUM((C.DailyPay*Con.PlanDays)+(C.DailyPay*Con.OverDays)+(Con.OverDays*Con.Fine)) as Dohod
		FROM Office O
		JOIN Contract Con ON O.RecN =  Con.GetRecN 
		JOIN Car C ON Con.CarN = C.CarN
		GROUP BY O.RecN
	)

SELECT MAX(CountRentCar) CountRentCar, CCTE.RecN, CRC.CountRentContract, Dohod
FROM CountRentCarsOffice_CTE CCTE
JOIN (	SELECT O.RecN, COUNT(Con.ArN) AS CountRentContract
		FROM Office O
		JOIN Contract Con ON O.RecN =  Con.GetRecN 
		GROUP BY O.RecN
	 ) CRC ON 
CCTE.RecN = CRC.RecN
GROUP BY CCTE.RecN, CRC.CountRentContract, Dohod
HAVING MAX(CountRentCar) > = (
								SELECT MAX(CountRentCar)
								FROM(	
										SELECT *
										FROM CountRentCarsOffice_CTE
									) K
							 )
							 
							 
--this query faster then first
----------------------------------------------------------
WITH CountRentCarsOffice_CTE (OffCode, City, Addr, RecN, CountRentCar, Dohod, CountRentContract) 
AS	(
		SELECT O.OffCode, O.City, O.Addr, O.RecN, COUNT(DISTINCT C.CarN) AS CountRentCar, SUM((C.DailyPay*Con.PlanDays)+(C.DailyPay*Con.OverDays)+(Con.OverDays*Con.Fine)) as Dohod, COUNT(Con.ArN) as CountRentContract
		FROM Office O
		JOIN Contract Con ON O.RecN =  Con.GetRecN 
		JOIN Car C ON Con.CarN = C.CarN
		GROUP BY O.RecN, O.OffCode, O.City, O.Addr
	)

SELECT MAX(CountRentCar) CountRentCar, CCTE.RecN, Dohod, CCTE.CountRentContract, OffCode, City, Addr 
FROM CountRentCarsOffice_CTE CCTE
GROUP BY CCTE.RecN, Dohod, CCTE.CountRentContract, OffCode, City, Addr
HAVING MAX(CountRentCar) > = (
								SELECT MAX(CountRentCar)
								FROM(	
										SELECT *
										FROM CountRentCarsOffice_CTE
									) K
							 )