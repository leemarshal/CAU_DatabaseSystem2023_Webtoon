DELIMITER //
DROP FUNCTION IF EXISTS CalculateNoticeReadRatio;
CREATE FUNCTION CalculateNoticeReadRatio(noticeID INT) RETURNS DECIMAL(5,2)
BEGIN
    DECLARE totalReadCount INT;
    DECLARE noticeReadCount INT;
    DECLARE readRatio DECIMAL(5,2);

    -- 전체 사용자 수 조회
    SELECT COUNT(DISTINCT ReaderID) INTO totalReadCount
    FROM Readers;

    -- 특정 Notice를 읽은 사용자 수 조회
    SELECT COUNT(DISTINCT ReaderID) INTO noticeReadCount
    FROM UserNoticeRead
    WHERE UserNoticeRead.NoticeID = noticeID;

    -- 읽은 비율 계산
    IF totalReadCount > 0 THEN
        SET readRatio = (noticeReadCount / totalReadCount);
    ELSE
        SET readRatio = 0;
    END IF;

    RETURN readRatio;
END //

DELIMITER ;
