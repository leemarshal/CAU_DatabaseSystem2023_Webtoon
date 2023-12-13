DROP TABLE IF EXISTS AuthorsWebtoons;
DROP TABLE IF EXISTS EpisodesWebtoon;
DROP TABLE IF EXISTS EpisodesMedia;
DROP TABLE IF EXISTS EpisodesImage;
DROP TABLE IF EXISTS EpisodesDialogue;
DROP TABLE IF EXISTS EpisodeRating;
DROP TABLE IF EXISTS EpisodeAvgRating;
DROP TABLE IF EXISTS WebtoonAvgRating;
DROP TABLE IF EXISTS UserTokens;
DROP TABLE IF EXISTS ReaderSearch;
DROP TABLE IF EXISTS ReaderCookiePurchases;
DROP TABLE IF EXISTS ReaderPaymentMethods;
DROP TABLE IF EXISTS ReaderCookieUse;
DROP TABLE IF EXISTS ReaderBookmark;
DROP TABLE IF EXISTS Reading;
DROP TABLE IF EXISTS CommentsLikes;
DROP TABLE IF EXISTS Comments;
DROP TABLE IF EXISTS WebtoonGenres;
DROP TABLE IF EXISTS WebtoonTags;
DROP TABLE IF EXISTS UserNoticeRead;
DROP TABLE IF EXISTS Subscriptions;
DROP TABLE IF EXISTS WebtoonStatus;
DROP TABLE IF EXISTS Readers;
DROP TABLE IF EXISTS Authors;
DROP TABLE IF EXISTS Administrator;
DROP TABLE IF EXISTS Episodes;
DROP TABLE IF EXISTS Webtoons;
DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS Tags;
DROP TABLE IF EXISTS Genres;
DROP TABLE IF EXISTS Notice;
DROP TABLE IF EXISTS PromotionEvent;

CREATE TABLE Webtoons (
    WebtoonID INT PRIMARY KEY,
    Title VARCHAR(255),
    AuthorID INT,
    PublishDate DATE,
    ThumbnailURL VARCHAR(255),
    PublishDay INT CHECK (PublishDay >= 0 AND PublishDay <= 6)  -- 0: 일요일, 1: 월요일, ..., 6: 토요일
    -- 다른 속성이 있다면 추가하십시오.
);

CREATE TABLE WebtoonStatus (
    WebtoonID INT PRIMARY KEY,
    Status ENUM('Ongoing', 'Completed'),
    FOREIGN KEY (WebtoonID) REFERENCES Webtoons(WebtoonID) ON DELETE CASCADE
);

CREATE TABLE Users (
    UserID INT PRIMARY KEY,
    Username VARCHAR(255),
    Email VARCHAR(255),
    PasswordHash VARCHAR(255),
    Gender VARCHAR(50),
    IsActive BOOLEAN,
    DateOfBirth DATE,
    JoinDate DATE
    -- 추가 속성이 있다면 여기에 삽입하십시오.
);

CREATE TABLE Authors (
    AuthorID INT PRIMARY KEY,
    Salary INT,
    FOREIGN KEY (AuthorID) REFERENCES Users(UserID)
);

CREATE TABLE Tags (
    TagID INT PRIMARY KEY,
    TagName VARCHAR(255),
    TagDescription VARCHAR(255)
    -- TagName and TagDescription VARCHAR lengths can be adjusted as needed.
);

CREATE TABLE Readers (
    ReaderID INT PRIMARY KEY,
    CookieAmount INT,
    FOREIGN KEY (ReaderID) REFERENCES Users(UserID)
);

CREATE TABLE Administrator (
    AdministratorID INT PRIMARY KEY,
    Salary int,
    Level int,
    FOREIGN KEY (AdministratorID) REFERENCES Users(UserID)
);

CREATE TABLE AuthorsWebtoons (
    AuthorWebtoonID INT PRIMARY KEY,
    WebtoonID INT,
    AuthorID INT,
    FOREIGN KEY (WebtoonID) REFERENCES Webtoons(WebtoonID) ON DELETE CASCADE,
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID)
    -- AuthorID is assumed to be a FK to Users table, ensure Users table is created with UserID.
);

