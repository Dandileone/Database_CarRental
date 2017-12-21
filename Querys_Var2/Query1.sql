SELECT T.OffCode, C.RegNum
FROM	(
		SELECT O.OffCode, C.CarN
		FROM Office O
		CROSS JOIN Car C
		EXCEPT
		SELECT O.OffCode, C.CarN
		FROM Office O
		JOIN Contract C ON O.RecN = C.GetRecN
		) T
JOIN Car C ON C.CarN = T.CarN