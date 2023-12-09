INSERT INTO Webtoons (WebtoonID, Title, AuthorID, PublishDate, ThumbnailURL)
VALUES
(1, 'Webtoon Title 1', 1, '2023-01-01', 'https://example.com/thumbnail1.jpg'),
(2, 'Webtoon Title 2', 2, '2023-01-02', 'https://example.com/thumbnail2.jpg'),
(3, 'Webtoon Title 3', 3, '2023-01-03', 'https://example.com/thumbnail3.jpg'),
(4, 'Webtoon Title 4', 4, '2023-01-04', 'https://example.com/thumbnail4.jpg'),
(5, 'Webtoon Title 5', 5, '2023-01-05', 'https://example.com/thumbnail5.jpg'),
(6, 'Webtoon Title 6', 6, '2023-01-06', 'https://example.com/thumbnail6.jpg'),
(7, 'Webtoon Title 7', 7, '2023-01-07', 'https://example.com/thumbnail7.jpg'),
(8, 'Webtoon Title 8', 8, '2023-01-08', 'https://example.com/thumbnail8.jpg'),
(9, 'Webtoon Title 9', 9, '2023-01-09', 'https://example.com/thumbnail9.jpg'),
(10, 'Webtoon Title 10', 10, '2023-01-10', 'https://example.com/thumbnail10.jpg');

INSERT INTO Authors (AuthorID, Salary)
VALUES
(1, 5000),
(2, 5500),
(3, 6000),
(4, 6500),
(5, 7000),
(6, 7500),
(7, 8000),
(8, 8500),
(9, 9000),
(10, 10000);

INSERT INTO WebtoonStatus (WebtoonID, Status)
VALUES
(1, 'Ongoing'),
(2, 'Completed'),
(3, 'Ongoing'),
(4, 'Completed'),
(5, 'Ongoing'),
(6, 'Completed'),
(7, 'Ongoing'),
(8, 'Completed'),
(9, 'Ongoing'),
(10, 'Completed');

INSERT INTO Users (UserID, Username, Email, PasswordHash, UserType, Gender, DateOfBirth, JoinDate)
VALUES
(1, 'username1', 'user1@example.com', 'hash1', 'Author', 'Male', '1990-01-01', '2020-01-01'),
(2, 'username2', 'user2@example.com', 'hash2', 'Author', 'Female', '1991-02-01', '2020-02-01'),
(3, 'username3', 'user3@example.com', 'hash3', 'Author', 'Male', '1992-03-01', '2020-03-01'),
(4, 'username4', 'user4@example.com', 'hash4', 'Author', 'Female', '1993-04-01', '2020-04-01'),
(5, 'username5', 'user5@example.com', 'hash5', 'Author', 'Male', '1994-05-01', '2020-05-01'),
(6, 'username6', 'user6@example.com', 'hash6', 'Author', 'Female', '1995-06-01', '2020-06-01'),
(7, 'username7', 'user7@example.com', 'hash7', 'Author', 'Male', '1996-07-01', '2020-07-01'),
(8, 'username8', 'user8@example.com', 'hash8', 'Author', 'Female', '1997-08-01', '2020-08-01'),
(9, 'username9', 'user9@example.com', 'hash9', 'Author', 'Male', '1998-09-01', '2020-09-01'),
(10, 'username10', 'user10@example.com', 'hash10', 'Author', 'Female', '1999-10-01', '2020-10-01');

INSERT INTO Users (UserID, Username, Email, PasswordHash, UserType, Gender, DateOfBirth, JoinDate)
VALUES
(11, 'reader1', 'reader1@example.com', 'hash11', 'Reader', 'Male', '1990-11-01', '2020-11-01'),
(12, 'reader2', 'reader2@example.com', 'hash12', 'Reader', 'Female', '1991-12-01', '2020-12-01'),
(13, 'reader3', 'reader3@example.com', 'hash13', 'Reader', 'Male', '1992-01-13', '2021-01-13'),
(14, 'reader4', 'reader4@example.com', 'hash14', 'Reader', 'Female', '1993-02-14', '2021-02-14'),
(15, 'reader5', 'reader5@example.com', 'hash15', 'Reader', 'Male', '1994-03-15', '2021-03-15'),
(16, 'reader6', 'reader6@example.com', 'hash16', 'Reader', 'Female', '1995-04-16', '2021-04-16'),
(17, 'reader7', 'reader7@example.com', 'hash17', 'Reader', 'Male', '1996-05-17', '2021-05-17'),
(18, 'reader8', 'reader8@example.com', 'hash18', 'Reader', 'Female', '1997-06-18', '2021-06-18'),
(19, 'reader9', 'reader9@example.com', 'hash19', 'Reader', 'Male', '1998-07-19', '2021-07-19'),
(20, 'reader10', 'reader10@example.com', 'hash20', 'Reader', 'Female', '1999-08-20', '2021-08-20');