CREATE TABLE Episodes (
    EpisodeID INT PRIMARY KEY,
    WebtoonID INT,
    Title VARCHAR(255),
    ReleaseDate DATE,
    ThumbnailURL VARCHAR(255),
    EpisodeIndex INT,
    FOREIGN KEY (WebtoonID) REFERENCES Webtoons(WebtoonID) ON DELETE CASCADE,
    UNIQUE (WebtoonID, EpisodeIndex)
);

CREATE TABLE EpisodesMedia (
    EpisodeMediaID INT PRIMARY KEY,
    EpisodeID INT,
    MediaURL VARCHAR(255),
    FOREIGN KEY (EpisodeID) REFERENCES Episodes(EpisodeID) ON DELETE CASCADE
);

CREATE TABLE EpisodesImage (
    EpisodeImageID INT PRIMARY KEY,
    EpisodeID INT,
    CutNumber INT,
    ImageURL VARCHAR(255),
    FOREIGN KEY (EpisodeID) REFERENCES Episodes(EpisodeID) ON DELETE CASCADE,
    UNIQUE (EpisodeID, CutNumber)
);


CREATE TABLE EpisodesDialogue (
    DialogueID INT PRIMARY KEY,
    EpisodeID INT,
    AuthorID INT,
    DialogueText VARCHAR(255),
    Timestamp TIMESTAMP,
    FOREIGN KEY (EpisodeID) REFERENCES Episodes(EpisodeID) ON DELETE CASCADE,
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID)
    -- Assuming the Authors table has AuthorID as a primary key.
);

CREATE TABLE EpisodeRating (
    EpisodeRatingID INT PRIMARY KEY,
    EpisodeID INT,
    ReaderID INT,
    Rating TINYINT CHECK (Rating >= 1 AND Rating <= 10),
    FOREIGN KEY (EpisodeID) REFERENCES Episodes(EpisodeID) ON DELETE CASCADE,
    FOREIGN KEY (ReaderID) REFERENCES Readers(ReaderID)
    -- ReaderID is assumed to be a FK to Users table.
);

CREATE TABLE EpisodeAvgRating (
    EpisodeAvgRatingID INT PRIMARY KEY,
    EpisodeID INT,
    Rating DECIMAL(3,1) CHECK (Rating >= 1 AND Rating <= 10),
    FOREIGN KEY (EpisodeID) REFERENCES Episodes(EpisodeID) ON DELETE CASCADE
);

CREATE TABLE WebtoonAvgRating (
    WebtoonAvgRatingID INT PRIMARY KEY,
    WebtoonID INT,
    Rating DECIMAL(3,1) CHECK (Rating >= 1 AND Rating <= 10),
    FOREIGN KEY (WebtoonID) REFERENCES Webtoons(WebtoonID) ON DELETE CASCADE
);

