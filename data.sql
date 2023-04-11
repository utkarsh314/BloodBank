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
    ('test', 'test', 18, 'M', '', 1, 1, 1),
    ('utkarsh', 'sharma', 19, 'M', '', 0, 1, 1),
    ('harshith', 'vasireddy', 18, 'M', '', 0, 0, 0),
    ('testa', 'test', 32, 'F', '', 1, 0, 1),
    ('testu', 'test', 28, 'F', '', 1, 1, 0),
    ('testi', 'test', 18, 'M', '', 0, 1, 1);

INSERT INTO
    `bms_sample`(
        `donor_id`,
        `date_donated`,
        `location`,
        `quantity_donated`,
        `quantity_available`
    )
VALUES
    (1, '2023-04-11', 'ABC Hospital', 5, 5),
    (2, '2023-04-03', 'DEF Hospital', 2, 2),
    (3, '2022-01-01', 'GHI Hospital', 1, 1),
    (4, '2023-04-07', 'JKL Hospital', 6, 6),
    (5, '2023-04-05', 'MNO Hospital', 5, 5),
    (3, '2023-04-02', 'ABC Hospital', 4, 4);

INSERT INTO
    `bms_patient`(
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
    ('test', 'test', 18, 'M', '', 1, 1, 1),
    ('prateek', 'kashyap', 19, 'M', '' 0, 1, 1),
    ('shwetabh', 'niket', 18, 'M', '', 0, 0, 0),
    ('testo', 'test', 32, 'F', '', 1, 0, 1),
    ('testy', 'test', 28, 'F', '', 1, 1, 0),
    ('testq', 'test', 18, 'M', '', 0, 1, 1);

START TRANSACTION;

UPDATE
    `bms_sample`
SET
    `quantity_available` = `quantity_available` - 1 -- decreasing the available quantity in the inventory by 2
WHERE
    `bms_sample`.`id` IN (1,2,4,5,6);

INSERT INTO
    `bms_donation`(
        `date_used`,
        `quantity_used`,
        `sample_id`,
        `patient_id`
    )
VALUES
    ('2023-04-11', 1, 1, 1),
    ('2023-04-10', 1, 2, 2),
    ('2023-04-09', 1, 4, 3),
    ('2023-04-08', 1, 5, 4),
    ('2023-04-07', 1, 6, 5);
COMMIT;