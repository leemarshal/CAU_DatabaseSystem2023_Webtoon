DROP TRIGGER IF EXISTS AfterUserDeactivation;
DELIMITER $$
CREATE TRIGGER AfterUserDeactivation
AFTER UPDATE ON Users
FOR EACH ROW
BEGIN
    IF OLD.isActive <> NEW.IsActive AND NEW.IsActive = FALSE THEN
        IF EXISTS (SELECT * FROM Readers WHERE ReaderID = NEW.UserID) THEN
            CALL DeactivateReader(NEW.UserID);
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