CREATE TABLE UserTokens (
    Token VARCHAR(255) PRIMARY KEY,
    UserID INT,
    Expiration DATETIME,
    CreationDate DATETIME,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

CREATE TABLE ReaderSearch (
    ReaderSearchID INT PRIMARY KEY,
    ReaderID INT,
    CreationDate DATETIME,
    SearchKeyword VARCHAR(255),
    FOREIGN KEY (ReaderID) REFERENCES Readers(ReaderID)
    -- Assumes the existence of the Readers table with ReaderID as PK.
);

CREATE TABLE ReaderPaymentMethods (
    ReaderPaymentMethodID INT PRIMARY KEY,
    ReaderID INT,
    PaymentMethodDetails VARCHAR(255),
    FOREIGN KEY (ReaderID) REFERENCES Readers(ReaderID)
    -- Assumes the existence of the Readers table with ReaderID as PK.
);

CREATE TABLE ReaderCookiePurchases (
    ReaderCookiePurchaseID INT AUTO_INCREMENT PRIMARY KEY,
    ReaderID INT,
    Amount INT,
    Date DATE,
    ReaderPaymentMethodID INT,
    FOREIGN KEY (ReaderID) REFERENCES Readers(ReaderID)
    -- ReaderPaymentMethodID에 대한 외래 키(FK)는 ReaderPaymentMethods 테이블의 ReaderPaymentMethodID를 참조한다고 가정
    -- ReaderPaymentMethodID가 INT 타입인 경우, User-Payment Methods에 대한 외래 키도 INT 타입이어야 함
);

CREATE TABLE ReaderCookieUse (
    ReaderCookieUseID INT PRIMARY KEY,
    ReaderID INT,
    Amount INT,
    Date DATE,
    FOREIGN KEY (ReaderID) REFERENCES Readers(ReaderID)
    -- Assumes the existence of the Readers table with ReaderID as PK.
);

CREATE TABLE ReaderBookmark (
    ReaderBookmarkID INT PRIMARY KEY,
    ReaderID INT,
    WebtoonID INT,
    EpisodeID INT,
    FOREIGN KEY (ReaderID) REFERENCES Readers(ReaderID),
    FOREIGN KEY (WebtoonID) REFERENCES Webtoons(WebtoonID),
    FOREIGN KEY (EpisodeID) REFERENCES Episodes(EpisodeID) ON DELETE CASCADE,
    UNIQUE (ReaderID, WebtoonID)
    -- This UNIQUE constraint ensures that the combination of ReaderID and WebtoonID is unique.
    -- Assumes the existence of the Webtoons and Episodes tables with WebtoonID and EpisodeID as PKs.
);

CREATE TABLE Reading (
    ReadingID INT PRIMARY KEY,
    ReaderID INT,
    EpisodeID INT,
    ReadDate DATE,
    FOREIGN KEY (ReaderID) REFERENCES Readers(ReaderID),
    FOREIGN KEY (EpisodeID) REFERENCES Episodes(EpisodeID) ON DELETE CASCADE
    -- Assumes the existence of the Readers and Episodes tables.
);

CREATE TABLE Comments (
    CommentID INT PRIMARY KEY,
    EpisodeID INT,
    ReaderID INT,
    CommentText VARCHAR(255),
    Timestamp TIMESTAMP,
    ParentCommentID INT DEFAULT -1,
    FOREIGN KEY (EpisodeID) REFERENCES Episodes(EpisodeID) ON DELETE CASCADE,
    FOREIGN KEY (ReaderID) REFERENCES Readers(ReaderID)
    -- ParentCommentID is set to -1 by default when there is no parent comment (non-reply comments).
);

CREATE TABLE CommentsLikes (
    LikeID INT PRIMARY KEY,
    ReaderID INT,
    CommentID INT,
    LikeType ENUM('Good', 'Bad'),
    FOREIGN KEY (ReaderID) REFERENCES Readers(ReaderID),
    FOREIGN KEY (CommentID) REFERENCES Comments(CommentID) ON DELETE CASCADE,
    UNIQUE (ReaderID, CommentID)
);


CREATE TABLE Genres (
    GenreID INT PRIMARY KEY,
    Name VARCHAR(255),
    Description VARCHAR(255)
    -- Description can contain a longer text explaining the genre.
);

CREATE TABLE WebtoonGenres (
    WebtoonID INT,
    GenreID INT,
    PRIMARY KEY (WebtoonID, GenreID),
    FOREIGN KEY (WebtoonID) REFERENCES Webtoons(WebtoonID) ON DELETE CASCADE,
    FOREIGN KEY (GenreID) REFERENCES Genres(GenreID)
    -- This table creates a many-to-many relationship between Webtoons and Genres.
    -- The primary key is a composite key consisting of WebtoonID and GenreID.
);

CREATE TABLE WebtoonTags (
    WebtoonTagID INT PRIMARY KEY,
    WebtoonID INT,
    TagID INT,
    FOREIGN KEY (WebtoonID) REFERENCES Webtoons(WebtoonID) ON DELETE CASCADE,
    FOREIGN KEY (TagID) REFERENCES Tags(TagID)
    -- This table links Webtoons to Tags.
);

CREATE TABLE Notice (
    NoticeID INT PRIMARY KEY,
    Title VARCHAR(255),
    Content VARCHAR(255),
    PostedDate DATE,
    AdminID INT,
    FOREIGN KEY (AdminID) REFERENCES Administrator(AdministratorID),
    IsActive BOOLEAN
    -- IsActive is an ENUM to ensure it only contains 'True' or 'False'.
);

CREATE TABLE UserNoticeRead (
    ReaderID INT,
    NoticeID INT,
    PRIMARY KEY (ReaderID, NoticeID),
    FOREIGN KEY (ReaderID) REFERENCES Readers(ReaderID),
    FOREIGN KEY (NoticeID) REFERENCES Notice(NoticeID)
    -- This table records which users have read which notices.
    -- The combination of ReaderID and NoticeID is unique.
);

CREATE TABLE Subscriptions (
    ReaderID INT,
    WebtoonID INT,
    SubscriptionDate DATE,
    PRIMARY KEY (ReaderID, WebtoonID),
    FOREIGN KEY (ReaderID) REFERENCES Readers(ReaderID),
    FOREIGN KEY (WebtoonID) REFERENCES Webtoons(WebtoonID) ON DELETE CASCADE
    -- By using ReaderID and WebtoonID as a composite primary key,
    -- this table now allows a reader to subscribe to multiple webtoons
    -- and ensures that each subscription is unique to a reader-webtoon pair.
);

CREATE TABLE PromotionEvent (
    event_id INT PRIMARY KEY,
    start_date DATE,
    end_date DATE,
    event_title VARCHAR(255),
    cookie_discount_rate INT
);

INSERT INTO Users (UserID, Username, Email, PasswordHash, Gender, DateOfBirth, JoinDate, IsActive)
VALUES
(1, 'username1', 'user1@example.com', 'hash1', 'Male', '1990-01-01', '2020-01-01', TRUE),
(2, 'username2', 'user2@example.com', 'hash2', 'Female', '1991-02-01', '2020-02-01', TRUE),
(3, 'username3', 'user3@example.com', 'hash3', 'Male', '1992-03-01', '2020-03-01', TRUE),
(4, 'username4', 'user4@example.com', 'hash4', 'Female', '1993-04-01', '2020-04-01', TRUE),
(5, 'username5', 'user5@example.com', 'hash5', 'Male', '1994-05-01', '2020-05-01', TRUE),
(6, 'username6', 'user6@example.com', 'hash6', 'Female', '1995-06-01', '2020-06-01', TRUE),
(7, 'username7', 'user7@example.com', 'hash7', 'Male', '1996-07-01', '2020-07-01', TRUE),
(8, 'username8', 'user8@example.com', 'hash8', 'Female', '1997-08-01', '2020-08-01', TRUE),
(9, 'username9', 'user9@example.com', 'hash9', 'Male', '1998-09-01', '2020-09-01', TRUE),
(10, 'username10', 'user10@example.com', 'hash10', 'Female', '1999-10-01', '2020-10-01', TRUE);

INSERT INTO Users (UserID, Username, Email, PasswordHash, Gender, DateOfBirth, JoinDate, IsActive)
VALUES
(11, 'reader1', 'reader1@example.com', 'hash11', 'Male', '1990-11-01', '2020-11-01', TRUE),
(12, 'reader2', 'reader2@example.com', 'hash12', 'Female', '1991-12-01', '2020-12-01', TRUE),
(13, 'reader3', 'reader3@example.com', 'hash13', 'Male', '1992-01-13', '2021-01-13', TRUE),
(14, 'reader4', 'reader4@example.com', 'hash14', 'Female', '1993-02-14', '2021-02-14', TRUE),
(15, 'reader5', 'reader5@example.com', 'hash15', 'Male', '1994-03-15', '2021-03-15', TRUE),
(16, 'reader6', 'reader6@example.com', 'hash16', 'Female', '1995-04-16', '2021-04-16', TRUE),
(17, 'reader7', 'reader7@example.com', 'hash17', 'Male', '1996-05-17', '2021-05-17', TRUE),
(18, 'reader8', 'reader8@example.com', 'hash18', 'Female', '1997-06-18', '2021-06-18', TRUE),
(19, 'reader9', 'reader9@example.com', 'hash19', 'Male', '1998-07-19', '2021-07-19', TRUE),
(20, 'reader10', 'reader10@example.com', 'hash20', 'Female', '1999-08-20', '2021-08-20', TRUE);

INSERT INTO Users (UserID, Username, Email, PasswordHash, Gender, DateOfBirth, JoinDate, IsActive)
VALUES
(777, 'admin777', 'admin777@example.com', 'hash777', 'Male', '1990-11-01', '2020-11-01', TRUE);

-- hash 값은 수정 필요

INSERT INTO Administrator (AdministratorID, Salary, Level)
VALUES (777, 6000, 2);

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

INSERT INTO Webtoons (WebtoonID, Title, AuthorID, PublishDate, PublishDay, ThumbnailURL)
VALUES
(1, '선천적 얼간이들', 1, '2023-01-01', 0, 'https://image-comic.pstatic.net/webtoon/478261/thumbnail/thumbnail_IMAG21_7fbd8610-0a97-40e3-9c63-101ea07fc4b4.jpg'),
(2, '신혼일기', 2, '2023-01-02', 0, 'https://image-comic.pstatic.net/webtoon/812354/thumbnail/thumbnail_IMAG21_f391c11a-9a74-4e0c-b601-2fcebafffd07.jpg'),
(3, 'Webtoon Title 3', 3, '2023-01-03', 1, 'https://example.com/thumbnail3.jpg'),
(4, 'Webtoon Title 4', 4, '2023-01-04', 1, 'https://example.com/thumbnail4.jpg'),
(5, 'Webtoon Title 5', 5, '2023-01-05', 2, 'https://example.com/thumbnail5.jpg'),
(6, 'Webtoon Title 6', 6, '2023-01-06', 3, 'https://example.com/thumbnail6.jpg'),
(7, 'Webtoon Title 7', 7, '2023-01-07', 3, 'https://example.com/thumbnail7.jpg'),
(8, 'Webtoon Title 8', 8, '2023-01-08', 4, 'https://example.com/thumbnail8.jpg'),
(9, 'Webtoon Title 9', 9, '2023-01-09', 5, 'https://example.com/thumbnail9.jpg'),
(10, 'Webtoon Title 10', 10, '2023-01-10', 6, 'https://example.com/thumbnail10.jpg');

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

INSERT INTO Readers (ReaderID, CookieAmount)
VALUES
(11, 100),
(12, 150),
(13, 200),
(14, 250),
(15, 300),
(16, 350),
(17, 400),
(18, 450),
(19, 500),
(20, 550);

INSERT INTO AuthorsWebtoons (AuthorWebtoonID, WebtoonID, AuthorID)
VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 2),
(4, 4, 2),
(5, 5, 3),
(6, 6, 3),
(7, 7, 4),
(8, 8, 4),
(9, 9, 5),
(10, 10, 5);

