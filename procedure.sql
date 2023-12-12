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
    SELECT IsActive INTO IsReaderActive FROM Users WHERE UserID = p_ReaderID;
    IF IsReaderActive = False THEN
        UPDATE Users SET Username = 'Unknown' WHERE UserID = p_ReaderID;
        DELETE FROM ReaderBookmark WHERE ReaderID = p_ReaderID;
        DELETE FROM Subscriptions WHERE ReaderID = p_ReaderID;
        DELETE FROM ReaderBookmark WHERE ReaderID = p_ReaderID;
        DELETE FROM ReaderSearch WHERE ReaderID = p_ReaderID;
        DELETE FROM UserNoticeRead WHERE ReaderID = p_ReaderID;
        DELETE FROM Reading WHERE ReaderID = p_ReaderID;
        UPDATE ReaderPaymentMethods SET PaymentMethodDetails = null WHERE ReaderID = p_ReaderID;

        COMMIT;
    END IF;
END //;
CREATE PROCEDURE DeactivateAuthor(IN p_AuthorID INT)
    BEGIN
    DECLARE IsAuthorActive BOOLEAN;
    SELECT IsActive INTO IsAuthorActive FROM Users WHERE UserID = p_AuthorID;
    IF IsAuthorActive = False THEN
       UPDATE Authors SET Salary = 0 WHERE AuthorID = p_AuthorID;
        COMMIT;
    END IF;
END //;
DELIMITER ;