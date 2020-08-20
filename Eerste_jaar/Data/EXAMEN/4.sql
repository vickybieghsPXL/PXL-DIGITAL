CREATE OR REPLACE VIEW subscriber_vu AS
        SELECT subscriber_name, subscriber_firstname, nvl2(email, email, '0000') as "EMAIL"
        FROM subscribers
        WITH CHECK OPTION CONSTRAINT niks_wijzigen;