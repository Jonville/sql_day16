-- 3. EMP 테이블에서 가장 많은 사원을 갖는 MGR의 사원번호를 출력하라.
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

-- 5. EMP 테이블에서 사원번호가 7521인 사원의 직업과 같고 사원번호가 7934인 사원의 
--    급여(SAL)보다 많은 사원의 사원번호, 이름, 직업, 급여를 출력하라.
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

-- 6. 직업(JOB)별로 최소 급여를 받는 사원의 정보를 사원번호, 이름, 업무, 부서명을 출력하라.

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
WHERE (JOB, SAL ) IN                -- 두개이상의 컬럼을 한번에 비교하는 방법 ( 컬럼 1, 컬럼 2 )
                    (
                    SELECT JOB , MIN(SAL)
                    FROM EMP
                    GROUP BY JOB
                    )
;

-- 7. 각 사원 별 커미션이 0 또는 NULL이고 부서위치가 ‘GO’로 끝나는 사원의 정보를 
--    사원번호, 사원이름, 커미션, 부서번호, 부서명, 부서위치를 출력하라.
-- 조건1. 보너스가 NULL이면 0으로 출력
SELECT E.EMPNO , E.ENAME , E.DEPTNO , D.DNAME , DECODE(E.COMM , NULL , '0') AS COMM , D.LOC
FROM EMP E
INNER JOIN DEPT D ON E.DEPTNO = D.DEPTNO 
WHERE E.COMM IS NULL AND D.LOC LIKE '%GO'
;

-- 8. 각 부서 별 평균 급여가 2000 이상이면 초과, 그렇지 않으면 미만을 출력하라.
SELECT CASE WHEN AVG_S > 2000 THEN '초과'
            ELSE '미만'
            END AS 급여
            , DEPTNO
FROM  (
        SELECT AVG(SAL) AVG_S , DEPTNO
        FROM EMP
        GROUP BY DEPTNO
        ) 
;

SELECT DEPTNO , CASE WHEN AVG(SAL) > 2000 THEN '초과'
                    ELSE '미만'
                    END AS 평균급여
FROM EMP
GROUP BY DEPTNO
ORDER BY DEPTNO
;