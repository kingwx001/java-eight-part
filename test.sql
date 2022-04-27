4、根据题目要求，写出对应的sql
雇员表：employee
+-------+-------+-----+-----+
| EmpId | Name  | sex | age |
+-------+-------+-----------+
| 1     | 张鹏  | 男  | 25  |
| 2     | 张晓  | 女  | 20  |
| 3     | 王明  | 男  | 22  |
| 4     | 王刚  | 男  | 24  |
| 6     | 彭飞  | 男  | 18  |
+-------+-------+-----+-----+
销售表：sal
+-------+--------------+-----+-----+---------+
| EmpId |product       |price|count|   date  |
+-------+--------------+-----------+---------+
| 1     | 遥控飞机A 款 |1000 | 1   |20190520 |
| 2     | 遥控汽车     |600  | 1   |20190601 |
| 2     | 遥控飞机B 款 |800  | 1   |20190530 |
| 3     | 玩具枪       |100  | 2   |20190510 |
| 4     | 儿童自行车   |300  | 1   |20190520 |
+-------+--------------+-----+-----+---------+
问题1：查年龄大于 20 以上的员工信息

select * from employee where age > 20;

问题2：统计每个人的销售额

select a.EmpId,a.name,nvl(b.sum_price,0) from employee a left join (select EmpId,sum(price * count) sum_price from sal group by EmpId) b where a.EmpId = b.EmpId;

问题3：统计5月份销售额为0的员工信息

select from employee where EmpId not in (select distinct EmpId from sal where to_char(date,'yymm') = '201905');

-- 外连接：左连接（左边为主表，主表每一行都显示）


5、某班学生表和考试成绩表分别如下：
表student：
+-------+--------------+
| ID    |   Name       |
+-------+--------------+
| 1     | Jack         |
| 2     | Marry        |
| 3     | Rose         |
| 4     | Bob          |
| 5     | john         |
| 6     | Betty        |
| 7     | Robert       |
+-------+--------------+
表：Achievement
+-------+----------+
| ID    | score    |
+-------+----------+
| 1     | 90       |
| 2     | 96       |
| 3     | 88       |
| 4     | 86       |
| 5     | 83       |
| 6     | 83       |
+-------+----------+
其中 ID为学生的编号，Name 为姓名，Mark 为成绩，请针对以下问题，写出相应的 sql语句：
1、请查询成绩>85分的学生的姓名；

select s.name from student s join Achievement a on a.score > 85 and s.ID = a.ID;

2、请查询成绩>=90分的人数：

select count(1) from Achievement where score >= 90;

3、Robert 此次考试考了80分，但是成绩没能录入表中，请将其成绩添加进去；

insert into score values((select ID from student),80);

4、请将Rose 的成绩修改为 87；

update Achievement set score = 87 where ID = (select ID from student where Name = 'Rose');

5、请删除 Betty 的记录；

delete from student s,Achievement a where s.ID = a.ID and s.Name = 'Betty';

6. 查询出分数为 83 且姓名首字母为B开头的学生;

select  s.ID,s.Name from student s,Achievement a where s.ID = a.ID and s.Name like 'B%' and a.score = 83;