INSERT INTO Episodes (EpisodeID, WebtoonID, Title, ReleaseDate, ThumbnailURL, EpisodeIndex)
VALUES
(1, 1, 'EP.0_예고편', '2023-01-01', 'https://image-comic.pstatic.net/webtoon/478261/1/inst_thumbnail_20120614155000.jpg', 1),
(2, 1, 'EP.1_할로 애부리완', '2023-01-08', 'https://image-comic.pstatic.net/webtoon/478261/2/inst_thumbnail_20120620162422.jpg', 2),
(3, 1, 'Episode 3', '2023-01-15', 'https://example.com/ep_thumbnail3.jpg', 3),
(4, 1, 'Episode 4', '2023-01-22', 'https://example.com/ep_thumbnail4.jpg', 4),
(5, 1, 'Episode 5', '2023-01-29', 'https://example.com/ep_thumbnail5.jpg', 5),
(6, 1, 'Episode 6', '2023-02-05', 'https://example.com/ep_thumbnail6.jpg', 6),
(7, 1, 'Episode 7', '2023-02-12', 'https://example.com/ep_thumbnail7.jpg', 7),
(8, 1, 'Episode 8', '2023-02-19', 'https://example.com/ep_thumbnail8.jpg', 8),
(9, 1, 'Episode 9', '2023-02-26', 'https://example.com/ep_thumbnail9.jpg', 9),
(10, 1, 'Episode 10', '2023-03-05', 'https://example.com/ep_thumbnail10.jpg', 10);

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
(1, 1, 1, 'https://image-comic.pstatic.net/webtoon/478261/1/20200225203040_366e893e3f04a79be7fb8ca7d9551548_IMAG01_1.jpg'),
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

