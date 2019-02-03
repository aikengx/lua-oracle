DSN = "OracleODBC11g"
DBUSER = "ares_rtime_hmo"
DBPASSWORD = "ares123"
DBHOST = "172.20.0.78"
DBPORT = "1521"
luasql = require "luasql.odbc"
--
env = luasql.odbc()
con = env:connect(DSN, DBUSER, DBPASSWORD, DBHOST, DBPORT)
cur = con:execute("SELECT SYSDATE FROM DUAL")
row = cur:fetch({},"a")
DATE = row.SYSDATE;
print (env, con, cur)
print ("El SYSDATE en la BD es => " .. DATE)
cur:close()
con:close()
env:close()
