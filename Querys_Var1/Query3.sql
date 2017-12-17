SELECT T1.*, T2.CountUniqCars
FROM Tenant T1
JOIN	(	
			SELECT COUNT(DISTINCT C.CarN) AS CountUniqCars, T.ArN
			FROM Tenant T
			LEFT JOIN Contract Con ON Con.ArN = T.ArN
			LEFT JOIN Car C ON Con.CarN = C.CarN
			GROUP BY T.ArN
		) T2
ON T1.ArN = T2.ArN
