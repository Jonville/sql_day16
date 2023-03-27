--1. 가장 제고가 많이 남은 제품의 제품명, 제품종류, 남은갯수 출력

    --1)  가장 제고가 많이 남은 제품
    --2)  제품명을 구할수있는지
    --3)  제품종류를 구할수있는지

SELECT P_NAME, CNT, C.NAME
FROM PRODUCT P
INNER JOIN (
    SELECT CNT, P_ID 
    FROM (
        SELECT SUM(COUNT) AS CNT, P_ID
        FROM P_MANAGE
        GROUP BY P_ID
        ORDER BY CNT DESC
    ) WHERE ROWNUM = 1
) A ON A.P_ID = P.P_ID
LEFT OUTER JOIN T_CODE C ON C.CODE = P.KIND AND C.KIND = 'CLOTH'
;

--2. 유재석이 구매한 '모자' 제품의 각 사이즈별 수량 구하기

SELECT SUM(COUNT), P_SIZE
FROM P_MANAGE
WHERE P_ID = (
    SELECT O.P_ID
    FROM ORDER_TABLE O
    INNER JOIN T_USER U ON O.ID = U.ID
    INNER JOIN PRODUCT P ON P.P_ID = O.P_ID AND KIND = 'C'
    WHERE U.NAME = '유재석'
)
GROUP BY P_SIZE
;

--3. 한번도 주문이 되지 않은 제품의 S 사이즈 제품들 삭제
--(P_ID가 PRODUCT 테이블에는 있지만 ORDER_TABLE에는 없는 데이터)

DELETE 
FROM P_MANAGE
WHERE P_ID IN (
    SELECT P.P_ID
    FROM PRODUCT P
    LEFT OUTER JOIN ORDER_TABLE O ON P.P_ID = O.P_ID
    WHERE O.P_ID IS NULL
) AND P_SIZE = 'S';



--4. 배송상태가 '환불'인 제품들의 재고량 구하기

SELECT SUM(COUNT), P_ID
FROM P_MANAGE
WHERE P_ID IN (
    SELECT P_ID
    FROM ORDER_TABLE O
    LEFT OUTER JOIN T_CODE C ON O.STATUS = C.CODE AND C.KIND = 'STATUS'
    WHERE STATUS = 'D'
    GROUP BY P_ID
)
GROUP BY P_ID;
?;