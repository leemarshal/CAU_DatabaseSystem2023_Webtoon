DROP PROCEDURE IF EXISTS UpdateEpisodeAvgRatings;
DELIMITER //

CREATE PROCEDURE UpdateEpisodeAvgRatings(IN eId INT)
BEGIN
    DECLARE newRating DECIMAL(3,1);
    DECLARE existingID INT;

    -- 각 에피소드의 평균 평점 계산
    SELECT AVG(Rating) INTO newRating
    FROM EpisodeRating
    WHERE EpisodeID = eId;

    -- 해당 에피소드의 기존 데이터 확인
    SELECT EpisodeAvgRatingID INTO existingID
    FROM EpisodeAvgRating
    WHERE EpisodeID = eId;

    -- 평균 평점이 null이 아닌 경우에만 업데이트 실행
    IF newRating IS NOT NULL THEN
        IF existingID IS NOT NULL THEN
            -- 기존 데이터가 있는 경우 업데이트
            UPDATE EpisodeAvgRating
            SET Rating = newRating
            WHERE EpisodeID = eId;
        ELSE
            -- 기존 데이터가 없는 경우 새로운 행 삽입
            INSERT INTO EpisodeAvgRating (EpisodeID, Rating)
            VALUES (eId, newRating);
        END IF;
    END IF;
END //

DELIMITER ;

DROP PROCEDURE IF EXISTS DeactivateReader;
DELIMITER //
CREATE PROCEDURE DeactivateReader(IN p_ReaderID INT)
BEGIN
    DECLARE IsReaderActive BOOLEAN;

    -- 활성 상태 확인
    SELECT IsActive INTO IsReaderActive FROM Users WHERE UserID = p_ReaderID;

    IF IsReaderActive = False THEN
        -- 데이터 삭제
        DELETE FROM ReaderBookmark WHERE ReaderID = p_ReaderID;
        DELETE FROM Subscriptions WHERE ReaderID = p_ReaderID;
        DELETE FROM Reading WHERE ReaderID = p_ReaderID;
        DELETE FROM ReaderSearch WHERE ReaderID = p_ReaderID;
        DELETE FROM UserNoticeRead WHERE ReaderID = p_ReaderID;
        DELETE FROM ReaderPaymentMethods WHERE ReaderID = p_ReaderID;
        -- 트리거에서 실행될 프로시저. 트랜잭션 제외함.
    END IF;
END //

DELIMITER ;

DROP PROCEDURE IF EXISTS DeactivateAuthor;
DELIMITER //
CREATE PROCEDURE DeactivateAuthor(IN p_AuthorID INT)
    BEGIN
    DECLARE IsAuthorActive BOOLEAN;
    SELECT IsActive INTO IsAuthorActive FROM Users WHERE UserID = p_AuthorID;
    IF IsAuthorActive = False THEN
       UPDATE Authors SET Salary = 0 WHERE AuthorID = p_AuthorID;
    END IF;
END //;
DELIMITER ;



DROP PROCEDURE IF EXISTS UpdateWebtoonAvgRatings;
DELIMITER //

CREATE PROCEDURE UpdateWebtoonAvgRatings(IN wId INT)
BEGIN
    declare newRating DECIMAL(5,2);
    SELECT
        avg(Rating) into newRating
    FROM
        EpisodeAvgRating
    left join Episodes E on EpisodeAvgRating.EpisodeID = E.EpisodeID
    where WebtoonID = wId
    group by WebtoonID;
    IF newRating IS NOT NULL THEN UPDATE WebtoonAvgRating SET Rating = newRating where WebtoonID = wId;
    END IF;
END //

DELIMITER ;