-- webtoon avg rating webtoonID 1을 제외하고는 가짜 데이터
INSERT INTO WebtoonAvgRating (WebtoonAvgRatingID, WebtoonID, Rating)
VALUES
(1, 1, 8.9),
(2, 2, 7.5),
(3, 3, 8.2),
(4, 4, 7.8),
(5, 5, 8.0),
(6, 6, 8.3),
(7, 7, 7.9),
(8, 8, 8.1),
(9, 9, 7.6),
(10, 10, 8.4);

-- token hash화 해야함.
INSERT INTO UserTokens (Token, UserID, Expiration, CreationDate)
VALUES
('token1', 1, '2023-12-16 16:20:34', '2023-12-09 16:20:34'),
('token2', 2, '2023-12-17 16:20:34', '2023-12-10 16:20:34'),
('token3', 3, '2023-12-18 16:20:34', '2023-12-11 16:20:34'),
('token4', 4, '2023-12-19 16:20:34', '2023-12-12 16:20:34'),
('token5', 5, '2023-12-20 16:20:34', '2023-12-13 16:20:34'),
('token6', 6, '2023-12-21 16:20:34', '2023-12-14 16:20:34'),
('token7', 7, '2023-12-22 16:20:34', '2023-12-15 16:20:34'),
('token8', 8, '2023-12-23 16:20:34', '2023-12-16 16:20:34'),
('token9', 9, '2023-12-24 16:20:34', '2023-12-17 16:20:34'),
('token10', 10, '2023-12-25 16:20:34', '2023-12-18 16:20:34');

