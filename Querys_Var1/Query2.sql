SELECT DISTINCT Office.* 
FROM Office 
JOIN Contract ON Contract.RetRecN = Office.RecN 
JOIN Car ON Car.CarN = Contract.CarN 
JOIN	( 
			SELECT Car.CarN, OffCode 
			FROM Contract 
			JOIN Office ON Office.RecN = Contract.GetRecN 
			JOIN Car ON Car.CarN = Contract.CarN 
		) A1 
ON A1.CarN <> Car.CarN 
WHERE Contract.RetRecN <> Contract.GetRecN