-- hash 값은 수정 필요

INSERT INTO Authors (AuthorID, Salary)
VALUES
(1, 5000),
(2, 5500),
(3, 6000),
(4, 6500),
(5, 7000),
(6, 7500),
(7, 8000),
(8, 8500),
(9, 9000),
(10, 10000);

INSERT INTO Tags (TagID, TagName, TagDescription)
VALUES
(1, '소년왕도물', '주로 젊은 남성 캐릭터들이 주인공인 모험과 성장을 그린 이야기'),
(2, '액션', '강렬한 액션과 긴장감 있는 장면들이 특징인 장르'),
(3, '이능력배틀물', '특별한 능력을 가진 캐릭터들의 대결을 중심으로 한 이야기'),
(4, '판타지', '마법이나 초자연적인 요소가 포함된 상상 속 세계를 배경으로 하는 장르'),
(5, '고인물', '주인공이 뛰어난 실력이나 능력을 가진 이야기'),
(6, '사이다', '시원하고 짜릿한 전개로 독자에게 통쾌함을 주는 스토리'),
(7, '드라마', '인물들의 갈등과 성장, 감정적인 요소를 강조하는 장르'),
(8, '세계관', '독특하고 잘 구축된 세계관을 바탕으로 한 스토리'),
(9, '소설원작', '소설을 원작으로 하는 웹툰'),
(10, '먼치킨', '주인공이 압도적인 능력을 가지고 스토리를 이끌어가는 장르');

INSERT INTO Readers (ReaderID, CookieAmount, IsActive)
VALUES
(11, 100, TRUE),
(12, 150, TRUE),
(13, 200, TRUE),
(14, 250, TRUE),
(15, 300, TRUE),
(16, 350, TRUE),
(17, 400, TRUE),
(18, 450, TRUE),
(19, 500, FALSE),
(20, 550, FALSE);

INSERT INTO AuthorsWebtoons (AuthorWebtoonID, WebtoonID, AuthorID)
VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 2),
(4, 4, 2),
(5, 5, 3),
(6, 1, 3),
(7, 2, 4),
(8, 3, 4),
(9, 4, 5),
(10, 5, 5);

INSERT INTO Episodes (EpisodeID, WebtoonID, Title, ReleaseDate, ThumbnailURL, EpisodeIndex)
VALUES
(1, 1, 'Episode 1', '2023-01-01', 'https://example.com/ep_thumbnail1.jpg', 1),
(2, 1, 'Episode 2', '2023-01-02', 'https://example.com/ep_thumbnail2.jpg', 2),
(3, 1, 'Episode 3', '2023-01-03', 'https://example.com/ep_thumbnail3.jpg', 3),
(4, 1, 'Episode 4', '2023-01-04', 'https://example.com/ep_thumbnail4.jpg', 4),
(5, 1, 'Episode 5', '2023-01-05', 'https://example.com/ep_thumbnail5.jpg', 5),
(6, 1, 'Episode 6', '2023-01-06', 'https://example.com/ep_thumbnail6.jpg', 6),
(7, 1, 'Episode 7', '2023-01-07', 'https://example.com/ep_thumbnail7.jpg', 7),
(8, 1, 'Episode 8', '2023-01-08', 'https://example.com/ep_thumbnail8.jpg', 8),
(9, 1, 'Episode 9', '2023-01-09', 'https://example.com/ep_thumbnail9.jpg', 9),
(10, 1, 'Episode 10', '2023-01-10', 'https://example.com/ep_thumbnail10.jpg', 10);