INSERT INTO ReaderSearch (ReaderSearchID, ReaderID, CreationDate, SearchKeyword)
VALUES
(1, 11, NOW(), '소년왕도물'),
(2, 12, NOW(), '액션'),
(3, 13, NOW(), '이능력배틀물'),
(4, 14, NOW(), '판타지'),
(5, 15, NOW(), '고인물'),
(6, 16, NOW(), '사이다'),
(7, 17, NOW(), '드라마'),
(8, 18, NOW(), '세계관'),
(9, 19, NOW(), '소설원작'),
(10, 20, NOW(), '먼치킨');

INSERT INTO ReaderPaymentMethods (ReaderPaymentMethodID, ReaderID, PaymentMethodDetails)
VALUES
(1, 11, 'MTExMS0xMTExLTExMTEtMTExMQ=='),  -- Decode this Base64 string for actual details
(2, 12, 'MjIyMi0yMjIyLTIyMjItMjIyMg=='),  -- 우선 카드 번호를 encode 했다고 가정하고 작성함
(3, 13, 'MzMzMy0zMzMzLTMzMzMtMzMzMw=='),
(4, 14, 'NDQ0NC00NDQ0LTQ0NDQtNDQ0NA=='),
(5, 15, 'NTU1NS01NTU1LTU1NTUtNTU1NQ=='),
(6, 16, 'NjY2Ni02NjY2LTY2NjYtNjY2Ng=='),
(7, 17, 'Nzc3Ny03Nzc3LTc3NzctNzc3Nw=='),
(8, 18, 'ODg4OC04ODg4LTg4ODgtODg4OA=='),
(9, 19, 'OTk5OS05OTk5LTk5OTktOTk5OQ=='),
(10, 20, 'MDAwMC0wMDAwLTAwMDAtMDAwMA==');

INSERT INTO ReaderCookiePurchases (ReaderCookiePurchaseID, ReaderID, Amount, Date, ReaderPaymentMethodID)
VALUES
(1, 11, 150, '2023-01-15', 1),
(2, 12, 180, '2023-02-23', 2),
(3, 13, 250, '2023-03-03', 3),
(4, 14, 270, '2023-04-04', 4),
(5, 15, 310, '2023-05-05', 5),
(6, 16, 355, '2023-06-06', 6),
(7, 17, 405, '2023-07-07', 7),
(8, 18, 460, '2023-08-08', 8),
(9, 19, 505, '2023-09-09', 9),
(10, 20, 560, '2023-10-10', 10);

INSERT INTO ReaderCookieUse (ReaderCookieUseID, ReaderID, Amount, Date)
VALUES
(1, 11, 50, NOW()),
(2, 12, 30, NOW()),
(3, 13, 50, NOW()),
(4, 14, 20, NOW()),
(5, 15, 10, NOW()),
(6, 16, 5, NOW()),
(7, 17, 5, NOW()),
(8, 18, 10, NOW()),
(9, 19, 5, NOW()),
(10, 20, 10, NOW());

