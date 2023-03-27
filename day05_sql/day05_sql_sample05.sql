--! 특정요소들을 문자로 바꾸는 TO_CHAR !
    -- 1번 20230327
    -- 2번 2023/03/27
    -- 3번 2023-03-27
    -- 4번 2023-03-27 05:21:01 (현재시간)
    -- 5번 2023-03-27 17:21:01 (현재시간)
    -- Y M D 로 구분시켜준다
SELECT TO_CHAR(SYSDATE, 'YYYYMMDD') AS "1번"            -- 현재시간을 문자열로 출력함
        ,TO_CHAR(SYSDATE, 'YYYY/MM/DD') "2번"
        ,TO_CHAR(SYSDATE, 'YYYY-MM-DD') "3번"
        ,TO_CHAR(SYSDATE, 'YYYY-MM-DD HH:MI:SS') "4번"       -- 분은 MM 이아니고 MI
        ,TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') "5번"   
FROM DUAL
;

------------------------------------------------------------------------------------

SELECT TO_CHAR(123.456 , 'FM999.99') AS A           -- 소수점 2번째 자리까지 나옴 / 반올림 함
       ,TO_CHAR(123.456 , 'FM0999.99') AS B         -- 9는 해당 위치에 값이 없어도 무시하고 출력
       ,TO_CHAR(123.456 , 'FM9999.99') AS C         -- 0은 해당 위치에 값이 없으면 0으로 채움
       ,TO_CHAR(1234.45 , 'FM9999.9') AS D          -- 반올림 해서 1234.5 로 출력
       ,TO_CHAR(10000000 , 'FML99,999,999') AS E    -- 10,000,000 으로 출력
FROM DUAL;

------------------------------------------------------------------------------------

SELECT TO_CHAR(SYSDATE, 'FMMM/DD')      -- 05/26 => 5/6 ===> 0들을 빼줌
FROM DUAL;

------------------------------------------------------------------------------------

SELECT TO_CHAR(SYSDATE, 'YYYY"년" MM"월" DD"일"') AS 날짜      -- 한글은 "" 을 붙혀준다.
      ,TO_CHAR(SYSDATE, 'HH24"시" MI"분" SS"초"') AS 시간
FROM DUAL;

------------------------------------------------------------------------------------

SELECT TO_CHAR(SYSDATE, 'AM')       --오전이냐 오후냐 출력
      ,TO_CHAR(SYSDATE, 'D')        --1(일요일) ~ 7(토요일)
      ,TO_CHAR(SYSDATE, 'DY')       -- 월 표시
      ,TO_CHAR(SYSDATE, 'DAY')      -- 몇요일인지
      ,TO_CHAR(SYSDATE, 'DDD')      --365일기준
      ,TO_CHAR(SYSDATE, 'WW')       --1년기준 몇주 지났는지
      ,TO_CHAR(SYSDATE, 'MON')      --몇월인지
FROM DUAL;

------------------------------------------------------------------------------------

-- 1980년 ~1982년 사이에 입사된 각 부서별 사원수, 부서번호, 부서명, 입사년도를 출력하라
SELECT D.DNAME , D.DEPTNO , 
       COUNT(DECODE(TO_CHAR(E.HIREDATE, 'YYYY'), '1980' , 1)) "입사 1980"
       ,COUNT(DECODE(TO_CHAR(E.HIREDATE, 'YYYY'), '1981' , 1)) "입사 1981"
       ,COUNT(DECODE(TO_CHAR(E.HIREDATE, 'YYYY'), '1982' , 1)) "입사 1982"
FROM EMP E
INNER JOIN DEPT D ON D.DEPTNO = E.DEPTNO
GROUP BY D.DNAME , D.DEPTNO