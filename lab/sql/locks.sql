-- 非唯一索引表
CREATE TABLE `tlocks` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `cid` bigint(20) DEFAULT NULL,
  `state` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `tlocks_state_index` (`state`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- insert 插入式默认等锁时间 50s
-- show variables like 'innodb_lock_wait_timeout'
-- 修改
-- set innodb_lock_wait_timeout = 5;

-- 查看表锁情况
-- select * from information_schema.innodb_locks \G;
-- select * from information_schema.innodb_trx \G;

-- 间隙锁真是个神奇的存在！！！

-- Session 1
-- set autocommit = 0;
-- begin
-- select * from tlocks where state = 0 for update;
-- id
-- select * from tlocks where state = 0 for update;
-- range
-- select * from tlocks where id in (10) and state = 0 for update;
-- select * from tlocks where id < 10 and state = 0 for update;
-- rollback

-- Session 2
-- 数据插入
-- set innodb_lock_wait_timeout = 5;
-- insert tlocks (cid, state) values (1, 0);