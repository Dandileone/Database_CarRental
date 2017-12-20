SELECT T.RegNum, T.CarN, T.Dohod, SUM(PlanDays+OverDays)/COUNT(*) AS rentDays
FROM	(	
			SELECT C.RegNum, C.CarN, SUM((C.DailyPay*Con.PlanDays)+(C.DailyPay*Con.OverDays)+(Con.OverDays*Con.Fine)) as Dohod
			FROM Car C
			JOIN Contract Con ON Con.CarN = C.CarN
			GROUP BY C.CarN, C.RegNum
		) T
JOIN Contract C ON T.CarN = C.CarN
GROUP BY T.CarN, T.Dohod, T.RegNum
HAVING	SUM(PlanDays+OverDays)/COUNT(*)>	(
												SELECT SUM(PlanDays+OverDays)/COUNT(*) AS AvgRentDaysLexus
												FROM Car C
												JOIN Contract Con ON C.CarN = Con.CarN
												WHERE Model like 'Lexus RX%'
												GROUP BY C.Model
											)