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