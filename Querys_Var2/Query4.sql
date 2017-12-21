SELECT	Office.OffCode, 
		Office.City, Office.Addr, 
		COUNT(DISTINCT Car.Model) AS countModelCars 
FROM Office
JOIN Contract ON Contract.GetRecN = Office.RecN
JOIN Car ON Car.CarN = Contract.CarN
JOIN (
		SELECT DISTINCT Contract.RetRecN 
		FROM Contract
		JOIN Car ON Car.CarN = Contract.CarN
		WHERE Car.Model like 'BMW%'
	 ) AS D 
ON D.RetRecN = Office.RecN
GROUP BY Office.OffCode, Office.City, Office.Addr