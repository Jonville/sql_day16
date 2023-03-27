--1. ���� ���� ���� ���� ��ǰ�� ��ǰ��, ��ǰ����, �������� ���

    --1)  ���� ���� ���� ���� ��ǰ
    --2)  ��ǰ���� ���Ҽ��ִ���
    --3)  ��ǰ������ ���Ҽ��ִ���

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

--2. ���缮�� ������ '����' ��ǰ�� �� ����� ���� ���ϱ�

SELECT SUM(COUNT), P_SIZE
FROM P_MANAGE
WHERE P_ID = (
    SELECT O.P_ID
    FROM ORDER_TABLE O
    INNER JOIN T_USER U ON O.ID = U.ID
    INNER JOIN PRODUCT P ON P.P_ID = O.P_ID AND KIND = 'C'
    WHERE U.NAME = '���缮'
)
GROUP BY P_SIZE
;

--3. �ѹ��� �ֹ��� ���� ���� ��ǰ�� S ������ ��ǰ�� ����
--(P_ID�� PRODUCT ���̺��� ������ ORDER_TABLE���� ���� ������)

DELETE 
FROM P_MANAGE
WHERE P_ID IN (
    SELECT P.P_ID
    FROM PRODUCT P
    LEFT OUTER JOIN ORDER_TABLE O ON P.P_ID = O.P_ID
    WHERE O.P_ID IS NULL
) AND P_SIZE = 'S';



--4. ��ۻ��°� 'ȯ��'�� ��ǰ���� ��� ���ϱ�

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