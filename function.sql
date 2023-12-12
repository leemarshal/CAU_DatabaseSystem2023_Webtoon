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

DELIMITER $$
DROP FUNCTION IF EXISTS GetMaleSubscriberRatio;
CREATE FUNCTION GetMaleSubscriberRatio(webtoon_id INT) RETURNS DECIMAL(4,2)
BEGIN
    DECLARE male_count INT;
    DECLARE total_count INT;
    DECLARE ratio DECIMAL(5,2);

    -- 남성 구독자 수 계산
    SELECT COUNT(*)
    INTO male_count
    FROM Subscriptions
    INNER JOIN Readers ON Subscriptions.ReaderID = Readers.ReaderID
    INNER JOIN Users ON Readers.ReaderID = Users.UserID
    WHERE Subscriptions.WebtoonID = webtoon_id AND Users.Gender = 'Male';

    -- 전체 구독자 수 계산
    SELECT COUNT(*)
    INTO total_count
    FROM Subscriptions
    WHERE Subscriptions.WebtoonID = webtoon_id;

    -- 전체 구독자가 없는 경우 0 반환
    IF total_count = 0 THEN
        RETURN 0;
    END IF;

    -- 비율 계산
    SET ratio = (male_count / total_count);

    RETURN ratio;
END$$

DELIMITER ;

