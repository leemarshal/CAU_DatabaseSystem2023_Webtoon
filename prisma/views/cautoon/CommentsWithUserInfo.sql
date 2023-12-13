SELECT
  `cautoon`.`Comments`.`CommentID` AS `CommentID`,
  `cautoon`.`Comments`.`EpisodeID` AS `EpisodeID`,
  `cautoon`.`Users`.`Username` AS `Username`,
  `cautoon`.`Comments`.`CommentText` AS `CommentText`,
  `cautoon`.`Comments`.`Timestamp` AS `Timestamp`,
  `cautoon`.`Comments`.`ParentCommentID` AS `ParentCommentID`
FROM
  (
    (
      `cautoon`.`Comments`
      LEFT JOIN `cautoon`.`Readers` ON(
        `cautoon`.`Readers`.`ReaderID` = `cautoon`.`Comments`.`ReaderID`
      )
    )
    LEFT JOIN `cautoon`.`Users` ON(
      `cautoon`.`Readers`.`ReaderID` = `cautoon`.`Users`.`UserID`
    )
  )