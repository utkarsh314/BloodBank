--
-- Create model Donor
--
CREATE TABLE `bms_donor` (
    `id` bigint AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `first_name` varchar(20) NOT NULL,
    `last_name` varchar(20) NOT NULL,
    `age` integer UNSIGNED NOT NULL CHECK (`age` >= 0),
    `gender` varchar(1) NOT NULL,
    `medical_history` longtext NOT NULL,
    `A` bool NOT NULL,
    `B` bool NOT NULL,
    `Rh` bool NOT NULL
);

--
-- Create model Patient
--
CREATE TABLE `bms_patient` (
    `id` bigint AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `first_name` varchar(20) NOT NULL,
    `last_name` varchar(20) NOT NULL,
    `age` integer UNSIGNED NOT NULL CHECK (`age` >= 0),
    `gender` varchar(1) NOT NULL,
    `medical_history` longtext NOT NULL,
    `A` bool NOT NULL,
    `B` bool NOT NULL,
    `Rh` bool NOT NULL
);

--
-- Create model Sample
--
CREATE TABLE `bms_sample` (
    `id` bigint AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `date_donated` date NOT NULL,
    `location` varchar(50) NOT NULL,
    `quantity_donated` integer UNSIGNED NOT NULL CHECK (`quantity_donated` >= 0),
    `quantity_available` integer UNSIGNED NOT NULL CHECK (`quantity_available` >= 0),
    `donor_id` bigint NOT NULL
);

--
-- Create model Donation
--
CREATE TABLE `bms_donation` (
    `id` bigint AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `date_used` date NOT NULL,
    `quantity_used` integer UNSIGNED NOT NULL CHECK (`quantity_used` >= 0),
    `patient_id` bigint NOT NULL,
    `sample_id` bigint NOT NULL
);

ALTER TABLE
    `bms_sample`
ADD
    CONSTRAINT `bms_sample_donor_id_8055285f_fk_bms_donor_id` FOREIGN KEY (`donor_id`) REFERENCES `bms_donor` (`id`);

ALTER TABLE
    `bms_donation`
ADD
    CONSTRAINT `bms_donation_patient_id_61e4c695_fk_bms_patient_id` FOREIGN KEY (`patient_id`) REFERENCES `bms_patient` (`id`);

ALTER TABLE
    `bms_donation`
ADD
    CONSTRAINT `bms_donation_sample_id_17da77c2_fk_bms_sample_id` FOREIGN KEY (`sample_id`) REFERENCES `bms_sample` (`id`);