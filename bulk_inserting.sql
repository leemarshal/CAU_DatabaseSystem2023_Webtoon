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



INSERT INTO Genres (GenreID, Name, Description)
VALUES
(1, 'Romance', 'Stories that focus on romantic relationships between characters'),
(2, 'Fantasy', 'Featuring magical and supernatural elements in a fictional universe'),
(3, 'Action', 'High-energy stories with lots of physical activities and exciting scenes'),
(4, 'Mystery', 'Stories revolving around solving a crime, mystery, or uncovering secrets'),
(5, 'Comedy', 'Light-hearted tales often characterized by humor, satire, and fun'),
(6, 'Horror', 'Designed to scare and create a feeling of fear and unease'),
(7, 'Sci-Fi', 'Stories often based on imaginative future scientific and technological discoveries'),
(8, 'Adventure', 'Featuring exciting journeys, explorations, and often a hero's quest'),
(9, 'Slice of Life', 'Depicting everyday life and ordinary experiences in a realistic manner'),
(10, 'Thriller', 'Focused on creating suspense, excitement, and high levels of anticipation');

