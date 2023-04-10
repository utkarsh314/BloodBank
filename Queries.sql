-- Donors with AB+ blood group
SELECT
    *
FROM
    `bms_donor`
WHERE
    (
        `bms_donor`.`A` = True
        AND `bms_donor`.`B` = True
        AND `bms_donor`.`Rh` = True
    );

-- Add a new blood donor
INSERT INTO
    `bms_donor`
VALUES
    ('test', 'test', 18, 'M', '', 1, 1, 1);

-- Update the information of a donor with a given ID
UPDATE
    `bms_donor`
SET
    `medical_history` = 'abc'
WHERE
    `bms_donor`.`id` = 1;

-- Delete the information of a specific donor
DELETE FROM
    `bms_donor`
WHERE
    `bms_donor`.`id` = 1;

-- List of all blood samples about to expire in the next 30 days
SELECT
    *
FROM
    `bms_sample`
WHERE
    (
        `bms_sample`.`date_donated` >= DATE_SUB(CURDATE(), INTERVAL 42 DAY)
        AND `bms_sample`.`date_donated` <= DATE_SUB(CURDATE(), INTERVAL 12 DAY)
    );

-- List of all blood samples with their availability status
SELECT
    `date_donated`,
    `location`,
    `quantity_donated`,
    `quantity_available`,
    `donor_id`,
    CASE
        WHEN DATEDIFF(CURDATE(), `date_donated`) <= 42 THEN 'available'
        ELSE 'expired'
    END AS `status`
FROM
    `bms_sample`;

-- List of all donors with their contacts and donaion histories
-- SELECT
--     `first_name`,
--     `last_name`,
--     `age`,
--     `gender`,
--     `medical_history`,
--     GROUP_CONCAT (contact) as `contacts`,
--     `quantity_donated`,
--     `date_donated`
-- FROM
--     `bms_donor`
--     JOIN `bms_donorcontact` ON `id` = `donor_id`
--     JOIN `bms_sample` ON id = `donor_id`
-- GROUP BY
--     `id`