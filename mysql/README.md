# MySQL

* ONLY_FULL_GROUP_BY异常处理
  * SET GLOBAL sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));
