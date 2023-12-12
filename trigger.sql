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