INSERT INTO EpisodesMedia (EpisodeMediaID, EpisodeID, MediaURL)
VALUES
(1, 1, 'https://example.com/bgm1.mp3'),
(2, 2, 'https://example.com/bgm2.mp3'),
(3, 3, 'https://example.com/bgm3.mp3'),
(4, 4, 'https://example.com/bgm4.mp3'),
(5, 5, 'https://example.com/bgm5.mp3'),
(6, 6, 'https://example.com/bgm6.mp3'),
(7, 7, 'https://example.com/bgm7.mp3'),
(8, 8, 'https://example.com/bgm8.mp3'),
(9, 9, 'https://example.com/bgm9.mp3'),
(10, 10, 'https://example.com/bgm10.mp3');

INSERT INTO EpisodesImage (EpisodeImageID, EpisodeID, CutNumber, ImageURL)
VALUES
(1, 1, 1, 'https://example.com/image1.jpg'),
(2, 1, 2, 'https://example.com/image2.jpg'),
(3, 1, 3, 'https://example.com/image3.jpg'),
(4, 1, 4, 'https://example.com/image4.jpg'),
(5, 1, 5, 'https://example.com/image5.jpg'),
(6, 1, 6, 'https://example.com/image6.jpg'),
(7, 1, 7, 'https://example.com/image7.jpg'),
(8, 1, 8, 'https://example.com/image8.jpg'),
(9, 1, 9, 'https://example.com/image9.jpg'),
(10, 1, 10, 'https://example.com/image10.jpg');

INSERT INTO EpisodesDialogue (DialogueID, EpisodeID, AuthorID, DialogueText, Timestamp)
VALUES
(1, 1, 1, '감사합니다.', CURRENT_TIMESTAMP),
(2, 2, 1, '늦어서 미안합니다.', CURRENT_TIMESTAMP),
(3, 3, 1, '재밌죠?', CURRENT_TIMESTAMP),
(4, 4, 1, '.', CURRENT_TIMESTAMP),
(5, 5, 1, '다음주에는 휴재입니다.', CURRENT_TIMESTAMP),
(6, 6, 1, '다음 화가 기대되시죠?', CURRENT_TIMESTAMP),
(7, 7, 1, '여러분의 응원이 큰 힘이 됩니다.', CURRENT_TIMESTAMP),
(8, 8, 1, '오늘도 즐거운 하루 되세요!', CURRENT_TIMESTAMP),
(9, 9, 1, '읽어주셔서 감사합니다.', CURRENT_TIMESTAMP),
(10, 10, 1, '다음주에는 최종화로 찾아뵙겠습니다!', CURRENT_TIMESTAMP);

INSERT INTO EpisodeRating (EpisodeRatingID, EpisodeID, ReaderID, Rating)
VALUES
(1, 1, 11, 8),
(2, 1, 12, 9),
(3, 1, 13, 10),
(4, 1, 14, 8),
(5, 1, 15, 8),
(6, 1, 16, 9),
(7, 1, 17, 10),
(8, 1, 18, 8),
(9, 1, 19, 9),
(10, 1, 20, 10),
(11, 2, 11, 8),
(12, 3, 12, 9),
(13, 4, 13, 10),
(14, 5, 14, 8),
(15, 6, 15, 9),
(16, 7, 16, 10),
(17, 8, 17, 8),
(18, 9, 18, 9),
(19, 10, 19, 10);

INSERT INTO EpisodeAvgRating (EpisodeAvgRatingID, EpisodeID, Rating)
VALUES
(1, 1, 8.9),
(2, 2, 8.0),
(3, 3, 9.0),
(4, 4, 10.0),
(5, 5, 8.0),
(6, 6, 9.0),
(7, 7, 10.0),
(8, 8, 8.0),
(9, 9, 9.0),
(10, 10, 10.0);



-- 그저 예쁜 merger를 위한 꼼수

