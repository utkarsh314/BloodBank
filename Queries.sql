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
    `bms_donor`(
        `first_name`,
        `last_name`,
        `age`,
        `gender`,
        `medical_history`,
        `A`,
        `B`,
        `Rh`
    )
VALUES
    ('testp', 'test', 18, 'M', '', 1, 1, 1);

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

-- List of all donors with their contacts and donation histories
SELECT
    `donor`.`id`,
    `first_name`,
    `last_name`,
    `age`,
    `gender`,
    `medical_history`,
    CONCAT_WS(
        '',
        IF(NOT A AND NOT B, 'O', NULL),
        IF(A, 'A', NULL),
        IF(B, 'B', NULL),
        IF(Rh, '+', '-')
    ) as `blood group`, -- generate blood group string from A, B, Rh
    GROUP_CONCAT(DISTINCT contact) as `contacts`, -- All contacts of a donor
    GROUP_CONCAT(
        CONCAT(date_donated, ': ', quantity_donated, ' units')
        ORDER BY `date_donated` 
        SEPARATOR ', '
    ) as `donation_history` -- donation history, sorted by date, with number of units donated
FROM
    `bms_donor` donor
    JOIN `bms_donorcontact` ON `donor`.`id` = `bms_donorcontact`.`donor_id`
    JOIN `bms_sample` ON `donor`.`id` = `bms_sample`.`donor_id`
GROUP BY
    `donor`.`id`;

-- Add new blood units to the inventory
INSERT INTO
    `bms_sample`(
        `donor_id`,
        `date_donated`,
        `location`,
        `quantity_donated`,
        `quantity_available`
    )
VALUES
    (2, '2023-04-11', 'ABC Hospital', 5, 5);

-- Update inventory after a donation
START TRANSACTION;

UPDATE
    `bms_sample`
SET
    `quantity_available` = `quantity_available` - 2 -- decreasing the available quantity in the inventory by 2
WHERE
    `bms_sample`.`id` = 1;

INSERT INTO
    `bms_donation`(
        `date_used`,
        `quantity_used`,
        `sample_id`,
        `patient_id`
    )
VALUES
    ('2023-04-11', 2, 1, 1);

-- A donation of two units from sample 1 to patient 1
COMMIT;