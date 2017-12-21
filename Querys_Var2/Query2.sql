SELECT DISTINCT O.OffCode, O.City, O.Addr 
FROM Office O
JOIN Contract Con ON Con.GetRecN = O.RecN
JOIN (
		SELECT O.OffCode, COUNT(DISTINCT Con.CarN) AS REG
		FROM Office O
		JOIN Contract Con ON Con.RetRecN = O.RecN
		GROUP BY O.OffCode
		HAVING
		COUNT(DISTINCT Con.CarN) > 1
)AS A1 ON O.OffCode = A1.OffCode