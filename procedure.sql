DELIMITER $$

CREATE PROCEDURE UpdateEpisodeAvgRatings()
BEGIN
    INSERT INTO EpisodeAvgRating (EpisodeAvgRatingID, EpisodeID, Rating)
    SELECT
        NEXT VALUE FOR EpisodeAvgRatingSeq,  -- 또는 적절한 ID 생성 방법
        EpisodeID,
        AVG(Rating) AS Rating
    FROM
        EpisodeRating
    GROUP BY
        EpisodeID
    ON DUPLICATE KEY UPDATE
        Rating = VALUES(Rating);
END$$

DELIMITER ;

DELIMITER //
CREATE PROCEDURE DeactivateReader(IN p_ReaderID INT)
    BEGIN
    DECLARE IsReaderActive BOOLEAN ;
    SELECT IsActive INTO IsReaderActive FROM Readers WHERE ReaderID = p_ReaderID;
    IF IsReaderActive = False THEN
        UPDATE Users SET Username = 'Unknown' WHERE UserID = p_ReaderID;
        DELETE FROM ReaderBookmark WHERE ReaderID = p_ReaderID;
        DELETE FROM Subscriptions WHERE ReaderID = p_ReaderID;
        DELETE FROM ReaderBookmark WHERE ReaderID = p_ReaderID;
        DELETE FROM ReaderSearch WHERE ReaderID = p_ReaderID;
        DELETE FROM UserNoticeRead WHERE ReaderID = p_ReaderID;
        DELETE FROM ReaderPaymentMethods WHERE ReaderID = p_ReaderID;
        UPDATE ReaderCookiePurchases SET ReaderPaymentMethodID = '0' WHERE ReaderID = p_ReaderID;

        COMMIT;
    END IF;
END //;

CREATE PROCEDURE DeactivateAuthor(IN p_AuthorID INT)
    BEGIN
    DECLARE IsAuthorActive BOOLEAN;
    SELECT IsActive INTO IsAuthorActive FROM Users WHERE UserID = p_AuthorID;
    IF IsAuthorActive = False THEN
       UPDATE Authors SET Salary = 0 WHERE AuthorID = p_AuthorID;
    END IF;
END //;
DELIMITER ;




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