SELECT Car.*, C.GetData
FROM Car
JOIN	(	
			SELECT B1.CarN, B1.GetData
			FROM (	SELECT DISTINCT CarN, GetData
					FROM Contract
					WHERE YEAR(GetData) != YEAR(getdate())
				 ) B1
			JOIN ( 
					SELECT DISTINCT CarN, GetData
					FROM Contract 
					WHERE YEAR(GetData) = YEAR(getdate())
				 ) B2 
			ON B1.CarN != B2.CarN
		) C 
ON Car.CarN = C.CarN

--faster then first query
SELECT Distinct Car.*, Contract.GetData
FROM Car 
JOIN Contract ON Contract.CarN = Car.CarN 
LEFT JOIN	( 
				SELECT CarN, GetData FROM [Contract] 
				WHERE YEAR(GetData) = YEAR(GETDATE()) 
			) A1 ON 
A1.CarN = Car.CarN 
WHERE	A1.CarN is NULL 
	AND 
		YEAR(Contract.GetData) <> YEAR(GETDATE())