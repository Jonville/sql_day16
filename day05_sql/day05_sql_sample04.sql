-- 3. EMP ���̺��� ���� ���� ����� ���� MGR�� �����ȣ�� ����϶�.
SELECT COUNT(*) , MGR
FROM EMP
GROUP BY MGR
HAVING COUNT(*) =
            (
            SELECT CNT
            FROM 
                    (
                    SELECT COUNT(*) AS CNT , MGR
                    FROM EMP
                    GROUP BY MGR
                    ORDER BY CNT DESC
                    )
            WHERE ROWNUM = 1
            )
;

SELECT MGR , COUNT(MGR)
FROM EMP
GROUP BY MGR
HAVING COUNT(MGR) =
                (
                SELECT MAX(COUNT(*))
                FROM EMP
                GROUP BY MGR
                )
;

-- 5. EMP ���̺��� �����ȣ�� 7521�� ����� ������ ���� �����ȣ�� 7934�� ����� 
--    �޿�(SAL)���� ���� ����� �����ȣ, �̸�, ����, �޿��� ����϶�.
SELECT EMPNO, ENAME, JOB, SAL
FROM EMP
WHERE JOB =
        (
        SELECT JOB
        FROM EMP
        WHERE EMPNO = 7521
        )
AND SAL >
        (
        SELECT SAL FROM EMP
        WHERE EMPNO = 7934
        )
;

-- 6. ����(JOB)���� �ּ� �޿��� �޴� ����� ������ �����ȣ, �̸�, ����, �μ����� ����϶�.

SELECT *
FROM EMP E
INNER JOIN DEPT D ON E.DEPTNO = D.DEPTNO
INNER JOIN
         (
         SELECT MIN(SAL) AS MIN_S, JOB
         FROM EMP
         GROUP BY JOB               
         ) A ON A.MIN_S = E.SAL AND E.JOB = A.JOB
;

SELECT *
FROM EMP
WHERE (JOB, SAL ) IN                -- �ΰ��̻��� �÷��� �ѹ��� ���ϴ� ��� ( �÷� 1, �÷� 2 )
                    (
                    SELECT JOB , MIN(SAL)
                    FROM EMP
                    GROUP BY JOB
                    )
;

-- 7. �� ��� �� Ŀ�̼��� 0 �Ǵ� NULL�̰� �μ���ġ�� ��GO���� ������ ����� ������ 
--    �����ȣ, ����̸�, Ŀ�̼�, �μ���ȣ, �μ���, �μ���ġ�� ����϶�.
-- ����1. ���ʽ��� NULL�̸� 0���� ���
SELECT E.EMPNO , E.ENAME , E.DEPTNO , D.DNAME , DECODE(E.COMM , NULL , '0') AS COMM , D.LOC
FROM EMP E
INNER JOIN DEPT D ON E.DEPTNO = D.DEPTNO 
WHERE E.COMM IS NULL AND D.LOC LIKE '%GO'
;

-- 8. �� �μ� �� ��� �޿��� 2000 �̻��̸� �ʰ�, �׷��� ������ �̸��� ����϶�.
SELECT CASE WHEN AVG_S > 2000 THEN '�ʰ�'
            ELSE '�̸�'
            END AS �޿�
            , DEPTNO
FROM  (
        SELECT AVG(SAL) AVG_S , DEPTNO
        FROM EMP
        GROUP BY DEPTNO
        ) 
;

SELECT DEPTNO , CASE WHEN AVG(SAL) > 2000 THEN '�ʰ�'
                    ELSE '�̸�'
                    END AS ��ձ޿�
FROM EMP
GROUP BY DEPTNO
ORDER BY DEPTNO
;