INSERT INTO ReaderBookmark (ReaderBookmarkID, ReaderID, WebtoonID, EpisodeID)
VALUES
(1, 11, 1, 10),
(2, 12, 1, 2),
(3, 13, 1, 3),
(4, 14, 1, 4),
(5, 15, 1, 5),
(6, 16, 1, 6),
(7, 17, 1, 7),
(8, 18, 1, 8),
(9, 19, 1, 9),
(10, 20, 1, 1);

INSERT INTO Reading (ReadingID, ReaderID, EpisodeID, ReadDate)
VALUES
(1, 11, 1, '2023-03-06'),
(2, 11, 2, '2023-03-07'),
(3, 11, 3, '2023-03-08'),
(4, 11, 4, '2023-03-09'),
(5, 11, 5, '2023-03-10'),
(6, 11, 6, '2023-03-11'),
(7, 11, 7, '2023-03-12'),
(8, 11, 8, '2023-03-13'),
(9, 11, 9, '2023-03-14'),
(10, 11, 10, '2023-03-15');

INSERT INTO Comments (CommentID, EpisodeID, ReaderID, CommentText, Timestamp, ParentCommentID)
VALUES
(1, 1, 11, '나 뉴진스 하니인데 개추눌렀다.', NOW(), -1),
(2, 1, 12, '하니는 그런 말투 안써요', NOW(), 1),
(3, 1, 13, '나 민지인데 하니 그런 말 쓴다.', NOW(), 1),
(4, 1, 14, '이런 잦은 휴재 속 꾸준한 웹툰을 보니 문득.. 새삼스럽게.. 대단하다는 생각이든다.', NOW(), -1),
(5, 1, 15, '기습숭배..!', NOW(), 4),
(6, 1, 16, '문득, 새삼스럽게, 대단 금지', NOW(), 4),
(7, 1, 17, '와 님들 제가 예상해봤는데 주인공은 사실 죽지 않음. 왜냐하면 주인공 죽으면 특정 연기가 보여야함.', NOW(), -1),
(8, 1, 18, '와 쿠키 쓰고 예상한척 ㅋㅋ', NOW(), 7),
(9, 1, 19, '헉.', NOW(), 7),
(10, 1, 20, '좋아쒀. 다음화 빠르게 진행시켜.', NOW(), -1);

-- CommentID가 1, 2, 4, 10인 댓글에 대해 Good 타입의 튜플 10개 이상 생성
INSERT INTO CommentsLikes (LikeID, ReaderID, CommentID, LikeType)
VALUES
-- CommentID가 1
(1, 11, 1, 'Good'),
(2, 12, 1, 'Good'),
(3, 13, 1, 'Good'),
(4, 14, 1, 'Good'),
(5, 15, 1, 'Good'),
(6, 16, 1, 'Good'),
(7, 17, 1, 'Good'),
(8, 18, 1, 'Good'),
(9, 19, 1, 'Good'),
(10, 20, 1, 'Good'),
-- CommentID가 2
(11, 11, 2, 'Good'),
(12, 12, 2, 'Good'),
(13, 13, 2, 'Good'),
-- CommentID가 4
(14, 14, 4, 'Good'),
(15, 15, 4, 'Good'),
-- CommentID가 10
(16, 16, 10, 'Good'),
(17, 17, 10, 'Good'),
(18, 18, 10, 'Good'),
(19, 19, 10, 'Good'),
(20, 20, 10, 'Good');


-- 그저 예쁜 merge를 위한 꼼수

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

INSERT INTO Notice (NoticeID, Title, Content, PostedDate, AdminID, IsActive) VALUES
(1, 'Important Update', 'We have an important update for our users.', '2023-01-01', 777, TRUE),
(2, 'New Webtoon Release', 'Check out our latest webtoon release!', '2023-02-15', 777, TRUE),
(3, 'Maintenance Notice', 'Scheduled maintenance on our platform.', '2023-03-10', 777, TRUE),
(4, 'Upcoming Event', 'Get ready for our upcoming event!', '2023-04-05', 777, TRUE),
(5, 'System Upgrade', 'Our system will undergo an upgrade this weekend.', '2023-05-20', 777, TRUE),
(6, 'Holiday Closure', 'Our services will be closed for the holiday.', '2023-07-01', 777, TRUE),
(7, 'Community Poll', 'Share your thoughts in our community poll!', '2023-08-10', 777, TRUE),
(8, 'Bug Fix', 'We have fixed several bugs on our platform.', '2023-09-15', 777, TRUE),
(9, 'New Feature Announcement', 'Exciting new features are coming soon!', '2023-10-10', 777, TRUE),
(10, 'Thank You for Your Support', 'We appreciate your continued support!', '2023-12-01', 777, TRUE);

