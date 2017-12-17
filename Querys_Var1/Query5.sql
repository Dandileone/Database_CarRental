WITH DohodOffice_CTE (RecN, Dohod) 
AS	(
		SELECT O.RecN, SUM((C.DailyPay*Con.PlanDays)+(C.DailyPay*Con.OverDays)+(Con.OverDays*Con.Fine)) as Dohod
		FROM Office O
		JOIN Contract Con ON O.RecN =  Con.GetRecN 
		JOIN Car C ON Con.CarN = C.CarN
		GROUP BY O.RecN
	)	

SELECT *
FROM DohodOffice_CTE D
JOIN (
		SELECT CTE1.RecN as RecN1, AVG(CTE2.Dohod) DohodBezOffica
		FROM DohodOffice_CTE CTE1
		FULL JOIN DohodOffice_CTE CTE2 ON CTE1.RecN != CTE2.RecN
		GROUP BY CTE1.RecN
	 ) R ON D.RecN = R.RecN1 
WHERE  D.Dohod > R.DohodBezOffica