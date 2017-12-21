SELECT 
	Car.RegNum, Car.Model, 
	SUM((Car.DailyPay*Con.PlanDays)+(Car.DailyPay*Con.OverDays)+(Con.OverDays*Con.Fine)) as Dohod ,
	AVG(Con.PlanDays + Con.OverDays) AS Col, AVG(SUMM) 
FROM Car
JOIN Contract AS Con ON Con.CarN = Car.CarN
CROSS JOIN (
				SELECT Car.RegNum AS C, AVG(Contract.PlanDays + Contract.OverDays) AS SUMM FROM Car
				JOIN Contract ON Contract.CarN = Car.CarN
				GROUP BY Car.RegNum
			) AS D
WHERE	C != Car.RegNum
GROUP BY 	Car.RegNum, Car.Model
HAVING	AVG(Con.PlanDays + Con.OverDays) > AVG(SUMM);



--Slow then first
WITH avgAuto_CTE (RegNum, avgCars)
AS	(
		SELECT Car.RegNum, AVG(Contract.PlanDays + Contract.OverDays) AS avgCars 
		FROM Car
		JOIN Contract ON Contract.CarN = Car.CarN
		GROUP BY Car.RegNum
	)

SELECT *
FROM avgAuto_CTE D
JOIN (
		SELECT CTE1.RegNum as RegNum, AVG(CTE2.avgCars) avgWithOutThisCars
		FROM avgAuto_CTE CTE1
		FULL JOIN avgAuto_CTE CTE2 ON CTE1.RegNum != CTE2.RegNum
		GROUP BY CTE1.RegNum
	 ) R ON D.RegNum = R.RegNum 
JOIN (
		SELECT C.RegNum, C.CarN, SUM((C.DailyPay*Con.PlanDays)+(C.DailyPay*Con.OverDays)+(Con.OverDays*Con.Fine)) as Dohod
		FROM Office O
		JOIN Contract Con ON O.RecN =  Con.GetRecN 
		JOIN Car C ON Con.CarN = C.CarN
		GROUP BY C.RegNum, C.CarN
	 ) K ON D.RegNum = K.RegNum
WHERE  D.avgCars > R.avgWithOutThisCars