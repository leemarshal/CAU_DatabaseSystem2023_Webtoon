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
