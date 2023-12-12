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

DROP TRIGGER IF EXISTS CookieAmountUpdatePurchase;
DELIMITER $$
CREATE TRIGGER CookieAmountUpdatePurchase
AFTER INSERT ON ReaderCookiePurchases
FOR EACH ROW
BEGIN
	UPDATE Readers SET CookieAmount=CookieAmount+NEW.Amount WHERE ReaderID=NEW.ReaderID;
END;$$
DELIMITER ;