INSERT INTO UserNoticeRead (ReaderID, NoticeID) VALUES
(11, 1),
(12, 1),
(13, 2),
(14, 3),
(15, 4),
(11, 5),
(12, 6),
(13, 7),
(14, 8),
(15, 9);

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

DROP FUNCTION IF EXISTS CalculateNoticeReadRatio;

DELIMITER //
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

DROP FUNCTION IF EXISTS GetMaleSubscriberRatio;

DELIMITER $$
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

DROP FUNCTION IF EXISTS CalculateReaderRemainingCookie;

DELIMITER //
CREATE FUNCTION CalculateReaderRemainingCookie(rId INT) RETURNS INT
BEGIN
    DECLARE purchased INT;
    DECLARE used INT;

    SELECT sum(Amount) into purchased
    from ReaderCookiePurchases RCP where ReaderID = rId group by ReaderID;

    SELECT sum(Amount) into used
    from ReaderCookieUse RCU where ReaderID = rId group by ReaderID;

    RETURN purchased - used;
END //

DELIMITER ;


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



-- 클라이언트의 회원 탈퇴 요청을 아래와 같은 쿼리로 서버에서 처리해줘야함.
-- UPDATE Users
-- SET IsActive = 0,
--     Username = ''Unknown''
-- WHERE UserID = 11;
--

DROP TRIGGER IF EXISTS AfterReaderDeactivation;
DELIMITER $$
CREATE TRIGGER AfterReaderDeactivation
AFTER UPDATE ON Users
FOR EACH ROW
BEGIN
    IF OLD.IsActive <> NEW.IsActive AND NEW.IsActive = FALSE THEN
        IF EXISTS (SELECT * FROM Readers WHERE ReaderID = NEW.UserID) THEN
            CALL DeactivateReader(NEW.UserID);
        END IF;
    END IF;
END$$
DELIMITER ;

DROP TRIGGER IF EXISTS AfterAuthorDeactivation;
DELIMITER $$
CREATE TRIGGER AfterAuthorDeactivation
AFTER UPDATE ON Users
FOR EACH ROW
BEGIN
    IF OLD.IsActive <> NEW.IsActive AND NEW.IsActive = FALSE THEN
        IF EXISTS (SELECT * FROM Authors WHERE AuthorID = NEW.UserID) THEN
            CALL DeactivateAuthor(NEW.UserID);
        END IF;
    END IF;
END$$
DELIMITER ;

DROP TRIGGER IF EXISTS CookieAmountUpdatePurchase_INSERT;
DELIMITER $$
CREATE TRIGGER CookieAmountUpdatePurchase_INSERT
AFTER INSERT ON ReaderCookiePurchases
FOR EACH ROW
BEGIN
	UPDATE Readers SET CookieAmount=(SELECT CalculateReaderRemainingCookie(NEW.ReaderID)) WHERE ReaderID=NEW.ReaderID;
END;$$
DELIMITER ;

DROP TRIGGER IF EXISTS CookieAmountUpdatePurchase_UPDATE;
DELIMITER $$
CREATE TRIGGER CookieAmountUpdatePurchase_UPDATE
AFTER UPDATE ON ReaderCookiePurchases
FOR EACH ROW
BEGIN
	UPDATE Readers SET CookieAmount=(SELECT CalculateReaderRemainingCookie(NEW.ReaderID)) WHERE ReaderID=NEW.ReaderID;
END;$$
DELIMITER ;

DROP TRIGGER IF EXISTS CookieAmountUpdatePurchase_DELETE;
DELIMITER $$
CREATE TRIGGER CookieAmountUpdatePurchase_DELETE
AFTER DELETE ON ReaderCookiePurchases
FOR EACH ROW
BEGIN
	UPDATE Readers SET CookieAmount=(SELECT CalculateReaderRemainingCookie(OLD.ReaderID)) WHERE ReaderID=OLD.ReaderID;
END;$$
DELIMITER ;