INSERT INTO Genres (GenreID, Name, Description)
VALUES
(1, 'Romance', 'Stories that focus on romantic relationships between characters'),
(2, 'Fantasy', 'Featuring magical and supernatural elements in a fictional universe'),
(3, 'Action', 'High-energy stories with lots of physical activities and exciting scenes'),
(4, 'Mystery', 'Stories revolving around solving a crime, mystery, or uncovering secrets'),
(5, 'Comedy', 'Light-hearted tales often characterized by humor, satire, and fun'),
(6, 'Horror', 'Designed to scare and create a feeling of fear and unease'),
(7, 'Sci-Fi', 'Stories often based on imaginative future scientific and technological discoveries'),
(8, 'Adventure', 'Featuring exciting journeys, explorations, and often a hero''s quest'),
(9, 'Slice of Life', 'Depicting everyday life and ordinary experiences in a realistic manner'),
(10, 'Thriller', 'Focused on creating suspense, excitement, and high levels of anticipation');

-- 준오형 ddl.sql 기준 Genres(line 251~) 밑으로 부탁드립니다.
-- 완료

INSERT INTO WebtoonGenres (WebtoonID, GenreID) VALUES
(1, 10),
(2, 8),
(3, 6),
(4, 4),
(5, 2),
(6, 1),
(7, 3),
(8, 5),
(9, 7),
(10, 9);

INSERT INTO WebtoonTags (WebtoonTagID, WebtoonID, TagID) VALUES
(1, 1, 5),
(2, 2, 10),
(3, 3, 4),
(4, 4, 9),
(5, 5, 3),
(6, 6, 8),
(7, 7, 2),
(8, 8, 7),
(9, 9, 1),
(10, 10, 6);

INSERT INTO Notice (NoticeID, Title, Content, PostedDate, IsActive) VALUES
(1, 'Important Update', 'We have an important update for our users.', '2023-01-01', 'True'),
(2, 'New Webtoon Release', 'Check out our latest webtoon release!', '2023-02-15', 'True'),
(3, 'Maintenance Notice', 'Scheduled maintenance on our platform.', '2023-03-10', 'True'),
(4, 'Upcoming Event', 'Get ready for our upcoming event!', '2023-04-05', 'True'),
(5, 'System Upgrade', 'Our system will undergo an upgrade this weekend.', '2023-05-20', 'True'),
(6, 'Holiday Closure', 'Our services will be closed for the holiday.', '2023-07-01', 'True'),
(7, 'Community Poll', 'Share your thoughts in our community poll!', '2023-08-10', 'True'),
(8, 'Bug Fix', 'We have fixed several bugs on our platform.', '2023-09-15', 'True'),
(9, 'New Feature Announcement', 'Exciting new features are coming soon!', '2023-10-10', 'True'),
(10, 'Thank You for Your Support', 'We appreciate your continued support!', '2023-12-01', 'True');

INSERT INTO UserNoticeRead (ReaderID, NoticeID) VALUES
(1, 1),
(2, 1),
(3, 2),
(4, 3),
(5, 4),
(1, 5),
(2, 6),
(3, 7),
(4, 8),
(5, 9);

INSERT INTO Subscriptions (ReaderID, WebtoonID, SubscriptionDate) VALUES
(11, 1, '2023-01-02'),
(12, 2, '2023-02-18'),
(13, 3, '2023-03-12'),
(14, 4, '2023-04-07'),
(15, 5, '2023-05-25'),
(16, 6, '2023-07-05'),
(17, 7, '2023-08-15'),
(18, 8, '2023-09-20'),
(19, 9, '2023-10-15'),
(20, 10, '2023-12-05');

INSERT INTO PromotionEvent (event_id, start_date, end_date, event_title, cookie_discount_rate) VALUES
(1, '2023-01-01', '2023-01-31', 'New Year Sale', 10),
(2, '2023-02-14', '2023-02-28', 'Christmas Special', 15),
(3, '2023-03-01', '2023-03-15', 'Spring Promotion', 12),
(4, '2023-04-10', '2023-04-30', 'April Flash Sale', 8),
(5, '2023-05-15', '2023-05-31', 'Mid-Year Discounts', 20),
(6, '2023-07-01', '2023-07-15', 'Summer Bonanza', 18),
(7, '2023-08-05', '2023-08-20', 'Back-to-School Savings', 15),
(8, '2023-09-10', '2023-09-30', 'Fall Frenzy', 12),
(9, '2023-10-05', '2023-10-20', 'Halloween Spooktacular', 25),
(10, '2023-11-25', '2023-12-10', 'Black Friday Extravaganza', 30);