function connectToDb()
	mysqlConnect = dbConnect("mysql", "dbname=s556_runygg_SQL;host=181.215.45.110;charset=utf8", "u556_H00AQZPROm", "=B32!72k6WjyZ7mLOEBKlN6X")
	if not (mysqlConnect) then
		outputDebugString("Mysql - Eu não conseguir me conectar ao banco de dados.")
	else
		outputDebugString("Mysql - Eu me conectei com sucesso ao MYSQL.")
	end
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), connectToDb, false)

function getConnection()
	return mysqlConnect
end