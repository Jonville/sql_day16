SELECT * FROM EMP;
-- 사원 테이블
-- EMPNO =  사원번호 , MGR = 사수의 사원번호 , HIREDATE = 입사날짜 
--  SAL = 급여 , COMM = 보너스 , DEPTNO = 부서번호

SELECT * FROM DEPT;
-- 부서 테이블
-- DNAME = 부서명 , LOC = 구역

SELECT * FROM SALGRADE;
-- 급여 테이블
-- GRADE = 등급 , LOSAL = 최저 급여 , HISAL 최대 급여


-- 셀프 조인 하는방법
SELECT E.EMPNO , E.ENAME , E2.ENAME
FROM EMP E
INNER JOIN EMP E2 ON E.MGR = E2.EMPNO
;


-----------------------------------------------------------------
--1
SELECT *
FROM EMP
ORDER BY SAL DESC;      -- ASC 오름차순, DESC 내림차순

--2
SELECT COUNT(*) , DEPTNO
FROM EMP  
GROUP BY DEPTNO
;

--3

SELECT AVG(SAL)
FROM EMP
WHERE JOB = 'SALESMAN'
;

--4

SELECT *
FROM EMP
WHERE COMM IS NOT NULL        -- SELECT COUNT(COMM) FROM EMP ; 로도 가능
;               

--5
SELECT ROUND(AVG(COMM),2)
FROM EMP
WHERE COMM IS NOT NULL        
;

--6
SELECT *
FROM EMP
WHERE EMPNO LIKE '77%'
;

--7
SELECT DISTINCT D.LOC , D.DEPTNO
FROM DEPT D
INNER JOIN EMP E ON D.DEPTNO = E.DEPTNO
WHERE D.DEPTNO = 10
ORDER BY D.DEPTNO ASC
;

SELECT *
FROM (
        SELECT COUNT(*) AS CNT, E.DEPTNO , D.LOC
        FROM EMP E
        INNER JOIN DEPT D ON E.DEPTNO = D.DEPTNO 
        GROUP BY E.DEPTNO , D.LOC
        ORDER BY CNT
        )
WHERE ROWNUM = 1
;


--7.2 반대로

SELECT *
FROM    
        (
        SELECT COUNT(*) , E.DEPTNO , D.LOC
        FROM EMP E
        INNER JOIN DEPT D ON E.DEPTNO = D.DEPTNO
        GROUP BY E.DEPTNO , D.LOC
        ORDER BY DEPTNO DESC
        )
WHERE ROWNUM = 1
;

--8
SELECT *
FROM EMP E
INNER JOIN EMP E2 ON E.MGR = E2.EMPNO
WHERE E2.ENAME = 'BLAKE'
;

--9 

SELECT *
FROM EMP E
INNER JOIN EMP E2 ON E.MGR = E2.EMPNO
WHERE E2.ENAME = 'KING'
;
--10

SELECT DISTINCT LOC , D.DEPTNO , E.JOB
FROM DEPT D
INNER JOIN EMP E ON D.DEPTNO = E.DEPTNO
WHERE E.JOB = 'SALESMAN'

;

SELECT COUNT(*) , E.DEPTNO , D.LOC 
FROM EMP E
INNER JOIN DEPT D ON E.DEPTNO = D.DEPTNO
WHERE JOB = 'SALESMAN'
GROUP BY E.DEPTNO , D.LOC
;

--11

SELECT *
FROM EMP
WHERE SAL >
        (
         SELECT AVG(SAL) AS AVG_S
        FROM EMP
        )
;

--번외편
-- 부서 평균 급여가 가장 적은 곳의 위치 구하기.
SELECT *
FROM
    (
    SELECT AVG(SAL) AS AVG_SAL , DEPTNO
    FROM EMP
    GROUP BY DEPTNO
    ORDER BY AVG_SAL ASC
    ) A
INNER JOIN DEPT D ON A.DEPTNO = D.DEPTNO
WHERE ROWNUM = 1
;

--13. 각 사람들의 급여 등급
SELECT *
FROM EMP E
INNER JOIN SALGRADE S ON E.SAL >= S.LOSAL AND E.SAL <= S.HISAL
;

SELECT E.ENAME , E.SAL , S.LOSAL , S.HISAL,  S.GRADE
FROM EMP E
INNER JOIN SALGRADE S ON E.SAL BETWEEN S.LOSAL AND S.HISAL      -- JOIN 안에 조건문으로 줄수도있음
;

