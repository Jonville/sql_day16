-- DECODE , CASE ~ WHEN
-- ������ , ���ν��� , ��

-- DECODE ( IF ���� ���� ) 
-- ���� �ش��� �Ǹ� DECODE �÷��� �߰��ؼ� ��½����ش�.

if(STU_GENDER.equals("M") {
    System.out.println("����");
} else if(STU_GENDER.equals("F") {
    System.out.println("����");
} else {
    System.out.println("�˼�����");
}       // �̷������� �Ǿ��ִ°� DECODE �� �����Ų��.
;

SELECT STU_NAME, DECODE (STU_GENDER, 'M','����','F','����','��Ÿ') AS ����      -- M, F �� ������ ��Ÿ�� ����Ѵٴ� ��
FROM STUDENT
;

SELECT ENAME , DEPTNO , 
                     DECODE (DEPTNO , '10' , 'NEW YORK'
                                    , '20' , 'DALLAS' 
                                    , '30' , 'CHICAGO' 
                                   , '40' , 'BOSTON' ) AS ����
FROM EMP
;

-- CASE WHEN ( SWITCH CAS �� IF �� ���� ���� )      �� ģ�� ���� ���� DECODE ����
-- CASE WHEN ����  THEN ��� (ELSE) ~~ END
SELECT CASE WHEN STU_GENDER = 'M' THEN '����'
            WHEN STU_GENDER = 'F' THEN '����' 
            ELSE '����'       -- ��������
        END AS GENDER   -- ����      -- �ѱ� ������ ���� ���� ���������� ����� ����
        , STU_NAME
FROM STUDENT
;

-- EMP ���̺��� �μ���ȣ�� 10�� ������� �μ���ȣ�� 30�� ������� ���� ����϶�.
 -- ���ڵ� �Ѱ���
 SELECT * FROM EMP;
 
SELECT COUNT(DEPTNO) , DEPTNO 
FROM EMP
WHERE DEPTNO = '10' OR DEPTNO = '30'
GROUP BY DEPTNO
;

SELECT
    SUM(DECODE(DEPTNO, 10, 1)) "DEPT10 �����",
    SUM(DECODE(DEPTNO, 30, 1)) "DEPT30 �����"
FROM EMP
;

SELECT
    COUNT(DECODE(DEPTNO, 10, 1)) DEPT10,
    COUNT(DECODE(DEPTNO, 30, 1)) DEPT30
FROM EMP
;

--------------------------------------------------------------------

-- GROUP BY �׷��Լ��� WHERE �� (������) �ټ�����
-- �׷���

SELECT COUNT(*) , DEPTNO 
FROM EMP
WHERE COUNT(*) > 4 
GROUP BY DEPTNO
;                 -- �̷��� WHERE �� ���ǹ��� �ټ�����.

SELECT COUNT(*) , DEPTNO 
FROM EMP
GROUP BY DEPTNO
HAVING COUNT(*) > 4        -- HAVING ���� �ָ� �����ϴ� ! ���� !
                            -- HAVING ���ǹ�  =  WHERE ���ǹ� 
;

-----------------------------------------------------------------

-- EMP ���̺��� ���� ���� ����� �����ִ� �μ���ȣ�� ������� ����϶�.

SELECT * 
FROM EMP
;

SELECT COUNT(*) , DEPTNO
FROM EMP
GROUP BY DEPTNO
HAVING COUNT(*) = (             -- HAVING ���� ��Ī�� ����
                  SELECT MAX(COUNT(*))
                  FROM EMP
                  GROUP BY DEPTNO
                  )
;