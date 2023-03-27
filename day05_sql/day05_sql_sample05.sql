--! Ư����ҵ��� ���ڷ� �ٲٴ� TO_CHAR !
    -- 1�� 20230327
    -- 2�� 2023/03/27
    -- 3�� 2023-03-27
    -- 4�� 2023-03-27 05:21:01 (����ð�)
    -- 5�� 2023-03-27 17:21:01 (����ð�)
    -- Y M D �� ���н����ش�
SELECT TO_CHAR(SYSDATE, 'YYYYMMDD') AS "1��"            -- ����ð��� ���ڿ��� �����
        ,TO_CHAR(SYSDATE, 'YYYY/MM/DD') "2��"
        ,TO_CHAR(SYSDATE, 'YYYY-MM-DD') "3��"
        ,TO_CHAR(SYSDATE, 'YYYY-MM-DD HH:MI:SS') "4��"       -- ���� MM �̾ƴϰ� MI
        ,TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') "5��"   
FROM DUAL
;

------------------------------------------------------------------------------------

SELECT TO_CHAR(123.456 , 'FM999.99') AS A           -- �Ҽ��� 2��° �ڸ����� ���� / �ݿø� ��
       ,TO_CHAR(123.456 , 'FM0999.99') AS B         -- 9�� �ش� ��ġ�� ���� ��� �����ϰ� ���
       ,TO_CHAR(123.456 , 'FM9999.99') AS C         -- 0�� �ش� ��ġ�� ���� ������ 0���� ä��
       ,TO_CHAR(1234.45 , 'FM9999.9') AS D          -- �ݿø� �ؼ� 1234.5 �� ���
       ,TO_CHAR(10000000 , 'FML99,999,999') AS E    -- 10,000,000 ���� ���
FROM DUAL;

------------------------------------------------------------------------------------

SELECT TO_CHAR(SYSDATE, 'FMMM/DD')      -- 05/26 => 5/6 ===> 0���� ����
FROM DUAL;

------------------------------------------------------------------------------------

SELECT TO_CHAR(SYSDATE, 'YYYY"��" MM"��" DD"��"') AS ��¥      -- �ѱ��� "" �� �����ش�.
      ,TO_CHAR(SYSDATE, 'HH24"��" MI"��" SS"��"') AS �ð�
FROM DUAL;

------------------------------------------------------------------------------------

SELECT TO_CHAR(SYSDATE, 'AM')       --�����̳� ���ĳ� ���
      ,TO_CHAR(SYSDATE, 'D')        --1(�Ͽ���) ~ 7(�����)
      ,TO_CHAR(SYSDATE, 'DY')       -- �� ǥ��
      ,TO_CHAR(SYSDATE, 'DAY')      -- ���������
      ,TO_CHAR(SYSDATE, 'DDD')      --365�ϱ���
      ,TO_CHAR(SYSDATE, 'WW')       --1����� ���� ��������
      ,TO_CHAR(SYSDATE, 'MON')      --�������
FROM DUAL;

------------------------------------------------------------------------------------

-- 1980�� ~1982�� ���̿� �Ի�� �� �μ��� �����, �μ���ȣ, �μ���, �Ի�⵵�� ����϶�
SELECT D.DNAME , D.DEPTNO , 
       COUNT(DECODE(TO_CHAR(E.HIREDATE, 'YYYY'), '1980' , 1)) "�Ի� 1980"
       ,COUNT(DECODE(TO_CHAR(E.HIREDATE, 'YYYY'), '1981' , 1)) "�Ի� 1981"
       ,COUNT(DECODE(TO_CHAR(E.HIREDATE, 'YYYY'), '1982' , 1)) "�Ի� 1982"
FROM EMP E
INNER JOIN DEPT D ON D.DEPTNO = E.DEPTNO
GROUP BY D.DNAME , D.DEPTNO