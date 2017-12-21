SELECT DISTINCT Tenant.*, A2.countRent  
FROM Tenant 
JOIN (
		SELECT COUNT(*) as countRent, Tenant.ArN, SUM(Contract.PlanDays) AS col_3  FROM Tenant
		JOIN Contract ON Contract.ArN = Tenant.ArN
		GROUP BY
		Tenant.ArN	
		HAVING SUM(Contract.PlanDays) in (
											SELECT  MAX(col) AS countDays FROM Tenant
											JOIN Contract ON Contract.ArN = Tenant.ArN
											JOIN (
												SELECT Tenant.ArN, SUM(Contract.PlanDays) AS col  FROM Tenant
												JOIN Contract ON Contract.ArN = Tenant.ArN
												GROUP BY
													Tenant.ArN	
											)A1 ON A1.ArN = Tenant.ArN
										 )
	) A2 
ON A2.ArN = Tenant.ArN