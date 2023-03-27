-- DECODE , CASE ~ WHEN
-- 시퀀스 , 프로시저 , 뷰

-- DECODE ( IF 문과 같음 ) 
-- 값이 해당이 되면 DECODE 컬럼에 추가해서 출력시켜준다.

if(STU_GENDER.equals("M") {
    System.out.println("남자");
} else if(STU_GENDER.equals("F") {
    System.out.println("여자");
} else {
    System.out.println("알수없음");
}       // 이런식으로 되어있는걸 DECODE 로 적용시킨다.
;

SELECT STU_NAME, DECODE (STU_GENDER, 'M','남자','F','여자','기타') AS 성별      -- M, F 가 없으면 기타를 출력한다는 뜻
FROM STUDENT
;

SELECT ENAME , DEPTNO , 
                     DECODE (DEPTNO , '10' , 'NEW YORK'
                                    , '20' , 'DALLAS' 
                                    , '30' , 'CHICAGO' 
                                   , '40' , 'BOSTON' ) AS 지역
FROM EMP
;

-- CASE WHEN ( SWITCH CAS 와 IF 문 섞은 느낌 )      이 친구 많이 쓰임 DECODE 보다
-- CASE WHEN 조건  THEN 결과 (ELSE) ~~ END
SELECT CASE WHEN STU_GENDER = 'M' THEN '남자'
            WHEN STU_GENDER = 'F' THEN '여자' 
            ELSE '몰라'       -- 생략가능
        END AS GENDER   -- 성별      -- 한글 변수를 쓰면 오류 날수있으니 영어로 쓰자
        , STU_NAME
FROM STUDENT
;

-- EMP 테이블에서 부서번호가 10인 사원수와 부서번호가 30인 사원수를 각각 출력하라.
 -- 레코드 한개로
 SELECT * FROM EMP;
 
SELECT COUNT(DEPTNO) , DEPTNO 
FROM EMP
WHERE DEPTNO = '10' OR DEPTNO = '30'
GROUP BY DEPTNO
;

SELECT
    SUM(DECODE(DEPTNO, 10, 1)) "DEPT10 사원수",
    SUM(DECODE(DEPTNO, 30, 1)) "DEPT30 사원수"
FROM EMP
;

SELECT
    COUNT(DECODE(DEPTNO, 10, 1)) DEPT10,
    COUNT(DECODE(DEPTNO, 30, 1)) DEPT30
FROM EMP
;

--------------------------------------------------------------------

-- GROUP BY 그룹함수에 WHERE 을 (조건을) 줄수없다
-- 그래서

SELECT COUNT(*) , DEPTNO 
FROM EMP
WHERE COUNT(*) > 4 
GROUP BY DEPTNO
;                 -- 이렇게 WHERE 로 조건문을 줄수없다.

SELECT COUNT(*) , DEPTNO 
FROM EMP
GROUP BY DEPTNO
HAVING COUNT(*) > 4        -- HAVING 으로 주면 가능하다 ! 개꿀 !
                            -- HAVING 조건문  =  WHERE 조건문 
;

-----------------------------------------------------------------

-- EMP 테이블에서 가장 많은 사원이 속해있는 부서번호와 사원수를 출력하라.

SELECT * 
FROM EMP
;

SELECT COUNT(*) , DEPTNO
FROM EMP
GROUP BY DEPTNO
HAVING COUNT(*) = (             -- HAVING 에는 별칭을 못씀
                  SELECT MAX(COUNT(*))
                  FROM EMP
                  GROUP BY DEPTNO
                  )
;